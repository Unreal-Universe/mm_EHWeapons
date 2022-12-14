class EHLinkAmmoPickup extends UTAmmoPickup;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( Level.Game.bAllowVehicles )
		MaxDesireability *= 1.9;
}

defaultproperties
{
     AmmoAmount=70
     MaxDesireability=0.240000
     InventoryType=Class'EHWeaponsE.EHLinkAmmo'
     PickupMessage="You picked up enhanced link charges."
     PickupSound=Sound'PickupSounds.LinkAmmoPickup'
     PickupForce="EHLinkAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkAmmoPickup'
     bUseDynamicLights=True
     Skins(0)=Texture'EHWeaponSkinsB.LinkAmmoTex2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=10.500000
}
