class EHAssaultRiflePickup extends UTWeaponPickup;

#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.AssaultRifleTex02');
    L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
    L.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.rockchunks02');
    L.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
    L.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
    L.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
    L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.LinkGunPickup');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.ShockMuzFlash');
}

simulated function UpdatePrecacheMaterials()
{

    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.AssaultRifleTex02');
    Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.DustSmoke');
    Level.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.rockchunks02');
    Level.AddPrecacheMaterial(Texture'EpicParticles.Smoke.SparkCloud_01aw');
    Level.AddPrecacheMaterial(Texture'BenTex01.textures.SmokePuff01');
    Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2');
    Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.HardSpot');
    Level.AddPrecacheStaticMesh(StaticMesh'AS_Weapons_SM.MuzzleFlash.ASMinigun_Muzzle');
    Level.AddPrecacheStaticMesh(StaticMesh'NewWeaponPickups.AssaultPickupSM');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'AS_Weapons_SM.MuzzleFlash.ASMinigun_Muzzle');
	Level.AddPrecacheStaticMesh(StaticMesh'NewWeaponPickups.AssaultPickupSM');
	Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.400000
     InventoryType=Class'mm_EHWeapons.EHAssaultRifle'
     PickupMessage="You got the Enhanced Assault Rifle."
     PickupSound=Sound'PickupSounds.AssaultRiflePickup'
     PickupForce="EHAssaultRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponPickups.AssaultPickupSM'
     bUseDynamicLights=True
     DrawScale=0.500000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.AssaultRifleTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
