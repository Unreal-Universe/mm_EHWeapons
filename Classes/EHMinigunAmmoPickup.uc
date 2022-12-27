class EHMinigunAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'tk_EHWeapons.EHMinigunAmmo'
     PickupMessage="You picked up 50 bullets."
     PickupSound=Sound'PickupSounds.MinigunAmmoPickup'
     PickupForce="EHMinigunAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.MinigunAmmoPickup'
     bUseDynamicLights=True
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.MinigunAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=12.750000
}
