class EHRocketAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=9
     MaxDesireability=0.300000
     InventoryType=Class'EHWeaponsE.EHRocketAmmo'
     PickupMessage="You picked up an enhanced rocket pack."
     PickupSound=Sound'PickupSounds.RocketAmmoPickup'
     PickupForce="EHRocketAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketAmmoPickup'
     DrawScale=0.700000
     PrePivot=(Z=2.500000)
     Skins(0)=Texture'EHWeaponSkinsB.RocketAmmoTex2'
     AmbientGlow=12
     CollisionHeight=13.500000
}
