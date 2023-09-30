class EHLinkMuzFlashBeam1st extends xEmitter;

#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"

event Trigger( Actor Other, Pawn EventInstigator )
{
    mStartParticles += 1;
}

defaultproperties
{
     mStartParticles=0
     mMaxParticles=5
     mLifeRange(0)=0.250000
     mLifeRange(1)=0.250000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mSpeedRange(0)=0.000000
     mSpeedRange(1)=0.000000
     mPosRelative=True
     mRandOrient=True
     mSpinRange(0)=-100.000000
     mSpinRange(1)=100.000000
     mSizeRange(0)=20.000000
     mSizeRange(1)=30.000000
     mAttenKa=0.000000
     mNumTileColumns=2
     mNumTileRows=2
     bHidden=True
     bOnlyOwnerSee=True
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.LinkMuzGreen'
     Style=STY_Additive
}
