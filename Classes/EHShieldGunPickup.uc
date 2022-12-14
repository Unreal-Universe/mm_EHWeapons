//=============================================================================
// EHShieldGunPickup.
//=============================================================================
class EHShieldGunPickup extends UTWeaponPickup;

defaultproperties
{
     MaxDesireability=0.390000
     InventoryType=Class'EHWeaponsE.EHShieldGun'
     PickupMessage="You got the Enhanced Shield Gun."
     PickupSound=Sound'PickupSounds.ShieldGunPickup'
     PickupForce="EHShieldGunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.ShieldGunPickup'
     bUseDynamicLights=True
     DrawScale=0.500000
     Skins(0)=Texture'EHWeaponSkinsB.ShieldTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
