class EHFlakShellSparkles extends xEmitter;

#exec OBJ LOAD FILE=EmitterTextures.utx

defaultproperties
{
     mSpawningType=ST_Explode
     mStartParticles=0
     mMaxParticles=20
     mLifeRange(0)=0.400000
     mLifeRange(1)=0.500000
     mRegenRange(0)=20.000000
     mRegenRange(1)=20.000000
     mPosDev=(X=9.000000,Y=9.000000,Z=9.000000)
     mSpeedRange(0)=50.000000
     mSpeedRange(1)=50.000000
     mPosRelative=True
     mSizeRange(0)=7.000000
     mGrowthRate=-20.000000
     mColorRange(0)=(B=125,G=125,R=125)
     mColorRange(1)=(B=250,G=250,R=250)
     mNumTileColumns=4
     mNumTileRows=4
     Physics=PHYS_Trailer
     Skins(0)=Texture'EmitterTextures.MultiFrame.LargeFlames'
     Style=STY_Translucent
}
