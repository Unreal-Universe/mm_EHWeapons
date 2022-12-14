class EHPainterFire extends WeaponFire;

var EHPainterBeamEffect EHBeam;
var float UpTime;
var bool bDoHit;
var bool bValidMark;
var bool bInitialMark;
var bool bAlreadyMarked;
var bool bMarkStarted;

var EHIonCannon EHIonCannon;
var float MarkTime;
var Vector MarkLocation;
var() float TraceRange;
var() float PaintDuration;
var Vector EndEffect;

var() Sound MarkSound;
var() Sound AquiredSound;

var() String TAGFireForce;
var() String TAGMarkForce;
var() String TAGAquiredForce;

function DestroyEffects()
{
    if (EHBeam != None)
        EHBeam.Destroy();

    Super.DestroyEffects();
}

state Paint
{
	function Rotator AdjustAim(Vector Start, float InAimError)
	{
		local bool bRealAimHelp;
		local rotator Result;

		if ( Bot(Instigator.Controller) != None )
		{
			Instigator.Controller.Focus = None;
			if ( bAlreadyMarked )
				Instigator.Controller.FocalPoint = MarkLocation;
			else
				Instigator.Controller.FocalPoint = EHPainter(Instigator.Weapon).MarkLocation;
			return rotator(Instigator.Controller.FocalPoint - Start);
		}
		else
		{
			if ( PlayerController(Instigator.Controller) != None )
			{
				bRealAimHelp = PlayerController(Instigator.Controller).bAimingHelp;
				PlayerController(Instigator.Controller).bAimingHelp = false;
			}
			Result =  Global.AdjustAim(Start, InAimError);
			if ( PlayerController(Instigator.Controller) != None )
				PlayerController(Instigator.Controller).bAimingHelp = bRealAimHelp;
			return Result;
		}
	}

    function BeginState()
    {
        if (Weapon.Role == ROLE_Authority)
        {
            if (EHBeam == None)
            {
                EHBeam = Weapon.Spawn(class'EHPainterBeamEffect');
            }
            bInitialMark = true;
            bValidMark = false;
            MarkTime = Level.TimeSeconds;
            SetTimer(0.25, true);
        }

        ClientPlayForceFeedback(TAGFireForce);
    }

    function Timer()
    {
         bDoHit = true;
    }

    function ModeTick(float dt)
    {
        local Vector StartTrace, EndTrace, X,Y,Z;
        local Vector HitLocation, HitNormal;
        local Actor Other;
        local Rotator Aim;
        local bool bEngageCannon;

        //if (Weapon.Role < ROLE_Authority) return;
        // ---- server only from here on ---- //

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
                            bEngageCannon = (Level.TimeSeconds - MarkTime > PaintDuration);
                            if ( EHIonCannon == None )
								EHIonCannon = EHPainter(Weapon).CheckMark(HitLocation, bEngageCannon);

                            if ( (EHIonCannon != None) &&  EHIonCannon.CheckMark(Instigator,HitLocation,bEngageCannon))
                            {
                                if ( EHIonCannon.IsFiring() )
                                {
									Instigator.PendingWeapon = None;
                                    EHPainter(Weapon).ReallyConsumeAmmo(ThisModeNum, 1);
                                    Instigator.Controller.ClientSwitchToBestWeapon();

                                    if (EHBeam != None)
                                        EHBeam.SetTargetState(PTS_Aquired);

                                    StopForceFeedback(TAGMarkForce);
                                    ClientPlayForceFeedback(TAGAquiredForce);

                                    StopFiring();
                                }
                                else
                                {
                                    bValidMark = true;

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
                                bValidMark = false;
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

        EHPainter(Weapon).EndEffect = EndEffect;

        if (EHBeam != None)
        {
            EHBeam.EndEffect = EndEffect;
            if (bValidMark)
                EHBeam.SetTargetState(PTS_Marked);
            else
                EHBeam.SetTargetState(PTS_Aiming);
        }

        if ( EHIonCannon != None )
        {
            if ( bValidMark )
            {
			    if ( EHIonCannon.Fear == None )
			    {
				    EHIonCannon.Fear = Weapon.Spawn(class'AvoidMarker',,,MarkLocation);
				    EHIonCannon.Fear.SetCollisionSize(0.4 * EHIonCannon.DamageRadius,100);
					if ( (Instigator != None) && (Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) )
						EHIonCannon.Fear.TeamNum = Instigator.PlayerReplicationInfo.Team.TeamIndex;
				    EHIonCannon.Fear.StartleBots();
			    }
		    }
		    else if ( EHIonCannon.Fear != None )
		    	EHIonCannon.RemoveFear();
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

    function EndState()
    {
		bAlreadyMarked = false;
        SetTimer(0, false);
        StopForceFeedback(TAGFireForce);
    }
}

function DoFireEffect()
{
}

function ModeHoldFire()
{
    GotoState('Paint');
}

function StartBerserk()
{
}

function StopBerserk()
{
}

function StartSuperBerserk()
{
}

function vector GetFireStart(vector X, vector Y, vector Z)
{
    return Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;
}

function float MaxRange()
{
	return TraceRange;
}

defaultproperties
{
     TraceRange=10000.000000
     PaintDuration=1.200000
     MarkSound=Sound'WeaponSounds.TAGRifle.TAGFireB'
     AquiredSound=Sound'WeaponSounds.TAGRifle.TAGTargetAquired'
     TAGFireForce="TAGFireA"
     TAGMarkForce="TAGFireB"
     TAGAquiredForce="TAGAquire"
     bSplashDamage=True
     bRecommendSplashDamage=True
     bFireOnRelease=True
     FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'XWeapons.BallAmmo'
     AmmoPerFire=1
     BotRefireRate=1.000000
     WarnTargetPct=0.100000
}
