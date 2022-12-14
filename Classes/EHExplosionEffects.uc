class EHExplosionEffects extends Actor;

#exec OBJ LOAD FILE=XEffectMat.utx

var EHRIIFlare Flare;

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if (Level.NetMode != NM_DedicatedServer)
    {

        Flare = Spawn(class'EHRIIFlare');
        Spawn(class'EHRIIExpRing');
        Spawn(class'EHRIIGroundExplosion');
        Spawn(class'EHFlashFlare');
        Spawn(class'EHRedeemerIISmokeRing');
        Spawn(class'EHRedeemerIIShroomcloud');
        Spawn(class'EHRIIHitRockEffect');
        Spawn(class'EHMegaFlashExplosion');
    }
}
auto simulated state Combo
{
Begin:
    Sleep(0.9);

    if ( Flare != None )
    {
		Flare.mStartParticles = 2;
		Flare.mRegenRange[0] = 0.0;
		Flare.mRegenRange[1] = 0.0;
		Flare.mLifeRange[0] = 0.3;
		Flare.mLifeRange[1] = 0.3;
		Flare.mSizeRange[0] = 150;
		Flare.mSizeRange[1] = 150;
		Flare.mGrowthRate = -500;
		Flare.mAttenKa = 0.9;
	}
    LightType = LT_None;
}

defaultproperties
{
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=195
     LightSaturation=100
     LightBrightness=255.000000
     LightRadius=10.000000
     DrawType=DT_None
     bDynamicLight=True
     bNetTemporary=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=2.000000
     bCollideActors=True
     ForceType=FT_Constant
     ForceRadius=300.000000
     ForceScale=-500.000000
}
