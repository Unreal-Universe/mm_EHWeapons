class EHTransAttachment extends xWeaponAttachment;

function InitFor(Inventory I)
{
    Super.InitFor(I);
}

simulated event ThirdPersonEffects()
{
    Super.ThirdPersonEffects();
}

simulated event BaseChange()
{
	if ( (Pawn(Base) != None) && (Pawn(Base).PlayerReplicationInfo != None) && (Pawn(Base).PlayerReplicationInfo.Team != None) )
	{
		if ( Pawn(Base).PlayerReplicationInfo.Team.TeamIndex == 1 )
			Skins[1] = Material'WeaponSkins.NEWTranslocatorBlue';
		else
			Skins[1] = Material'WeaponSkins.NEWTranslocatorTEX';
	}
}

defaultproperties
{
     bHeavy=True
     bUseDynamicLights=True
     Mesh=SkeletalMesh'NewWeapons2004.NEWTranslauncher_3rd'
     Skins(0)=FinalBlend'EpicParticles.JumpPad.NewTransLaunBoltFB'
     Skins(1)=Texture'EHWeaponSkinsB.EHNEWTranslocatorTEX'
     Skins(2)=Texture'EHWeaponSkinsB.EHNEWTranslocatorPUCK'
     Skins(3)=FinalBlend'WeaponSkins.AmmoPickups.NewTransGlassFB'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
