class EHAssaultAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=4
     InventoryType=Class'mm_EHWeapons.EHGrenadeAmmo'
     PickupMessage="You got a box of enhanced grenades and bullets."
     PickupSound=Sound'PickupSounds.AssaultAmmoPickup'
     PickupForce="EHAssaultAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.AssaultAmmoPickup'
     bUseDynamicLights=True
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.AssaultAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     TransientSoundVolume=0.400000
     CollisionHeight=12.500000
}
