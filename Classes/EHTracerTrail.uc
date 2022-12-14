class EHTracerTrail extends xEmitter;

#exec OBJ LOAD File=AW-2004Particles.utx

defaultproperties
{
     mParticleType=PT_Stream
     mStartParticles=0
     mMaxParticles=40
     mLifeRange(0)=1.100000
     mLifeRange(1)=1.100000
     mRegenRange(0)=160.000000
     mRegenRange(1)=160.000000
     mSpawnVecB=(X=2.000000,Z=0.000000)
     mSizeRange(0)=4.000000
     mSizeRange(1)=5.000000
     mGrowthRate=-0.500000
     mColorRange(0)=(B=150,G=150,R=150)
     mColorRange(1)=(B=150,G=150,R=150)
     mNumTileColumns=4
     mNumTileRows=2
     bUpdateSimulatedPosition=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=4.900000
     Skins(0)=TexPanner'EHWeaponSkinsB.TrailP'
     Style=STY_Translucent
}
