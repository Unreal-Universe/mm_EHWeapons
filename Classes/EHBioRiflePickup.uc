class EHBioRiflePickup extends UTWeaponPickup;

#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'XEffects.xbiosplat2');
    L.AddPrecacheMaterial(Texture'XEffects.xbiosplat');
    L.AddPrecacheMaterial(Texture'XGameShaders.bio_flash');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.BioRifleTex02');
    L.AddPrecacheMaterial(Texture'WeaponSkins.BioGoo.BRInnerGoo');
    L.AddPrecacheMaterial(Texture'WeaponSkins.BioGoo.BRInnerBubbles');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.BioRiflePickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'XEffects.xbiosplat2');
    Level.AddPrecacheMaterial(Texture'XEffects.xbiosplat');
    Level.AddPrecacheMaterial(Texture'XGameShaders.bio_flash');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.BioRifleTex02');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.BioGoo.BRInnerGoo');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.BioGoo.BRInnerBubbles');

	super.UpdatePrecacheMaterials();
}

defaultproperties
{
     MaxDesireability=0.750000
     InventoryType=Class'mm_EHWeapons.EHBioRifle'
     PickupMessage="You got the Enhanced Bio-Rifle"
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="FlakCannonPickup"
     LightType=LT_Pulse
     LightHue=85
     LightSaturation=127
     LightBrightness=150.000000
     LightRadius=2.000000
     LightPeriod=60
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.BioRiflePickup'
     bUseDynamicLights=True
     bDynamicLight=True
     DrawScale=0.600000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.BioRifleTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
