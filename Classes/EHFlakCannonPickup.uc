class EHFlakCannonPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=WeaponStaticMesh.usx
#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="tk_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'XEffects.FlakTrailTex');
    if ( L.DetailMode != DM_Low )
	L.AddPrecacheMaterial(Texture'XEffects.fexpt');
    L.AddPrecacheMaterial(Texture'XEffects.ExplosionFlashTex');
    L.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.LargeFlames');
    L.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2s');
    L.AddPrecacheMaterial(Texture'XEffects.GoldGlow');
    L.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.Flak3rdperson2');
    L.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex1');
    L.AddPrecacheMaterial(Texture'WeaponSkins.FlakChunkTex');
    L.AddPrecacheMaterial(Texture'XWeapons.NewFlakSkin');
    L.AddPrecacheMaterial(Texture'XGameShaders.flak_flash');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.flakchunk');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.flakshell');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.FlakCannonPickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'XEffects.FlakTrailTex');
    if ( Level.DetailMode != DM_Low )
    Level.AddPrecacheMaterial(Texture'EmitterTextures.MultiFrame.LargeFlames');
    Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Fire.Part_explode2s');
	Level.AddPrecacheMaterial(Texture'XEffects.fexpt');
    Level.AddPrecacheMaterial(Texture'XEffects.ExplosionFlashTex');
    Level.AddPrecacheMaterial(Texture'XEffects.GoldGlow');
    Level.AddPrecacheMaterial(Texture'tk_EHWeapons.EHWeaponSkinsB.Flak3rdperson2');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex1');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.FlakChunkTex');
    Level.AddPrecacheMaterial(Texture'XWeapons.NewFlakSkin');
    Level.AddPrecacheMaterial(Texture'XGameShaders.flak_flash');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.flakchunk');
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.flakshell');
	Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     StandUp=(Z=0.250000)
     MaxDesireability=0.750000
     InventoryType=Class'tk_EHWeapons.EHFlakCannon'
     PickupMessage="You got the Enhanced Flak Cannon."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="EHFlakCannonPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.FlakCannonPickup'
     bUseDynamicLights=True
     DrawScale=0.550000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.Flak3rdperson2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
