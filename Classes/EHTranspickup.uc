class EHTransPickup extends UTWeaponPickup
	notplaceable;

defaultproperties
{
     InventoryType=Class'EHWeaponsE.EHTranslauncher'
     PickupMessage="You got the Enhanced Translocator."
     PickupSound=Sound'PickupSounds.SniperRiflePickup'
     PickupForce="SniperRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponPickups.TranslocatorCENTER'
     bUseDynamicLights=True
     DrawScale=0.200000
     Skins(0)=Texture'EHWeaponSkinsB.EHNEWTranslocatorTEX'
     Skins(1)=FinalBlend'WeaponSkins.AmmoPickups.NewTransGlassFB'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
