class EHAVRiLPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=VMWeaponsSM.usx
#exec OBJ LOAD FILE=SC_MeshParticles.usx
#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="tk_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.EHAVRiLtex');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	L.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.rockchunks02');
	L.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	L.AddPrecacheMaterial(Texture'ONSBPTextures.fX.ExploTrans');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
	L.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	L.AddPrecacheMaterial(Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
    L.AddPrecacheMaterial(Texture'ONSInterface-TX.avrilRETICLE');
    L.AddPrecacheMaterial(Texture'VMWeaponsTX.PlayerWeaponsGroup.LGRreticleRed');
	L.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.AVRiLGroup.AVRiLprojectileSM');
	L.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.AVRiLsm');
	L.AddPrecacheStaticMesh(StaticMesh'SC_MeshParticles.Wood.wood2');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.EHAVRiLtex');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
	Level.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.rockchunks02');
	Level.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
	Level.AddPrecacheMaterial(Texture'ONSBPTextures.fX.ExploTrans');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
	Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
	Level.AddPrecacheMaterial(Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX');
	Level.AddPrecacheMaterial(Texture'VMParticleTextures.VehicleExplosions.VMExp2_framesANIM');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
    Level.AddPrecacheMaterial(Texture'ONSInterface-TX.avrilRETICLE');
    Level.AddPrecacheMaterial(Texture'VMWeaponsTX.PlayerWeaponsGroup.LGRreticleRed');
	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.AVRiLGroup.AVRiLprojectileSM');
	Level.AddPrecacheStaticMesh(StaticMesh'VMWeaponsSM.AVRiLsm');
	Level.AddPrecacheStaticMesh(StaticMesh'SC_MeshParticles.Wood.wood2');
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.700000
     InventoryType=Class'tk_EHWeapons.EHAVRiL'
     PickupMessage="You got the Enhanced AVRiL."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="EHAVRiLPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.AVRiLsm'
     DrawScale=0.050000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     Skins(1)=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX'
     AmbientGlow=12
}
