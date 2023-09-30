class EHAVRiLRocket extends Projectile;

var Emitter SmokeTrail;
var Effects Corona;
var float AccelerationAddPerSec;
var bool bLockedOn;
var float LeadTargetDelay; //don't lead target until missle has been flying for this many seconds
var float LeadTargetStartTime;
var actor OverrideTarget;
var Vehicle HomingTarget;
//ShakeViewcode//
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view

replication
{
	reliable if (bNetDirty && Role == ROLE_Authority)
		HomingTarget, OverrideTarget, bLockedOn;
}

simulated function Destroyed()
{
	// Turn off smoke emitters. Emitter should then destroy itself when all particles fade out.
	if ( SmokeTrail != None )
		SmokeTrail.Kill();

	if ( Corona != None )
		Corona.Destroy();

	PlaySound(Sound'mm_EHWeapons.EHSounds.AvrilExplosion',,3.5*TransientSoundVolume);
	if (!bNoFX && EffectIsRelevant(Location, false))
		spawn(class'EHAVRiLRocketExplosion',,, Location, rotator(vect(0,0,1)));
		Spawn(class'NewExpRing',,, Location, rotator(vect(0,0,1)));
	if (Instigator != None && Instigator.IsLocallyControlled() && Instigator.Weapon != None && !Instigator.Weapon.HasAmmo())
		Instigator.Weapon.DoAutoSwitch();
       	ShakeView();    //ShakeViewcode//
	//hack for crappy weapon firing sound
	if (ONSAVRiL(Owner) != None)
		ONSAVRiL(Owner).PlaySound(Sound'mm_EHWeapons.EHSounds.AvrilExplosion', SLOT_Interact, 0.01,, TransientSoundRadius);

	Super.Destroyed();
}

    function ShakeView()       //ShakeViewcode//
    {
        local Controller C;
        local PlayerController PC;
        local float Dist, Scale;

        for ( C=Level.ControllerList; C!=None; C=C.NextController )
        {
            PC = PlayerController(C);
            if ( PC != None && PC.ViewTarget != None )
            {
                Dist = VSize(Location - PC.ViewTarget.Location);
                if ( Dist < DamageRadius * 2.0)
                {
                    if (Dist < DamageRadius)
                        Scale = 1.0;
                    else
                        Scale = (DamageRadius*2.0 - Dist) / (DamageRadius);
                    C.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);
                }
            }
        }
    }

simulated function PostBeginPlay()
{
	local vector Dir;

	Dir = vector(Rotation);

	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'EHAvrilSmokeTrail',,,Location - 15 * Dir);
		SmokeTrail.Setbase(self);

		Corona = Spawn(class'EHAvrilCorona',self);
	}

	Velocity = speed * Dir;
	Acceleration = Dir;	//really small accel just to give it a direction for use later
	if (PhysicsVolume.bWaterVolume)
		Velocity=0.6*Velocity;
	if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}

	SetTimer(0.1, true);
	LeadTargetStartTime = Level.TimeSeconds + LeadTargetDelay;

	Super.PostBeginPlay();
}

simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	BlowUp(HitLocation);
	Destroy();
}

simulated function Timer()
{
    local vector Dir, ForceDir;
    local float VelMag, LowestDesiredZ;
    local array<Vehicle> TargetPawns;
    local bool bLastLockedOn;
    local int i;
	local actor NewTarget;

    if (Role == ROLE_Authority)
    {
    	if (OverrideTarget == none)
    	{
			if (Instigator != None && Instigator.Controller != None && EHAVRiL(Owner) != None)
			{
				bLastLockedOn = bLockedOn;
				bLockedOn = EHAVRiL(Owner).bLockedOn;
				HomingTarget = EHAVRiL(Owner).HomingTarget;
				if (!bLastLockedOn && bLockedOn)
				{
					if (HomingTarget != None && HomingTarget.Controller != None)
						HomingTarget.Controller.ReceiveProjectileWarning(self);
				}
			}
			else
				bLockedOn = false;
		}
		else
			bLockedOn = true;

		if (HomingTarget != None)
    	{
    		// Check to see if it's lock has changed
    		if ( !HomingTarget.VerifyLock(self,NewTarget) )
    			OverrideTarget = NewTarget;
			else
			{
                OverrideTarget = None;
				HomingTarget.IncomingMissile(self);

	    		//bots with nothing else to shoot at may attempt to shoot down incoming missles
	    		TargetPawns = HomingTarget.GetTurrets();
	    		TargetPawns[TargetPawns.length] = HomingTarget;
	    		for (i = 0; i < TargetPawns.length; i++)
					TargetPawns[i].ShouldTargetMissile(self);
	    	}
    	}
    }

    if (bLockedOn && ( HomingTarget != none || OverrideTarget != none) )
    {
		if (OverrideTarget != none)
		{
			if ( VSize(OverrideTarget.Location - Location ) < 256 )
			{
				OverrideTarget.Destroy();
				TakeDamage(20000,none, Location, Velocity, none);
				return;
			}
			NewTarget = OverrideTarget;
		}

		else
			NewTarget = HomingTarget;

    	// Do normal guidance to target.
		if ( Pawn(NewTarget) != None )
			Dir = Pawn(NewTarget).GetTargetLocation() - Location;
		else
    		Dir = NewTarget.Location - Location;
    	VelMag = VSize(Velocity);

		if (Level.TimeSeconds >= LeadTargetStartTime)
		{
	    	ForceDir = Dir + NewTarget.Velocity * VSize(Dir) / (VelMag * 2);

	    	if (Instigator != None)
				LowestDesiredZ = FMin(Instigator.Location.Z, NewTarget.Location.Z); //missle should avoid going any lower than this
			else
				LowestDesiredZ = NewTarget.Location.Z;

			if (ForceDir.Z + Location.Z < LowestDesiredZ)
	    		ForceDir.Z += LowestDesiredZ - (ForceDir.Z + Location.Z);

	    	ForceDir = Normal(ForceDir);
		}
		else
			ForceDir = Dir;

    	ForceDir = Normal(ForceDir * 0.8 * VelMag + Velocity);
    	Velocity =  VelMag * ForceDir;
    	Acceleration += 5 * ForceDir;

    	// Update rocket so it faces in the direction its going.
    	SetRotation(rotator(Velocity));
    }
}

simulated function Tick(float deltaTime)
{
	if (VSize(Velocity) >= MaxSpeed)
	{
		Acceleration = vect(0,0,0);
		disable('Tick');
	}
	else
		Acceleration += Normal(Velocity) * (AccelerationAddPerSec * deltaTime);
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	if (Damage > 0)
		Explode(HitLocation, vect(0,0,0));
}

simulated event PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)
{
	local PlayerController PC;
	if (bLockedOn)
	{
		PC = Level.GetLocalPlayerController();
		if (PC!=none && PC.Pawn != none && ONSWeaponPawn(PC.Pawn)!=none)
			ONSWeaponPawn(PC.Pawn).ProjectilePostRender2D(self, C, ScreenLocX, ScreenLocY);
	}
}

defaultproperties
{
     AccelerationAddPerSec=1400.000000
     LeadTargetDelay=1.000000
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     Speed=550.000000
     MaxSpeed=2800.000000
     Damage=125.000000
     DamageRadius=256.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'mm_EHWeapons.DamTypeEHAVRiLRocket'
     ExplosionDecal=Class'XEffects.ComboDecal'
     bScriptPostRender=True
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=5.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'VMWeaponsSM.AVRiLGroup.AVRiLprojectileSM'
     bDynamicLight=True
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     bIgnoreVehicles=True
     AmbientSound=Sound'mm_EHWeapons.EHSounds.EHAvrilProjectileLoop01'
     LifeSpan=7.000000
     DrawScale=0.200000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     AmbientGlow=96
     bProjTarget=True
     bUseCylinderCollision=False
     bFixedRotationDir=True
     RotationRate=(Roll=190000)
     DesiredRotation=(Roll=30000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
