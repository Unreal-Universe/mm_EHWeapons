class EHShockComboWiggles extends xEmitter;

#exec OBJ LOAD FILE=EmitterTextures.utx

defaultproperties
{
     mSpawningType=ST_Explode
     mRegen=False
     mStartParticles=60
     mMaxParticles=60
     mLifeRange(0)=1.500000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mDirDev=(X=1.000000,Y=1.000000,Z=1.000000)
     mPosDev=(X=16.000000,Y=16.000000,Z=16.000000)
     mSpeedRange(0)=80.000000
     mSpeedRange(1)=120.000000
     mSizeRange(0)=20.000000
     mSizeRange(1)=35.000000
     mAttenKa=0.050000
     LightType=LT_Strobe
     LightHue=195
     LightSaturation=180
     LightBrightness=255.000000
     LightRadius=5.000000
     bDynamicLight=True
     LifeSpan=4.000000
     Skins(0)=Texture'EmitterTextures.Flares.EFlareP3'
     Style=STY_Additive
}
