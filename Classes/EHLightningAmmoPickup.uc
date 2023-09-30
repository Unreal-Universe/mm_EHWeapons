class EHLightningAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     InventoryType=Class'mm_EHWeapons.EHLightningAmmo'
     PickupMessage="You picked up enhanced lightning ammo."
     PickupSound=Sound'PickupSounds.SniperAmmoPickup'
     PickupForce="EHLightningAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.SniperAmmoPickup'
     bUseDynamicLights=True
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.LightningAmmoTex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=19.000000
}
