class LinkExplosion extends xEmitter;
state Ticking
{
	simulated function Tick( float dt )
	{
		if( LifeSpan < 4.0 )
		{
			mRegenRange[0] *= LifeSpan / 4;
			mRegenRange[1] = mRegenRange[0];
			SoundVolume = byte(float(SoundVolume) * (LifeSpan / 4));
		}
	}
}

simulated function timer()
{
	GotoState('Ticking');
}

defaultproperties
{
     mSpawningType=ST_Explode
     mRegen=False
     mStartParticles=50
     mLifeRange(0)=1.500000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mDirDev=(X=1.000000,Y=1.000000,Z=1.000000)
     mPosDev=(X=16.000000,Y=16.000000,Z=16.000000)
     mSpeedRange(0)=800.000000
     mSpeedRange(1)=1200.000000
     mSizeRange(0)=20.000000
     mSizeRange(1)=35.000000
     mColorRange(0)=(B=40,R=40,A=120)
     mColorRange(1)=(B=40,R=40)
     mAttenKa=0.050000
     AmbientSound=Sound'WeaponSounds.BaseFiringSounds.BPulseRifleAltFire'
     LifeSpan=4.000000
     Skins(0)=Texture'EmitterTextures.Flares.EFlareG'
     Style=STY_Additive
}
