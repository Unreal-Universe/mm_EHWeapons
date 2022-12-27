class EHShockRiflePickup extends UTWeaponPickup;

static function StaticPrecache(LevelInfo L)
{
	if ( class'EHShockRifle'.Default.bUseOldWeaponMesh )
	{
		L.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.ShockRifleTex02');
		L.AddPrecacheMaterial(Texture'WeaponSkins.ShockLaser.lasermist');
	}
    L.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.pannelLightning');
    L.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.ShockBeamPanner');
    L.AddPrecacheMaterial(Material'XEffects.ShockHeatDecal');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_flash');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_flare_a');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_core');
    L.AddPrecacheMaterial(Material'XEffectMat.purple_line');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_sparkle');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_core_low');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_Energy_green_faded');
    L.AddPrecacheMaterial(Material'XEffectMat.Shock_Elec_a');
    L.AddPrecacheMaterial(Material'XEffectMat.shock_gradient_b');
    L.AddPrecacheMaterial(Material'XEffectMat.Shock_ring_a');
    L.AddPrecacheMaterial(Material'XEffectMat.ShockComboFlash');
    L.AddPrecacheMaterial(Material'XGameShaders.shock_muzflash_1st');
    L.AddPrecacheMaterial(Material'XGameShaders.WeaponShaders.shock_muzflash_3rd');
    L.AddPrecacheMaterial(Material'EpicParticles.Flares.OutSpark03aw');
    L.AddPrecacheMaterial(Material'XEffects.SaDScorcht');
    L.AddPrecacheMaterial(Material'DeployableTex.C_T_Electricity_SG');
    L.AddPrecacheMaterial(Material'UT2004Weapons.ShockRipple');

	L.AddPrecacheStaticMesh(StaticMesh'Editor.TexPropSphere');
	L.AddPrecacheStaticMesh(StaticMesh'NewWeaponPickups.ShockPickupSM');
}

simulated function UpdatePrecacheMaterials()
{
	if ( class'ShockRifle'.Default.bUseOldWeaponMesh )
	{
		Level.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.ShockRifleTex02');
		Level.AddPrecacheMaterial(Texture'WeaponSkins.ShockLaser.lasermist');
	}
    Level.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.pannelLightning');
    Level.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.ShockBeamPanner');
    Level.AddPrecacheMaterial(Material'XEffects.ShockHeatDecal');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_flash');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_flare_a');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_core');
    Level.AddPrecacheMaterial(Material'XEffectMat.purple_line');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_sparkle');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_core_low');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_Energy_green_faded');
    Level.AddPrecacheMaterial(Material'XEffectMat.Shock_Elec_a');
    Level.AddPrecacheMaterial(Material'XEffectMat.shock_gradient_b');
    Level.AddPrecacheMaterial(Material'XEffectMat.Shock_ring_a');
    Level.AddPrecacheMaterial(Material'XEffectMat.ShockComboFlash');
    Level.AddPrecacheMaterial(Material'XGameShaders.shock_muzflash_1st');
    Level.AddPrecacheMaterial(Material'XGameShaders.WeaponShaders.shock_muzflash_3rd');
    Level.AddPrecacheMaterial(Material'EpicParticles.Flares.OutSpark03aw');
    Level.AddPrecacheMaterial(Material'DeployableTex.C_T_Electricity_SG');
    Level.AddPrecacheMaterial(Material'XEffects.SaDScorcht');
    Level.AddPrecacheMaterial(Material'UT2004Weapons.ShockRipple');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'Editor.TexPropSphere');
	Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.630000
     InventoryType=Class'tk_EHWeapons.EHShockRifle'
     PickupMessage="You got the Enhanced Shock Rifle."
     PickupSound=Sound'PickupSounds.ShockRiflePickup'
     PickupForce="EHShockRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponPickups.ShockPickupSM'
     bUseDynamicLights=True
     DrawScale=0.550000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.ShockRifleTex02'
     Skins(1)=Shader'Plutonic_BP2_textures.Shaders.MikeDemo_crystal_FX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
