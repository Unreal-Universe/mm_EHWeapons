class EHFlakAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     MaxDesireability=0.320000
     InventoryType=Class'tk_EHWeapons.EHFlakAmmo'
     PickupMessage="You picked up 10 Enhanced Flak Shells."
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="EHFlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.FlakAmmoPickup'
     bUseDynamicLights=True
     DrawScale=0.800000
     PrePivot=(Z=6.500000)
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.FlakAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=8.250000
}
