class EHSniperTracerEffect extends Projectile;

var xEmitter Trail;


simulated function Destroyed()
{
    if ( Trail !=None )
		Trail.mRegen=False;
	Super.Destroyed();
}

simulated function bool CanSplash()
{
	return (bReadyToSplash && ( Level.NetMode != NM_DedicatedServer ));
}

simulated function PostNetBeginPlay()
{

	if ( ( Level.NetMode != NM_DedicatedServer ) && (Level.GetLocalPlayerController() == Owner) )
	{
		return;
	}

    if ( Level.NetMode != NM_DedicatedServer )
    {
        if ( !PhysicsVolume.bWaterVolume )
        {
            Trail = Spawn(class'tk_EHWeapons.EHTracerTrail',self);
            Trail.Lifespan = Lifespan;

        }
    }
    Velocity = Vector(Rotation) * (Speed);
    Super.PostNetBeginPlay();


		}


simulated singular function Touch(Actor Other)
{
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
}

simulated function Landed( Vector HitNormal )
{
    Destroy();
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    Destroy();
}

defaultproperties
{
     Speed=20000.000000
     MaxSpeed=20000.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.FlakChunk'
     bUpdateSimulatedPosition=True
     LifeSpan=2.000000
     DrawScale=5.000000
     Style=STY_Alpha
}
