class EHMineProjectile extends Projectile;

var()   float   DetectionTimer; // check target every this many seconds
var()   Sound   ExplodeSound;
var()   float   ScurrySpeed, ScurryAnimRate;
var()   float   HeightOffset;

var     Pawn    TargetPawn;
var     int     TeamNum;
var	bool	bClosedDown;
var	bool	bGoToTargetLoc;
var	vector	TargetLoc;
var	int	TargetLocFuzz;
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
        bGoToTargetLoc;
    reliable if (bNetDirty && Role == ROLE_Authority && bGoToTargetLoc)
    	TargetLoc;
    reliable if (bNetDirty && Role == ROLE_Authority && !bGoToTargetLoc)
        TargetPawn;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        Velocity = Instigator.Velocity + (vector(Rotation) * Speed);
        Velocity.Z += TossZ;
        SetRotation(Rotation + rot(16384,0,0));
    }

    PlayAnim('Startup', 0.5);
}

simulated function PostNetBeginPlay()
{
    if (Role < ROLE_Authority && Physics == PHYS_None)
    {
        bProjTarget = true;
        GotoState('OnGround');
    }
}

simulated function Destroyed()
{
    if ( !bNoFX && EffectIsRelevant(Location,false) )
        Spawn(class'EHONSGrenadeExplosionEffect');
        PlaySound(ExplodeSound, SLOT_Misc);
        ShakeView();    //ShakeViewcode//

    if (Role == ROLE_Authority && bScriptInitialized && EHMineLauncher(Owner) != None)
    	EHMineLauncher(Owner).CurrentMines--;

    Super.Destroyed();
}

simulated function ProcessTouch(Actor Other, vector HitLocation)
{
	if (EHMineProjectile(Other) != None)
	{
		if (Other.Owner == None || Other.Owner != Owner)
			BlowUp(Location);
		else if (Physics == PHYS_Falling)
			Velocity = vect(0,0,250) + 100 * VRand();
	}
	else if (Pawn(Other) != None)
	{
		if (Other != Instigator && Pawn(Other).GetTeamNum() != TeamNum)
			BlowUp(Location);
	}
	else if (Other.bCanBeDamaged && Other.Base != self)
		BlowUp(Location);
}

simulated function AdjustSpeed()
{
	ScurrySpeed = default.ScurrySpeed / (Attached.length + 1);
	ScurryAnimRate = default.ScurryAnimRate / (Attached.length + 1);
}

simulated function Attach(Actor Other)
{
	AdjustSpeed();
}

simulated function Detach(Actor Other)
{
	AdjustSpeed();
}

function AcquireTarget()
{
	local Pawn A;
	local float Dist, BestDist;

    TargetPawn = None;

    foreach VisibleCollidingActors(class'Pawn', A, 750.0)
    {
        if ( A != Instigator && A.Health > 0 && A.GetTeamNum() != TeamNum
         && (Vehicle(A) == None || Vehicle(A).Driver != None || Vehicle(A).bTeamLocked)
    	 && (ONSStationaryWeaponPawn(A) == None || ONSStationaryWeaponPawn(A).bPowered) )
	    {
	    	Dist = VSize(A.Location - Location);
	    	if (TargetPawn == None || Dist < BestDist)
	    	{
    			TargetPawn = A;
    			BestDist = Dist;
            }
	    }
	}
}

function WarnTarget()
{
	if (TargetPawn != None && TargetPawn.Controller != None)
	{
		TargetPawn.Controller.ReceiveProjectileWarning(self);

		if (AIController(TargetPawn.Controller) != None && AIController(TargetPawn.Controller).Skill >= 5.0 && !TargetPawn.IsFiring())
		{
			TargetPawn.Controller.Focus = self;
			TargetPawn.Controller.FireWeaponAt(self);
		}
	}
}

function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if ( Damage > 0 && InstigatedBy != None && (Instigator != InstigatedBy || DamageType != MyDamageType)
	     && (Instigator == None || Instigator == InstigatedBy || InstigatedBy.GetTeamNum() != Instigator.GetTeamNum()) )
		BlowUp(Location);
}

function PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	if (NewVolume.bPainCausing)
		BlowUp(Location);
}

auto state Flying
{
    simulated function Landed( vector HitNormal )
    {
        local rotator NewRot;

        if ( Level.NetMode != NM_DedicatedServer )
            PlaySound(ImpactSound, SLOT_Misc);

        bProjTarget = True;

        NewRot = rotator(HitNormal);
        NewRot.Pitch -= 16384;

        SetRotation(NewRot);

        GotoState('OnGround');
    }

    simulated function HitWall( vector HitNormal, Actor Wall )
    {
        if (bBounce)
        {
            if (Wall != None && Instigator != None && Pawn(Wall) != None)
            {
                if (Pawn(Wall).GetTeamNum() == Instigator.GetTeamNum())
                    bUseCollisionStaticMesh = True;
                else
                    BlowUp(Location);
            }
            bBounce = False;
        }
        else
            BlowUp(Location);
     }

    simulated function BeginState()
    {
    	SetPhysics(PHYS_Falling);
    }
}

simulated state OnGround
{
    simulated function Timer()
    {
        if (Role < ROLE_Authority)
        {
            if (TargetPawn != None)
                GotoState('Scurrying');
            else if (bGoToTargetLoc)
                GotoState('ScurryToTargetLoc');

            return;
        }

        if (Instigator == None)
            BlowUp(Location);

    	AcquireTarget();

        if (TargetPawn != None)
            GotoState('Scurrying');
    }

    simulated function BeginState()
    {
    	SetPhysics(PHYS_None);
    	Velocity = vect(0,0,0);
        SetTimer(DetectionTimer, True);
        Timer();
    }

    simulated function EndState()
    {
        SetTimer(0, False);
    }

    Begin:
        bRotateToDesired = False;
        sleep(0.4);
        PlayAnim('CloseDown');
        bClosedDown = true;
}

simulated state Scurrying
{
    simulated function Timer()
    {
        local vector NewLoc;
        local rotator TargetDirection;
        local float TargetDist;

        if (TargetPawn == None)
            GotoState('Flying');

        if (Physics != PHYS_Walking)
		return;

        NewLoc = TargetPawn.Location - Location;
        TargetDist = VSize(NewLoc);

//        // If we are on a vehicle jump off
//        if (bUseCollisionStaticMesh)
//        {
//            log("Jumping off");
//            GotoState('Flying');
//            Velocity = 1.2 * (Normal(NewLoc) * ScurrySpeed);
//            Velocity.Z = 350;
//        }

        if (TargetDist < 1000.0)
        {
            NewLoc.Z = 0;
            Velocity = Normal(NewLoc) * ScurrySpeed;
            if (TargetDist < 225.0)
            {
                GotoState('Flying');
                Velocity *= 1.2;
                Velocity.Z = 350;
                WarnTarget();
            }
            else
            {
                TargetDirection = Rotator(NewLoc);
                TargetDirection.Yaw -= 16384;
                TargetDirection.Roll = 0;
                SetRotation(TargetDirection);
                LoopAnim('Scurry', ScurryAnimRate);
            }
         }
         else
            GotoState('Flying');
    }

    simulated event BaseChange()
    {
        Super.BaseChange();

        if (Base != None && Vehicle(Base) == None)
            bUseCollisionStaticMesh = False;
    }

    simulated function Landed(vector HitNormal)
    {
        SetPhysics(PHYS_Walking);
    }

    function BeginState()
    {
    	WarnTarget();
    }

    simulated function EndState()
    {
        StopAnimating();
        SetTimer(0.0, False);
    }

    Begin:
        SetPhysics(PHYS_Walking);
        if (bClosedDown)
        {
    		PlayAnim('StartUp');
    		bClosedDown = false;
    		sleep(0.25);
        }
        SetTimer(DetectionTimer / 2, true);
}

simulated function BlowUp(Vector HitLocation)
{
    local int i;

    if (Role == ROLE_Authority)
        HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );

    //make sure anything attached gets blown up too
    for (i = 0; i < Attached.length; i++)
    	Attached[i].TakeDamage(Damage, Instigator, Attached[i].Location, vect(0,0,0), MyDamageType);

    PlaySound(ExplodeSound, SLOT_Misc);
    ShakeView();    //ShakeViewcode//

    Destroy();
}

function SetScurryTarget(vector NewTargetLoc)
{
	if (TargetPawn == None)
	{
		TargetLoc = NewTargetLoc + VRand() * Rand(TargetLocFuzz);
		bGoToTargetLoc = true;
		GotoState('ScurryToTargetLoc');
	}
}

simulated state ScurryToTargetLoc extends Scurrying
{
	function SetScurryTarget(vector NewTargetLoc)
	{
		TargetLoc = NewTargetLoc + VRand() * Rand(TargetLocFuzz);
	}

	simulated function Landed(vector HitNormal)
	{
		SetPhysics(PHYS_Walking);
	}

	simulated function Timer()
	{
		local vector NewLoc;
		local rotator TargetDirection;

		if (Physics != PHYS_Walking)
			return;

		NewLoc = TargetLoc - Location;
		NewLoc.Z = 0;
		if (VSize(NewLoc) < 250)
		{
			AcquireTarget();
			if (TargetPawn != None)
				GotoState('Scurrying');
			else
				GotoState('Flying');
			return;
		}

		Velocity = Normal(NewLoc) * ScurrySpeed;
		TargetDirection = Rotator(NewLoc);
		TargetDirection.Yaw -= 16384;
		TargetDirection.Roll = 0;
		SetRotation(TargetDirection);
		LoopAnim('Scurry', ScurryAnimRate);
	}

	simulated function EndState()
	{
		SetTimer(0.0, False);
		bGoToTargetLoc = false;
	}
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
     DetectionTimer=0.500000
     ExplodeSound=SoundGroup'WeaponSounds.RocketLauncher.RocketLauncherFire'
     ScurrySpeed=525.000000
     ScurryAnimRate=4.100000
     TargetLocFuzz=250
     ShakeRotMag=(Z=200.000000)
     ShakeRotRate=(Z=2000.000000)
     ShakeRotTime=5.000000
     ShakeOffsetMag=(Z=6.000000)
     ShakeOffsetRate=(Z=110.000000)
     ShakeOffsetTime=6.000000
     Speed=800.000000
     MaxSpeed=800.000000
     TossZ=0.000000
     Damage=95.000000
     DamageRadius=250.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'EHWeaponsE.DamTypeEHMine'
     ImpactSound=Sound'WeaponSounds.BaseGunTech.BGrenfloor1'
     CullDistance=6000.000000
     bUseDynamicLights=True
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     Physics=PHYS_Falling
     LifeSpan=0.000000
     Mesh=SkeletalMesh'ONSWeapons-A.ParasiteMine'
     DrawScale=0.200000
     PrePivot=(Z=-2.900000)
     Skins(0)=Texture'EHWeaponSkinsB.SpiderRed'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     bClientAnim=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=100.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bBlockKarma=True
     bBounce=True
     bRotateToDesired=True
     RotationRate=(Pitch=20000)
}
