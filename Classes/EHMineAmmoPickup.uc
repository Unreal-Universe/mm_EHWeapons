class EHMineAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=6
     InventoryType=Class'tk_EHWeapons.EHMineAmmo'
     PickupMessage="You picked up some Enhanced Mines"
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONSWeapons-SM.MineLayerAmmo'
     bUseDynamicLights=True
     DrawScale=0.400000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.EHminelayerTEX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
