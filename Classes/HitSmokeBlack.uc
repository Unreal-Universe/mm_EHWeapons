class HitSmokeBlack extends xEmitter;

state Ticking
{
	simulated function Tick( float dt )
	{
		if( LifeSpan < 10.0 )
		{
			mRegenRange[0] *= LifeSpan / 3;
			mRegenRange[1] = mRegenRange[0];
			SoundVolume = byte(float(SoundVolume) * (LifeSpan / 7));
		}
	}
}

simulated function timer()
{
	GotoState('Ticking');
}

simulated function PostNetBeginPlay()
{
	SetTimer(LifeSpan - 3.0,false);
	Super.PostNetBeginPlay();
}

defaultproperties
{
     mStartParticles=0
     mMaxParticles=30
     mLifeRange(0)=0.500000
     mLifeRange(1)=0.700000
     mRegenRange(0)=200.000000
     mRegenRange(1)=200.000000
     mPosDev=(X=8.000000,Y=8.000000,Z=24.000000)
     mSpeedRange(0)=0.000000
     mSpeedRange(1)=0.000000
     mMassRange(0)=-0.800000
     mMassRange(1)=-1.000000
     mSizeRange(1)=25.000000
     mGrowthRate=-16.000000
     mColorRange(0)=(B=240,G=240,R=240)
     mAttenKa=0.500000
     mNumTileColumns=4
     mNumTileRows=4
     Physics=PHYS_Trailer
     AmbientSound=Sound'GeneralAmbience.firefx7'
     LifeSpan=3.000000
     Skins(0)=Texture'XEffects.SmokeTex'
     Style=STY_Alpha
     SoundVolume=190
     SoundRadius=32.000000
}
