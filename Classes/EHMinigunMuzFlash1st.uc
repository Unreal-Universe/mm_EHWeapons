class EHMinigunMuzFlash1st extends xEmitter;

#exec OBJ LOAD FILE=VMParticleTextures.utx


var int mNumPerFlash;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
    mStartParticles += mNumPerFlash;
}

defaultproperties
{
     mNumPerFlash=1
     mParticleType=PT_Mesh
     mStartParticles=0
     mMaxParticles=1
     mLifeRange(0)=0.100000
     mLifeRange(1)=0.150000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mSpawnVecB=(Z=0.000000)
     mSpeedRange(0)=0.000000
     mSpeedRange(1)=0.000000
     mPosRelative=True
     mAirResistance=0.000000
     mSizeRange(0)=0.050000
     mSizeRange(1)=0.080000
     mGrowthRate=3.000000
     mMeshNodes(0)=StaticMesh'AS_Weapons_SM.MuzzleFlash.ASMinigun_Muzzle'
     DrawScale=0.900000
     Skins(0)=Shader'VMParticleTextures.TankFiringP.tankMuzzleSHAD'
     Style=STY_Additive
}
