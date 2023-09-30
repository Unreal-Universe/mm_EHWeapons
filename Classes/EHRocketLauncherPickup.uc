class EHRocketLauncherPickup extends UTWeaponPickup;

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.PlasmaStarRed');
    L.AddPrecacheMaterial(Material'mm_EHWeapons.EHWeaponSkinsB.EHfire3');
    L.AddPrecacheMaterial(Material'mm_EHWeapons.EHWeaponSkinsB.RocketTex02');
    L.AddPrecacheMaterial(Material'WeaponSkins.RocketShellTex');
    L.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    L.AddPrecacheMaterial(Material'XEffects.SmokeAlphab_t');
    L.AddPrecacheMaterial(Material'EmitterTextures.rockchunks02');
    L.AddPrecacheMaterial(Material'EmitterTextures.fire3');
    L.AddPrecacheMaterial(Material'EmitterTextures.LargeFlames');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.rocketproj');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.RocketLauncherPickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.PlasmaStarRed');
    Level.AddPrecacheMaterial(Material'mm_EHWeapons.EHWeaponSkinsB.EHfire3');
    Level.AddPrecacheMaterial(Material'mm_EHWeapons.EHWeaponSkinsB.RocketTex02');
    Level.AddPrecacheMaterial(Material'EmitterTextures.fire3');
    Level.AddPrecacheMaterial(Material'EmitterTextures.LargeFlames');
    Level.AddPrecacheMaterial(Material'WeaponSkins.RocketShellTex');
    Level.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    Level.AddPrecacheMaterial(Material'XEffects.SmokeAlphab_t');
    Level.AddPrecacheMaterial(Material'EmitterTextures.rockchunks02');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.RedeemerMissile');
	Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     MaxDesireability=0.780000
     InventoryType=Class'mm_EHWeapons.EHRocketLauncher'
     PickupMessage="You got the Enhanced Rocket Launcher."
     PickupSound=Sound'PickupSounds.RocketLauncherPickup'
     PickupForce="EHRocketLauncherPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketLauncherPickup'
     DrawScale=0.450000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.RocketTex02'
     AmbientGlow=12
}
