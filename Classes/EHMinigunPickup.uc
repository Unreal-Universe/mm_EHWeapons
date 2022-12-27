class EHMinigunPickup extends UTWeaponPickup;

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'XEffects.ShellCasingTex');
    L.AddPrecacheMaterial(Texture'AW-2004Explosions.Part_explode2s');
    L.AddPrecacheMaterial(Texture'AW-2004Particles.TracerShot');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.MinigunPickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'XEffects.ShellCasingTex');
    Level.AddPrecacheMaterial(Texture'AW-2004Explosions.Part_explode2s');
    Level.AddPrecacheMaterial(Texture'AW-2004Particles.TracerShot');

	super.UpdatePrecacheMaterials();
}

defaultproperties
{
     MaxDesireability=0.730000
     InventoryType=Class'tk_EHWeapons.EHMinigun'
     PickupMessage="You got the Enhanced Minigun."
     PickupSound=Sound'PickupSounds.MinigunPickup'
     PickupForce="EHMinigunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.MinigunPickup'
     bUseDynamicLights=True
     DrawScale=0.500000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.MinigunTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
