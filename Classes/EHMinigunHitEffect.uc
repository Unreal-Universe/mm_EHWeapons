class EHMinigunHitEffect extends Effects;

var sound ImpactSounds[10];

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if ( Role == ROLE_Authority )
	{
		if ( Instigator != None )
			MakeNoise(0.3);
	}
	if ( Level.NetMode != NM_DedicatedServer )
		SpawnEffects();
}

simulated function SpawnEffects()
{
	local playercontroller P;
	local bool bViewed;

	PlaySound(ImpactSounds[Rand(10)]);

	P = Level.GetLocalPlayerController();
	if ( (P != None) && (P.ViewTarget != None) && (VSize(P.Viewtarget.Location - Location) < 1600*P.FOVBias) && ((vector(P.Rotation) dot (Location - P.ViewTarget.Location)) > 0) )
	{
		Spawn(class'MinigunBulletDecal',self,,Location, rotator(-1 * vector(Rotation)));
		bViewed = true;
	}
	if ( PhysicsVolume.bWaterVolume )
		return;

	if ( (Level.DetailMode == DM_Low) || Level.bDropDetail )
	{
		if ( bViewed && (FRand() < 0.25) )
			Spawn(class'WallSparks');
		else
			Spawn(class'EHBulletImpact');
		return;
	}

	if ( bViewed && (FRand() < 0.5) )
		Spawn(class'WallSparks');
	Spawn(class'EHBulletImpact');
}

defaultproperties
{
     ImpactSounds(0)=Sound'XEffects.Impact1Snd'
     ImpactSounds(1)=Sound'XEffects.Impact2Snd'
     ImpactSounds(2)=Sound'XEffects.Impact3Snd'
     ImpactSounds(3)=Sound'XEffects.Impact4Snd'
     ImpactSounds(4)=Sound'XEffects.Impact5Snd'
     ImpactSounds(5)=Sound'XEffects.Impact6Snd'
     ImpactSounds(6)=Sound'XEffects.Impact7Snd'
     ImpactSounds(7)=Sound'XEffects.Impact3'
     ImpactSounds(8)=Sound'XEffects.Impact1'
     ImpactSounds(9)=Sound'XEffects.Impact2'
     DrawType=DT_None
     CullDistance=7000.000000
     LifeSpan=0.100000
     Style=STY_Additive
}
