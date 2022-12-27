class EHGrappleAmmoPickup extends UTAmmoPickup;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( Level.Game.bAllowVehicles )
		MaxDesireability *= 1.9;
}

defaultproperties
{
     AmmoAmount=100
     MaxDesireability=0.240000
     InventoryType=Class'tk_EHWeapons.EHGrappleAmmo'
     PickupMessage="You picked up enhanced grapple charges."
     PickupSound=Sound'PickupSounds.LinkAmmoPickup'
     PickupForce="EHGrappleAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkAmmoPickup'
     bUseDynamicLights=True
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.LinkAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=10.500000
}
