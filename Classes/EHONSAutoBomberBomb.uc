class EHONSAutoBomberBomb extends Projectile;

var xEmitter Trail;
var vector Dir;
var bool bHitWater;
var byte Team;
// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view

simulated function Destroyed()
{
    if ( Trail != None )
        Trail.mRegen = false; // stop the emitter from regenerating
	Super.Destroyed();
}

function BeginPlay()
{
	Super.BeginPlay();

	if (Instigator != None)
		Team = Instigator.GetTeamNum();
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer)
    {
        Trail = Spawn(class'EHRocketTrailSmoke', self,, Location, Rotation);
    }
        Dir = vector(Rotation);
    	Velocity = speed * Dir;
	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}
}

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, None );
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    Explode(Location, vect(0,0,1));
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	if ( (Damage > 0) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		Explode(Location, vect(0,0,1));
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    BlowUp(HitLocation);
	PlaySound(Sound'ONSVehicleSounds-S.Explosions.Explosion11',,3.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(class'EHONSAutoBomberBombExplosion',,, HitLocation, rotator(vect(0,0,1)));
        Spawn(class'ONSArtilleryGroundExplosion',,, HitLocation, rotator(vect(0,0,1)));
        Spawn(class'NewExpRing',,, HitLocation, rotator(vect(0,0,1)));
		Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
		ShakeView();
    }
    Destroy();
}

    function ShakeView()
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
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     TossZ=0.000000
     Damage=200.000000
     DamageRadius=1400.000000
     MomentumTransfer=150000.000000
     MyDamageType=Class'mm_EHWeapons.DamTypeEHONSAutoBomberBomb'
     ImpactSound=ProceduralSound'WeaponSounds.PGrenFloor1.P1GrenFloor1'
     ExplosionDecal=Class'XEffects.ComboDecal'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.bomberBomb'
     Physics=PHYS_Falling
     DrawScale=0.550000
     AmbientGlow=32
     bProjTarget=True
     bFixedRotationDir=True
     RotationRate=(Roll=190000)
     DesiredRotation=(Roll=30000)
}
