class EHShockAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     InventoryType=Class'tk_EHWeapons.EHShockAmmo'
     PickupMessage="You picked up an Enhanced Shock Core."
     PickupSound=Sound'PickupSounds.ShockAmmoPickup'
     PickupForce="EHShockAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.ShockAmmoPickup'
     bUseDynamicLights=True
     DrawScale3D=(X=0.800000,Z=0.500000)
     PrePivot=(Z=32.000000)
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.ShockAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=32.000000
}
