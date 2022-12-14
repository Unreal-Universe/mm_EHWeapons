class EHShockImpactRing extends xEmitter;

#exec OBJ LOAD FILE=XEffectMat.utx

defaultproperties
{
     mParticleType=PT_Disc
     mRegen=False
     mMaxParticles=1
     mLifeRange(0)=0.500000
     mLifeRange(1)=0.500000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mSpeedRange(0)=0.000000
     mSpeedRange(1)=0.000000
     mRandOrient=True
     mSpinRange(0)=-100.000000
     mSpinRange(1)=100.000000
     mSizeRange(0)=30.000000
     mSizeRange(1)=30.000000
     mGrowthRate=260.000000
     mColorRange(0)=(B=200,G=100,R=100)
     mColorRange(1)=(B=100,G=100,R=200)
     mAttenKa=0.000000
     bHighDetail=True
     Skins(0)=Texture'XEffectMat.Shock.shock_ring_b'
     Style=STY_Additive
}
