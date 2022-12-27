class EHBulletImpact extends BloodSpurt;

simulated function PostNetBeginPlay()
{
	if ( Level.NetMode == NM_DedicatedServer )
		LifeSpan = 0.2;
}

defaultproperties
{
     BloodDecalClass=None
     mStartParticles=15
     mMaxParticles=15
     mLifeRange(0)=0.900000
     mLifeRange(1)=1.700000
     mSpeedRange(0)=35.000000
     mSpeedRange(1)=150.000000
     mMassRange(0)=0.400000
     mMassRange(1)=0.700000
     mSizeRange(1)=13.500000
     CullDistance=7000.000000
     Texture=Texture'XEffects.SmokeAlphab_t'
     Skins(0)=Texture'XEffects.SmokeAlphab_t'
}
