class EHLightningRiflePickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=WeaponSkins.utx
#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Material'XGameShaders.WeaponEnvShader');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LightningRifleTex');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.NewLightningBoltT');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.NewLightningBoltChild');
    L.AddPrecacheMaterial(Texture'SniperBorder');
    L.AddPrecacheMaterial(Texture'SniperFocus');
	L.AddPrecacheMaterial(Texture'SniperArrows');
	L.AddPrecacheMaterial(Texture'Engine.WhiteTexture');
    L.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen1');
    L.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen1Pan');
    L.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen2');
    L.AddPrecacheMaterial(Texture'XEffects.LightningChargeT');
    L.AddPrecacheMaterial(Texture'XEffects.pcl_BlueSpark');
    L.AddPrecacheMaterial(Texture'XEffects.LightningBoltT');
    L.AddPrecacheMaterial(Material'XGameShaders.fulloverlay');
    L.AddPrecacheMaterial(Material'XGameShaders.scanline');
    L.AddPrecacheMaterial(Material'EmitterTextures.LargeFlames');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.SniperRiflePickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'EmitterTextures.LargeFlames');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LightningRifleTex');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.NewLightningBoltT');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.NewLightningBoltChild');
    Level.AddPrecacheMaterial(Material'XGameShaders.WeaponEnvShader');
    Level.AddPrecacheMaterial(Texture'SniperBorder');
    Level.AddPrecacheMaterial(Texture'SniperFocus');
	Level.AddPrecacheMaterial(Texture'SniperArrows');
	Level.AddPrecacheMaterial(Texture'Engine.WhiteTexture');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen1');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen1Pan');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.SniperScreen2');
    Level.AddPrecacheMaterial(Texture'XEffects.LightningChargeT');
    Level.AddPrecacheMaterial(Texture'XEffects.pcl_BlueSpark');
    Level.AddPrecacheMaterial(Texture'XEffects.LightningBoltT');
    Level.AddPrecacheMaterial(Material'XGameShaders.fulloverlay');
    Level.AddPrecacheMaterial(Material'XGameShaders.scanline');

	super.UpdatePrecacheMaterials();
}

defaultproperties
{
     MaxDesireability=0.650000
     InventoryType=Class'mm_EHWeapons.EHLightningRifle'
     PickupMessage="You got the Enhanced Lightning Gun."
     PickupSound=Sound'PickupSounds.SniperRiflePickup'
     PickupForce="EHLightningRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.SniperRiflePickup'
     bUseDynamicLights=True
     DrawScale=0.450000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.LightningRifleTex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
