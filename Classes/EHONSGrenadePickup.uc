class EHONSGrenadePickup extends UTWeaponPickup;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.EHGrenadeLauncherTEX');
	L.AddPrecacheMaterial(Texture'VMWeaponsTX.PlayerWeaponsGroup.GrenadeTex');
	L.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	L.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	L.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.rockchunks02');
	L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.Smokepuff2');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Fire.GrenadeTest');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.AirBlast');

	L.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.VMGrenade');
	L.AddPrecacheStaticMesh(default.StaticMesh);
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.EHGrenadeLauncherTEX');
	Level.AddPrecacheMaterial(Texture'VMWeaponsTX.PlayerWeaponsGroup.GrenadeTex');
	Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	Level.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	Level.AddPrecacheMaterial(Texture'VMWeaponsTX.PlayerWeaponsGroup.GrenadeTex');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.Smokepuff2');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Fire.GrenadeTest');
	Level.AddPrecacheMaterial(Material'AW-2004Particles.Energy.AirBlast');
	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.VMGrenade');
	Level.AddPrecacheStaticMesh(StaticMesh'ONSWeapons-SM.GrenadeLauncherPickup');
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.700000
     InventoryType=Class'mm_EHWeapons.EHONSGrenadeLauncher'
     PickupMessage="You got the Enhanced Grenade Launcher."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="EHONSGrenadePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONSWeapons-SM.GrenadeLauncherPickup'
     bUseDynamicLights=True
     DrawScale=0.250000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.EHGrenadeLauncherTEX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
