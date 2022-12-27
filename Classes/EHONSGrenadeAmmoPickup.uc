class EHONSGrenadeAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=5
     InventoryType=Class'tk_EHWeapons.EHONSGrenadeAmmo'
     PickupMessage="You picked up some enhanced grenades"
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONSWeapons-SM.GrenadeLauncherAmmo'
     bUseDynamicLights=True
     DrawScale=0.250000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.EHGrenadeLauncherTEX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
