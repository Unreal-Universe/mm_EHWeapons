class EHLinkFire extends tK_WeaponFire;

var EHLinkBeamEffect			Beam;
var class<EHLinkBeamEffect>	BeamEffectClass;

var Sound	MakeLinkSound;
var float	UpTime;
var Pawn	LockedPawn;
var float	LinkBreakTime;
var() float LinkBreakDelay;
var float	LinkScale[6];

var String MakeLinkForce;

var() class<DamageType> DamageType;
var() int Damage;
var() float MomentumTransfer;

var() float TraceRange;
var() float LinkFlexibility;
var float distToStop;

var		bool bDoHit;
var()	bool bFeedbackDeath;
var		bool bInitAimError;
var		bool bLinkFeedbackPlaying;
var		bool bStartFire;
var byte	LinkVolume;
var byte	SentLinkVolume;

var rotator DesiredAimError, CurrentAimError;

var sound BeamSounds[4];


simulated function DestroyEffects()
{
	super.DestroyEffects();

    if ( Level.NetMode != NM_Client )
    {
        if ( Beam != None )
            Beam.Destroy();
    }
}

simulated function bool myHasAmmo( EHLinkGun EHLinkGun )
{
	return (EHLinkGun.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}

simulated function Rotator	GetPlayerAim( vector StartTrace, float InAimError )
{
	return AdjustAim(StartTrace, InAimError);
}

simulated function float AdjustLinkDamage( EHLinkGun EHLinkGun, Actor Other, float Damage )
{
	return Damage * (1.5*EHLinkgun.Links+1);
}

simulated function ModeTick(float dt)
{
	local Vector StartTrace, EndTrace, V, X, Y, Z;
	local Vector HitLocation, HitNormal, EndEffect;
	local Actor Other;
	local Rotator Aim;
	local EHLinkGun EHLinkGun;
	local float Step, ls;
	local bot B;
	local bool bShouldStop, bIsHealingObjective;
	local int AdjustedDamage;
	local EHLinkBeamEffect LB;
	local DestroyableObjective HealObjective;
	local Vehicle LinkedVehicle;

    if ( !bIsFiring )
    {
		bInitAimError = true;
        return;
    }

    EHLinkGun = EHLinkGun(Weapon);

    if ( EHLinkGun.Links < 0 )
    {
        log("warning:"@Instigator@"EHlinkgun had"@EHLinkGun.Links@"links");
        EHLinkGun.Links = 0;
    }

    ls = LinkScale[Min(EHLinkGun.Links,5)];

    if ( myHasAmmo(EHLinkGun) && ((UpTime > 0.0) || (Instigator.Role < ROLE_Authority)) )
    {
        UpTime -= dt;

		// the to-hit trace always starts right in front of the eye
		EHLinkGun.GetViewAxes(X, Y, Z);
		StartTrace = GetFireStart( X, Y, Z);
        TraceRange = default.TraceRange + EHLinkGun.Links*250;

        if ( Instigator.Role < ROLE_Authority )
        {
			if ( Beam == None )
				foreach Weapon.DynamicActors(class'EHLinkBeamEffect', LB )
					if ( !LB.bDeleteMe && (LB.Instigator != None) && (LB.Instigator == Instigator) )
					{
						Beam = LB;
						break;
					}

			if ( Beam != None )
				LockedPawn = Beam.LinkedPawn;
		}

        if ( LockedPawn != None )
			TraceRange *= 1.5;

        if ( Instigator.Role == ROLE_Authority )
		{
		    if ( bDoHit )
			    EHLinkGun.ConsumeAmmo(ThisModeNum, AmmoPerFire);

			B = Bot(Instigator.Controller);
			if ( (B != None) && (PlayerController(B.Squad.SquadLeader) != None) && (B.Squad.SquadLeader.Pawn != None) )
			{
				if ( IsLinkable(B.Squad.SquadLeader.Pawn)
					&& (B.Squad.SquadLeader.Pawn.Weapon != None && B.Squad.SquadLeader.Pawn.Weapon.GetFireMode(1).bIsFiring)
					&& (VSize(B.Squad.SquadLeader.Pawn.Location - StartTrace) < TraceRange) )
				{
					Other = Weapon.Trace(HitLocation, HitNormal, B.Squad.SquadLeader.Pawn.Location, StartTrace, true);
					if ( Other == B.Squad.SquadLeader.Pawn )
					{
						B.Focus = B.Squad.SquadLeader.Pawn;
						if ( B.Focus != LockedPawn )
							SetLinkTo(B.Squad.SquadLeader.Pawn);
						B.SetRotation(Rotator(B.Focus.Location - StartTrace));
 						X = Normal(B.Focus.Location - StartTrace);
 					}
 					else if ( B.Focus == B.Squad.SquadLeader.Pawn )
						bShouldStop = true;
				}
 				else if ( B.Focus == B.Squad.SquadLeader.Pawn )
					bShouldStop = true;
			}
		}

		if ( LockedPawn != None )
		{
			EndTrace = LockedPawn.Location + LockedPawn.BaseEyeHeight*Vect(0,0,0.5); // beam ends at approx gun height
			if ( Instigator.Role == ROLE_Authority )
			{
				V = Normal(EndTrace - StartTrace);
				if ( (V dot X < LinkFlexibility) || LockedPawn.Health <= 0 || LockedPawn.bDeleteMe || (VSize(EndTrace - StartTrace) > 1.5 * TraceRange) )
				{
					SetLinkTo( none );
				}
			}
		}

        if ( LockedPawn == None )
        {
            if ( Bot(Instigator.Controller) != None )
            {
				if ( bInitAimError )
				{
					CurrentAimError = AdjustAim(StartTrace, AimError);
					bInitAimError = false;
				}
				else
				{
					BoundError();
					CurrentAimError.Yaw = CurrentAimError.Yaw + Instigator.Rotation.Yaw;
				}

				// smooth aim error changes
				Step = 7500.0 * dt;
				if ( DesiredAimError.Yaw ClockWiseFrom CurrentAimError.Yaw )
				{
					CurrentAimError.Yaw += Step;
					if ( !(DesiredAimError.Yaw ClockWiseFrom CurrentAimError.Yaw) )
					{
						CurrentAimError.Yaw = DesiredAimError.Yaw;
						DesiredAimError = AdjustAim(StartTrace, AimError);
					}
				}
				else
				{
					CurrentAimError.Yaw -= Step;
					if ( DesiredAimError.Yaw ClockWiseFrom CurrentAimError.Yaw )
					{
						CurrentAimError.Yaw = DesiredAimError.Yaw;
						DesiredAimError = AdjustAim(StartTrace, AimError);
					}
				}
				CurrentAimError.Yaw = CurrentAimError.Yaw - Instigator.Rotation.Yaw;
				if ( BoundError() )
					DesiredAimError = AdjustAim(StartTrace, AimError);
				CurrentAimError.Yaw = CurrentAimError.Yaw + Instigator.Rotation.Yaw;

				if ( Instigator.Controller.Target == None )
					Aim = Rotator(Instigator.Controller.FocalPoint - StartTrace);
				else
					Aim = Rotator(Instigator.Controller.Target.Location - StartTrace);

				Aim.Yaw = CurrentAimError.Yaw;

				// save difference
				CurrentAimError.Yaw = CurrentAimError.Yaw - Instigator.Rotation.Yaw;
			}
			else
	            Aim = GetPlayerAim(StartTrace, AimError);

            X = Vector(Aim);
            EndTrace = StartTrace + TraceRange * X;
        }

        Other = Weapon.Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);
        if ( Other != None && Other != Instigator )
			EndEffect = HitLocation;
		else
			EndEffect = EndTrace;

		if ( Beam != None )
			Beam.EndEffect = EndEffect;

		if ( Instigator.Role < ROLE_Authority )
		{
			if ( EHLinkGun.ThirdPersonActor != None )
			{
				if ( EHLinkGun.Linking || ((Other != None) && (Instigator.PlayerReplicationInfo.Team != None) && Other.TeamLink(Instigator.PlayerReplicationInfo.Team.TeamIndex)) )
				{
					if (Instigator.PlayerReplicationInfo.Team == None || Instigator.PlayerReplicationInfo.Team.TeamIndex == 0)
						EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Red );
					else
						EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Blue );
				}
				else
				{
					if ( EHLinkGun.Links > 0 )
						EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Gold );
					else
						EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Green );
				}
			}
			return;
		}
        if ( Other != None && Other != Instigator )
        {
            // target can be linked to
            if ( IsLinkable(Other) )
            {
                if ( Other != lockedpawn )
                    SetLinkTo( Pawn(Other) );

                if ( lockedpawn != None )
                    LinkBreakTime = LinkBreakDelay;
            }
            else
            {
                // stop linking
                if ( lockedpawn != None )
                {
                    if ( LinkBreakTime <= 0.0 )
                        SetLinkTo( None );
                    else
                        LinkBreakTime -= dt;
                }

                // beam is updated every frame, but damage is only done based on the firing rate
                if ( bDoHit )
                {
                    if ( Beam != None )
						Beam.bLockedOn = false;

                    Instigator.MakeNoise(1.0);

                    AdjustedDamage = AdjustLinkDamage( EHLinkGun, Other, Damage );

                    if ( !Other.bWorldGeometry )
                    {
                        if ( Level.Game.bTeamGame && Pawn(Other) != None && Pawn(Other).PlayerReplicationInfo != None
							&& Pawn(Other).PlayerReplicationInfo.Team == Instigator.PlayerReplicationInfo.Team) // so even if friendly fire is on you can't hurt teammates
                            AdjustedDamage = 0;

						HealObjective = DestroyableObjective(Other);
						if ( HealObjective == None )
							HealObjective = DestroyableObjective(Other.Owner);
						if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
						{
							SetLinkTo(None);
							bIsHealingObjective = true;
							if (!HealObjective.HealDamage(AdjustedDamage, Instigator.Controller, DamageType))
								EHLinkGun.ConsumeAmmo(ThisModeNum, -AmmoPerFire);
						}
						else
							Other.TakeDamage(AdjustedDamage, Instigator, HitLocation, MomentumTransfer*X, DamageType);

						if ( Beam != None )
							Beam.bLockedOn = true;
					}
				}
			}
		}

		// vehicle healing
		LinkedVehicle = Vehicle(LockedPawn);
		if ( LinkedVehicle != None && bDoHit )
		{
			AdjustedDamage = Damage * (1.5*EHLinkgun.Links+1) * Instigator.DamageScaling;
			if (Instigator.HasUDamage())
				AdjustedDamage *= 2;
			if (!LinkedVehicle.HealDamage(AdjustedDamage, Instigator.Controller, DamageType))
				EHLinkGun.ConsumeAmmo(ThisModeNum, -AmmoPerFire);
		}
		EHLinkGun(Weapon).Linking = (LockedPawn != None) || bIsHealingObjective;

		if ( bShouldStop )
			B.StopFiring();
		else
		{
			// beam effect is created and destroyed when firing starts and stops
			if ( (Beam == None) && bIsFiring )
			{
				Beam = Weapon.Spawn( BeamEffectClass, Instigator );
				// vary link volume to make sure it gets replicated (in case owning player changed it client side)
				if ( SentLinkVolume == Default.LinkVolume )
					SentLinkVolume = Default.LinkVolume + 1;
				else
					SentLinkVolume = Default.LinkVolume;
			}

			if ( Beam != None )
			{
				if ( EHLinkGun.Linking || ((Other != None) && (Instigator.PlayerReplicationInfo.Team != None) && Other.TeamLink(Instigator.PlayerReplicationInfo.Team.TeamIndex)) )
				{
					Beam.LinkColor = Instigator.PlayerReplicationInfo.Team.TeamIndex + 1;
					if ( EHLinkGun.ThirdPersonActor != None )
					{
						if ( Instigator.PlayerReplicationInfo.Team == None || Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
							EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Red );
						else
							EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Blue );
					}
				}
				else
				{
					Beam.LinkColor = 0;
					if ( EHLinkGun.ThirdPersonActor != None )
					{
						if ( EHLinkGun.Links > 0 )
							EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Gold );
						else
							EHLinkAttachment(EHLinkGun.ThirdPersonActor).SetLinkColor( LC_Green );
					}
				}

				Beam.Links = EHLinkGun.Links;
				Instigator.AmbientSound = BeamSounds[Min(Beam.Links,3)];
				Instigator.SoundVolume = SentLinkVolume;
				Beam.LinkedPawn = LockedPawn;
				Beam.bHitSomething = (Other != None);
				Beam.EndEffect = EndEffect;
			}
		}
    }
    else
        StopFiring();

    bStartFire = false;
    bDoHit = false;
}

simulated function UpdateLinkColor( EHLinkAttachment.ELinkColor color )
{
	if ( FlashEmitter == None )
		return;

	switch ( Color )
	{
		case LC_Green	: FlashEmitter.Skins[0] = Texture'mm_EHWeapons.EHWeaponSkinsB.LinkMuzGreen'; break;
		case LC_Gold	: FlashEmitter.Skins[0] = Texture'mm_EHWeapons.EHWeaponSkinsB.LinkMuzYellow';	break;
		case LC_Red		: FlashEmitter.Skins[0] = Texture'mm_EHWeapons.EHWeaponSkinsB.LinkMuzRed'; break;
		case LC_Blue	: FlashEmitter.Skins[0] = Texture'mm_EHWeapons.EHWeaponSkinsB.LinkMuzBlue'; break;
	}
}

function bool BoundError()
{
	CurrentAimError.Yaw = CurrentAimError.Yaw & 65535;
	if ( CurrentAimError.Yaw > 2048 )
	{
		if ( CurrentAimError.Yaw < 32768 )
		{
			CurrentAimError.Yaw = 2048;
			return true;
		}
		else if ( CurrentAimError.Yaw < 63487 )
		{
			CurrentAimError.Yaw = 63487;
			return true;
		}
	}
	return false;
}

event ModeDoFire()
{
	Load = 0; //don't use ammo here - it will be consumed in ModeTick() where it's sync'ed with damage dealing
	Super.ModeDoFire();
	if (LockedPawn != none)
	{
		doGrapplePull();
	}
}

function DoFireEffect()
{
    bDoHit = true;
    UpTime = FireRate+0.1;
}

function PlayFiring()
{
	if (EHLinkGun(Weapon).Links <= 0 && Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire)
		ClientPlayForceFeedback("BLinkGunBeam1");
    Super.PlayFiring();
}

function StopFiring()
{
	Instigator.AmbientSound = None;
	Instigator.SoundVolume = Instigator.Default.SoundVolume;
    if (Beam != None)
    {
        Beam.Destroy();
        Beam = None;
    }
    SetLinkTo(None);
    bStartFire = true;
    bFeedbackDeath = false;
    if (EHLinkGun(Weapon).Links <= 0)
		StopForceFeedback("BLinkGunBeam1");
}

function SetLinkTo(Pawn Other)
{
    if (LockedPawn != None && Weapon != None)
    {
        RemoveLink(1 + EHLinkGun(Weapon).Links, Instigator);
        EHLinkGun(Weapon).Linking = false;
    }

    LockedPawn = Other;

    if (LockedPawn != None)
    {
        if (!AddLink(1 + EHLinkGun(Weapon).Links, Instigator))
        {
            bFeedbackDeath = true;
        }
        EHLinkGun(Weapon).Linking = true;

        LockedPawn.PlaySound(MakeLinkSound, SLOT_None);
    }
}

function bool AddLink(int Size, Pawn Starter)
{
    local Inventory Inv;
    if (LockedPawn != None && !bFeedbackDeath)
    {
        if (LockedPawn == Starter)
        {
            return false;
        }
        else
        {
            Inv = LockedPawn.FindInventoryType(class'EHLinkGun');
            if (Inv != None)
            {
                if (EHLinkFire(EHLinkGun(Inv).GetFireMode(1)).AddLink(Size, Starter))
                    EHLinkGun(Inv).Links += Size;
                else
                    return false;
            }
        }
    }
    return true;
}

function RemoveLink(int Size, Pawn Starter)
{
    local Inventory Inv;
    if (LockedPawn != None && !bFeedbackDeath)
    {
        if (LockedPawn != Starter)
        {
            Inv = LockedPawn.FindInventoryType(class'EHLinkGun');
            if (Inv != None)
            {
                EHLinkFire(EHLinkGun(Inv).GetFireMode(1)).RemoveLink(Size, Starter);
                EHLinkGun(Inv).Links -= Size;
            }
        }
    }
}

function bool IsLinkable(Actor Other)
{
    local Pawn P;
    local EHLinkGun LG;
    local EHLinkFire LF;
    local int sanity;

    if ( Other.IsA('Pawn') && Other.bProjTarget )
    {
        P = Pawn(Other);
        if ( P.Weapon == None || !P.Weapon.IsA('EHLinkGun') )
		{
			if ( Vehicle(P) != None )
				return P.TeamLink( Instigator.GetTeamNum() );

            return false;
		}

        // pro-actively prevent link cycles from happening
        LG = EHLinkGun(P.Weapon);
        LF = EHLinkFire(LG.GetFireMode(1));
        while ( LF != None && LF.LockedPawn != None && LF.LockedPawn != P && sanity < 32 )
        {
            if ( LF.LockedPawn == Instigator )
                return false;

            LG = EHLinkGun(LF.LockedPawn.Weapon);
            if ( LG == None )
                break;
            LF = EHLinkFire(LG.GetFireMode(1));
            sanity++;
        }

        return ( Level.Game.bTeamGame && P.GetTeamNum() == Instigator.GetTeamNum() );
    }

    return false;
}

simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    return Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;
}

function StartBerserk()
{
	if ( (Level.GRI != None) && (Level.GRI.WeaponBerserk > 1.0) )
 		return;

	Damage = default.Damage * 1.33;
	Damage = default.Damage * 1.33;
}

function StopBerserk()
{
	if ( (Level.GRI != None) && (Level.GRI.WeaponBerserk > 1.0) )
 		return;

	Damage = default.Damage;
	Damage = default.Damage;
}
//////////////////

simulated function doGrapplePull()
{
    local Vector distance;

      if (Weapon.Owner.Physics == PHYS_Walking)
        	SetPlayerPhysics();

      	distance = LockedPawn.Location - Weapon.Owner.Location;
     	if (VSize(distance) <= distToStop)
     		gotoState('Swinging');
     	else {
     		gotoState('');
     		Weapon.Owner.Velocity = Normal(distance) * (VSize(Distance) - distToStop + (distToStop/3)) * 4;
     			//this math is important so that the player doesnt slow down too much
     	}
}

state Swinging
{

   simulated function BeginState()
   {
      Pawn(Weapon.Owner).bCanFly=True;
   }

   simulated function Tick(float DeltaTime)
   {
      local vector Direction;
      local vector PlayerV;
      local Vector deltavel;

        if (LockedPawn != None)	//this check gets us out of the state if needed
      	{
         SetPlayerPhysics();
         Direction = LockedPawn.Location - Owner.Location;
             Weapon.Owner.Velocity += DeltaVel;
             if ((Weapon.Owner.Velocity dot Direction) < 0)
             {
               PlayerV = (0.8*Direction*(Weapon.Owner.Velocity dot Direction)/(Direction dot Direction));
               Weapon.Owner.Velocity -= PlayerV;
             }
        }
        else
            GotoState('');
     }

     simulated function EndState()
     {
         Pawn(Weapon.Owner).bCanFly=False;
         SetPlayerPhysics();
     }
}

simulated function SetPlayerPhysics()
{
   if (weapon.Owner.PhysicsVolume.bWaterVolume)
      weapon.Owner.SetPhysics(PHYS_Swimming);
   else
      weapon.Owner.SetPhysics(PHYS_Falling);
}

defaultproperties
{
     BeamEffectClass=Class'mm_EHWeapons.EHLinkBeamEffect'
     MakeLinkSound=Sound'WeaponSounds.LinkGun.LinkActivated'
     LinkBreakDelay=0.500000
     LinkScale(1)=0.700000
     LinkScale(2)=1.200000
     LinkScale(3)=1.400000
     LinkScale(4)=1.600000
     LinkScale(5)=1.900000
     MakeLinkForce="LinkActivated"
     DamageType=Class'mm_EHWeapons.DamTypeEHLinkShaft'
     Damage=9
     MomentumTransfer=2000.000000
     TraceRange=1100.000000
     LinkFlexibility=0.640000
     distToStop=425.000000
     bInitAimError=True
     LinkVolume=240
     BeamSounds(0)=Sound'WeaponSounds.LinkGun.BLinkGunBeam1'
     BeamSounds(1)=Sound'WeaponSounds.LinkGun.BLinkGunBeam2'
     BeamSounds(2)=Sound'WeaponSounds.LinkGun.BLinkGunBeam3'
     BeamSounds(3)=Sound'WeaponSounds.LinkGun.BLinkGunBeam4'
     bPawnRapidFireAnim=True
     FireAnim="Idle"
     FireEndAnim=
     NoAmmoSound=ProceduralSound'WeaponSounds.PReload5.P1Reload5'
     FireRate=0.120000
     AmmoClass=Class'mm_EHWeapons.EHLinkAmmo'
     AmmoPerFire=1
     ShakeRotMag=(Z=60.000000)
     ShakeRotRate=(Z=4000.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Y=1.000000,Z=1.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=3.000000
     BotRefireRate=0.990000
     WarnTargetPct=0.200000
     FlashEmitterClass=Class'mm_EHWeapons.EHLinkMuzFlashBeam1st'
}
