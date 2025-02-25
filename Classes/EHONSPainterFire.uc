class EHONSPainterFire extends tK_PainterFire;

var EHONSPainterBeamEffect EHBeam;
var class<EHONSAutoBomber> BomberClass, MainBomberClass;
var float MinZDist, MaxZDist;
var Array<vector> BombersOffsets;
var() int bomberwingsize;

function DestroyEffects()
{
    if (EHBeam != None)
        EHBeam.Destroy();

    Super.DestroyEffects();
}

function bool SpawnBomber(rotator BombDirection)
{
	local vector BomberStart, BomberStart2, BombTargetCenter, HitNormal, Extent, Temp;
	local ONSAutoBomber Bomber;
//	local Rotator BomberDirection;
	local int i;
	local vector x, y, z;
	local array<EHONSAutoBomber> Bombers;
	local array<Vector>  BomberStarts;
	local array<Vector>  BombTargetCenters;

	BombDirection.Pitch = 0;
	Extent = BomberClass.default.CollisionRadius * vect(1,1,0);
	Extent.Z = BomberClass.default.CollisionHeight;
	if (Weapon.Trace(BombTargetCenter, HitNormal, MarkLocation + MaxZDist * vect(0,0,1), MarkLocation + Extent.Z * vect(0,0,2), false, Extent) == None)
		BombTargetCenter = MarkLocation + MaxZDist * vect(0,0,1);
	BombTargetCenter.Z -= BomberClass.default.CollisionHeight;
	if (VSize(BombTargetCenter - MarkLocation) < MinZDist)
		return false;

	if (Weapon.Trace(BomberStart, HitNormal, BombTargetCenter - vector(BombDirection) * 50000, BombTargetCenter, false, Extent) == None)
		BomberStart = BombTargetCenter - vector(BombDirection) * 100000;
	if (Weapon.Trace(BomberStart2, HitNormal, BombTargetCenter + vector(BombDirection) * 50000, BombTargetCenter, false, Extent) == None)
		BomberStart2 = BombTargetCenter + vector(BombDirection) * 100000;
	if (VSize(BomberStart - BombTargetCenter) < VSize(BomberStart2 - BombTargetCenter))
	{
		Temp = BomberStart;
		BomberStart = BomberStart2;
		BomberStart2 = Temp;
	}

	Bomber = Weapon.spawn(MainBomberClass, Instigator,, BomberStart, rotator(BombTargetCenter - BomberStart));
	if(Bomber == None)
	{
	return false;
	}
	BomberWingSize = EHONSAutoBomber(Bomber).BomberWingSize;
	EHONSAutoBomber(Bomber).GetViewAxes(X,Y,Z);

	if(bomberwingsize > 16)
	{
	bomberwingsize = 16;
	}
	Else if(bomberwingsize < 1)
	{
	bomberwingsize = 1;
	}

	for(i = 0; i < bomberwingsize; i ++)
	{
	BombersOffsets[i] = EHONSAutoBomber(Bomber).BombersOffsets[i];
	BomberStarts[i] = BomberStart + Y*BombersOffsets[i].Y + X* BombersOffsets[i].x + Z * BombersOffsets[i].Z;
	BombTargetCenters[i] = BombTargetCenter + Y* BombersOffsets[i].Y + Z * BombersOffsets[i].Z;
	}

	Bomber.Bomb(BombTargetCenter);


	for(i = 0; i < bomberwingsize; i ++)
	{
		Bombers[i] = Weapon.spawn(BomberClass, Instigator,, BomberStarts[i], rotator(BombTargetCenter - BomberStart));

		if (Bombers[i] != None)
		{
			Bombers[i].Bomb(BombTargetCenters[i]);
			EHONSAutoBomber(Bomber).Bombers[i] = Bombers[i];
		}
	}
	return true;
}

state Paint
{
    function BeginState()
    {
        IonCannon = None;

        if (Weapon.Role == ROLE_Authority)
        {
            if (EHBeam == None)
            {
                EHBeam = Weapon.Spawn(class'EHONSPainterBeamEffect', Instigator);
                EHBeam.bOnlyRelevantToOwner = true;
                EHBeam.EffectOffset = vect(-25, 35, 14);
            }
            bInitialMark = true;
            bValidMark = false;
            MarkTime = Level.TimeSeconds;
            SetTimer(0.25, true);
        }

        ClientPlayForceFeedback(TAGFireForce);
    }

    function ModeTick(float dt)
    {
        local Vector StartTrace, EndTrace, X,Y,Z;
        local Vector HitLocation, HitNormal;
        local Actor Other;
        local Rotator Aim;

        if (!bIsFiring)
        {
            StopFiring();
        }

        Weapon.GetViewAxes(X,Y,Z);

        // the to-hit trace always starts right in front of the eye
        StartTrace = Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;

	    Aim = AdjustAim(StartTrace, AimError);
        X = Vector(Aim);
        EndTrace = StartTrace + TraceRange * X;

        Other = Weapon.Trace(HitLocation, HitNormal, EndTrace, StartTrace, false);

        if (Other != None && Other != Instigator)
        {
            if ( bDoHit )
            {
                bValidMark = false;

                if (Other.bWorldGeometry)
                {
                    if (VSize(HitLocation - MarkLocation) < 50.0)
                    {
			            Instigator.MakeNoise(3.0);
                        if (Level.TimeSeconds - MarkTime > 0.3)
                        {
			                bValidMark = EHONSPainter(Weapon).CanBomb(HitLocation, BomberClass.default.CollisionRadius);

			                if (bValidMark)
			                    {
                                    if (Level.TimeSeconds - MarkTime > PaintDuration && SpawnBomber(Instigator.Rotation))
                                        {
				                            Instigator.PendingWeapon = None;
                                            EHONSPainter(Weapon).ReallyConsumeAmmo(ThisModeNum, 1);
                                            Instigator.Controller.ClientSwitchToBestWeapon();

                                            if (EHBeam != None)
                                                EHBeam.SetTargetState(PTS_Aquired);

                                            StopForceFeedback(TAGMarkForce);
                                            ClientPlayForceFeedback(TAGAquiredForce);

                                            StopFiring();
                                        }
                                    else
                                    {
                                        if (!bMarkStarted)
                                        {
					                        bMarkStarted = true;
					                        ClientPlayForceFeedback(TAGMarkForce);
				                        }
                                    }
                                }
                                else
                                {
                                    MarkTime = Level.TimeSeconds;
                                    bMarkStarted = false;
                                    if ( Bot(Instigator.Controller) != None )
                                    {
					                    Instigator.Controller.Focus = Instigator.Controller.Enemy;
	                    				MarkLocation = Bot(Instigator.Controller).Enemy.Location - Bot(Instigator.Controller).Enemy.CollisionHeight * vect(0,0,2);
	                    			}
                                }
                            }
                        }
                        else
                        {
			                bAlreadyMarked = true;
                            MarkTime = Level.TimeSeconds;
                            MarkLocation = HitLocation;
                            bValidMark = false;
                            bMarkStarted = false;
                        }
                    }
                    else
                    {
                        MarkTime = Level.TimeSeconds;
                        bValidMark = false;
                        bMarkStarted = false;
                }
                bDoHit = false;
            }

            EndEffect = HitLocation;
        }
        else
        {
            EndEffect = EndTrace;
        }

        EHONSPainter(Weapon).EndEffect = EndEffect;

        if (EHBeam != None)
        {
            EHBeam.EndEffect = EndEffect;
            if (bValidMark)
                EHBeam.SetTargetState(PTS_Marked);
            else
                EHBeam.SetTargetState(PTS_Aiming);
        }
    }

    function StopFiring()
    {
        bMarkStarted = false;
        if (EHBeam != None)
        {
            EHBeam.SetTargetState(PTS_Cancelled);
        }
        GotoState('');
    }
}

defaultproperties
{
     BomberClass=Class'mm_EHWeapons.EHONSAutoBomberB'
     MainBomberClass=Class'mm_EHWeapons.EHONSAutoBomber'
     MinZDist=5000.000000
     MaxZDist=10000.000000
     TraceRange=15000.000000
}
