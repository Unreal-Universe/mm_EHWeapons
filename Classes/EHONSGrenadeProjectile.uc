class EHONSGrenadeProjectile extends Projectile;

#exec OBJ LOAD FILE=..\Sounds\MenuSounds.uax

var bool bCanHitOwner;
var xEmitter Trail;
var() float DampenFactor, DampenFactorParallel;
var class<xEmitter> HitEffectClass;
var float LastSparkTime;
var Actor IgnoreActor; //don't stick to this actor
var byte Team;
var Emitter Beacon;
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
		IgnoreActor, Team;
}

simulated function Destroyed()
{
    if ( Trail != None )
        Trail.mRegen = false; // stop the emitter from regenerating
    //explosion
    if ( !bNoFX )
    {
		if ( EffectIsRelevant(Location,false) )
		{
			Spawn(class'EHONSGrenadeExplosionEffect',,, Location, rotator(vect(0,0,1)));
			Spawn(ExplosionDecal,self,, Location, rotator(vect(0,0,-1)));
			ShakeView();    //ShakeViewcode//
		}
		PlaySound(Sound'EHSounds.GrenadeExplosion',,2.5*TransientSoundVolume);
	}
    if ( EHONSGrenadeLauncher(Owner) != None)
    	EHONSGrenadeLauncher(Owner).CurrentGrenades--;

	if ( Beacon != None )
		Beacon.Destroy();

    Super.Destroyed();
}

simulated function PostBeginPlay()
{
	local PlayerController PC;

    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer)
    {
		PC = Level.GetLocalPlayerController();
		if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 5500 )
	        Trail = Spawn(class'GrenadeSmokeTrail', self,, Location, Rotation);
    }

    Velocity = Speed * Vector(Rotation);
    RandSpin(25000);
    if (PhysicsVolume.bWaterVolume)
        Velocity = 0.6*Velocity;

    if (Role == ROLE_Authority && Instigator != None)
    	Team = Instigator.GetTeamNum();
}

simulated function PostNetBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer )
	{
		if (Team == 1)
			Beacon = spawn(class'EHONSGrenadeBeaconBlue', self);
		else
			Beacon = spawn(class'EHONSGrenadeBeaconRed', self);

		if (Beacon != None)
			Beacon.SetBase(self);
	}
	Super.PostNetBeginPlay();
}

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, None );
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
    if (!bPendingDelete && Base == None && Other != IgnoreActor && (!Other.bWorldGeometry && Other.Class != Class && (Other != Instigator || bCanHitOwner)))
	Stick(Other, HitLocation);
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local Vector VNorm;
	local PlayerController PC;

    if (Vehicle(Wall) != None)
    {
        Touch(Wall);
        return;
    }

    // Reflect off Wall w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    RandSpin(100000);
    Speed = VSize(Velocity);

    if ( Speed < 40 )
    {
        bBounce = False;
        SetPhysics(PHYS_None);
        if ( Trail != None )
            Trail.mRegen = false; // stop the emitter from regenerating
    }
    else
    {
		if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 250) )
			PlaySound(ImpactSound, SLOT_Misc );
        if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.TimeSeconds - LastSparkTime > 0.5) && EffectIsRelevant(Location,false) )
        {
			PC = Level.GetLocalPlayerController();
			if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 2000 )
				Spawn(HitEffectClass,,, Location, Rotator(HitNormal));
            LastSparkTime = Level.TimeSeconds;
        }
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector start;
    local rotator rot;
    local int i;
    local EHGrenadeChunk NewChunk;

	start = Location + 10 * HitNormal;
	if ( Role == ROLE_Authority )
	{
		HurtRadius(damage, 220, MyDamageType, MomentumTransfer, HitLocation);
		for (i=0; i<6; i++)
		{
			rot = Rotation;
			rot.yaw += FRand()*32000-16000;
			rot.pitch += FRand()*32000-16000;
			rot.roll += FRand()*32000-16000;
			NewChunk = Spawn( class 'EHGrenadeChunk',, '', Start, rot);
		}
	}
    BlowUp(HitLocation);
	//PlaySound(Sound'EHSounds.GrenadeExplosion',,3.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
        //Spawn(class'EHONSGrenadeExplosionEffect',,, HitLocation, rotator(vect(0,0,1)));
		//Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
		ShakeView();    //ShakeViewcode//
		LastTouched = Base;
        BlowUp(HitLocation);
    }

    Destroy();
}


simulated function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	local Actor A;

	if (Damage > 0)
	{
		if (Base != None && DamageType != MyDamageType)
		{
			if (EventInstigator == None || EventInstigator != Instigator)
			{
				UnStick();
				return;
			}
		}
		else if (IgnoreActor != None) //just got knocked off something I was stuck to, so don't explode
			foreach VisibleCollidingActors(IgnoreActor.Class, A, DamageRadius)
				return;

		Explode(Location, vect(0,0,1));
	}
}

simulated function Stick(actor HitActor, vector HitLocation)
{
    if ( Trail != None )
        Trail.mRegen = false; // stop the emitter from regenerating

    bBounce = False;
    LastTouched = HitActor;
    SetPhysics(PHYS_None);
    SetBase(HitActor);
    if (Base == None)
    {
    	UnStick();
    	return;
    }
    bCollideWorld = False;
    bProjTarget = true;

	PlaySound(Sound'MenuSounds.Select3',,2.5*TransientSoundVolume);
}

simulated function UnStick()
{
	Velocity = vect(0,0,0);
	IgnoreActor = Base;
	SetBase(None);
	SetPhysics(PHYS_Falling);
	bCollideWorld = true;
	bProjTarget = false;
	LastTouched = None;
}

simulated function BaseChange()
{
	if (!bPendingDelete && Physics == PHYS_None && Base == None)
		UnStick();
}

simulated function PawnBaseDied()
{
	Explode(Location, vect(0,0,1));
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

defaultproperties
{
     DampenFactor=0.500000
     DampenFactorParallel=0.800000
     HitEffectClass=Class'XEffects.WallSparks'
     ShakeRotMag=(Z=200.000000)
     ShakeRotRate=(Z=2000.000000)
     ShakeRotTime=5.000000
     ShakeOffsetMag=(Z=6.000000)
     ShakeOffsetRate=(Z=110.000000)
     ShakeOffsetTime=6.000000
     Speed=1800.000000
     MaxSpeed=1800.000000
     TossZ=0.000000
     bSwitchToZeroCollision=True
     Damage=25.000000
     DamageRadius=175.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'EHWeaponsE.DamTypeEHONSGrenade'
     ImpactSound=ProceduralSound'WeaponSounds.PGrenFloor1.P1GrenFloor1'
     ExplosionDecal=Class'Onslaught.ONSRocketScorch'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.VMGrenade'
     CullDistance=5000.000000
     bUseDynamicLights=True
     bNetTemporary=False
     bOnlyDirtyReplication=True
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.075000
     Skins(0)=Texture'EHWeaponSkinsB.EHGrenadeTex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     bHardAttach=True
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
     bUseCollisionStaticMesh=True
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
