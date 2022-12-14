class EHMinePickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=XGame_StaticMeshes.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'EHWeaponSkinsB.SpiderRed');
	L.AddPrecacheMaterial(Texture'EHWeaponSkinsB.SpiderBLUE');
	L.AddPrecacheMaterial(Texture'EHWeaponSkinsB.EHminelayerTEX');
	L.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	L.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.Smokepuff2');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Fire.GrenadeTest');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.AirBlast');

	L.AddPrecacheStaticMesh(StaticMesh'XGame_StaticMeshes.HoverBomb');
	L.AddPrecacheStaticMesh(StaticMesh'ONSWeapons-SM.MineLayerPickup');
	L.AddPrecacheStaticMesh(default.StaticMesh);
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'EHWeaponSkinsB.SpiderRed');
	Level.AddPrecacheMaterial(Texture'EHWeaponSkinsB.SpiderBLUE');
    Level.AddPrecacheMaterial(Texture'EHWeaponSkinsB.EHminelayerTEX');
	Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	Level.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.Smokepuff2');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Fire.GrenadeTest');
	Level.AddPrecacheMaterial(Material'AW-2004Particles.Energy.AirBlast');
	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'XGame_StaticMeshes.HoverBomb');
	Level.AddPrecacheStaticMesh(StaticMesh'ONSWeapons-SM.MineLayerPickup');
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.700000
     InventoryType=Class'EHWeaponsE.EHMineLauncher'
     PickupMessage="You got the Enhanced Spider Mine Launcher."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="EHMinePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONSWeapons-SM.MineLayerPickup'
     bUseDynamicLights=True
     DrawScale=0.300000
     Skins(0)=Texture'EHWeaponSkinsB.EHminelayerTEX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
