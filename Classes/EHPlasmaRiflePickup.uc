class EHPlasmaRiflePickup extends UTWeaponPickup;

#EXEC OBJ LOAD FILE=NewWeaponSounds.uax
#exec OBJ LOAD FILE=WeaponStaticMesh.usx

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.LinkTex02');
    L.AddPrecacheMaterial(Texture'AW-2004Particles.Energy.SmoothRing');
    L.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.pannelLightning');
    L.AddPrecacheMaterial(Texture'AW-2004Particles.Energy.ElecPanels');
    L.AddPrecacheMaterial(Texture'XEffects.Skins.pcl_BlueSpark');
    L.AddPrecacheMaterial(FinalBlend'tk_EHWeapons.EHWeaponSkinsB.PlasmaFlashFB');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.LinkGunPickup');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.ShockMuzFlash');
}

simulated function UpdatePrecacheMaterials()
{

    Level.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.LinkTex02');
    Level.AddPrecacheMaterial(Texture'AW-2004Particles.Energy.SmoothRing');
    Level.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.pannelLightning');
    Level.AddPrecacheMaterial(Texture'AW-2004Particles.Energy.ElecPanels');
    Level.AddPrecacheMaterial(Texture'XEffects.Skins.pcl_BlueSpark');
    Level.AddPrecacheMaterial(FinalBlend'tk_EHWeapons.EHWeaponSkinsB.PlasmaFlashFB');
    Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.LinkGunPickup');
    Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.ShockMuzFlash');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.LinkGunPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.ShockMuzFlash');
	Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.630000
     InventoryType=Class'tk_EHWeapons.EHPlasmaRifle'
     PickupMessage="You got the Enhanced Plasma Rifle."
     PickupSound=Sound'PickupSounds.LinkGunPickup'
     PickupForce="EHPlasmaRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkGunPickup'
     bUseDynamicLights=True
     DrawScale=0.550000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.LinkTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
