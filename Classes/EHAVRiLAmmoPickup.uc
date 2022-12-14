//-----------------------------------------------------------
//
//-----------------------------------------------------------
class EHAVRiLAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=5
     InventoryType=Class'EHWeaponsE.EHAVRiLAmmo'
     PickupMessage="You picked up some Enhanced Anti-Vehicle Rockets"
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONSWeapons-SM.AVRILammo'
     bUseDynamicLights=True
     DrawScale=0.400000
     Skins(0)=Texture'EHWeaponSkinsB.EHAVRiLtex'
     AmbientGlow=12
}
