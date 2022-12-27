class EHSniperAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     InventoryType=Class'tk_EHWeapons.EHSniperAmmo'
     PickupMessage="You picked up enhanced sniper ammo."
     PickupSound=Sound'PickupSounds.SniperAmmoPickup'
     PickupForce="EHSniperAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponStatic.ClassicSniperAmmoM'
     PrePivot=(Z=16.000000)
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.ClassicSniperAmmoT2'
     AmbientGlow=12
     CollisionHeight=16.000000
}
