class EHBioAmmoPickup extends UTAmmoPickup;

#exec OBJ LOAD FILE=PickupSounds.uax

simulated function PostBeginPlay()
{
	local actor HitActor;
	local vector HitLocation, HitNormal;

	Super.PostBeginPlay();

	// check to see if imbedded (stupid LD)
	HitActor = Trace(HitLocation, HitNormal, Location - CollisionHeight * vect(0,0,1), Location + CollisionHeight * vect(0,0,1), false);
	if ( (HitActor != None) && HitActor.bWorldGeometry )
		SetLocation(HitLocation + vect(0,0,1) * CollisionHeight);
}

defaultproperties
{
     AmmoAmount=20
     MaxDesireability=0.320000
     InventoryType=Class'tk_EHWeapons.EHBioAmmo'
     PickupMessage="You picked up some Enhanced Bio-Rifle ammo"
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     LightType=LT_Pulse
     LightHue=85
     LightSaturation=127
     LightBrightness=150.000000
     LightRadius=1.000000
     LightPeriod=60
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.BioAmmoPickup'
     bUseDynamicLights=True
     bDynamicLight=True
     PrePivot=(Z=10.500000)
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.BioRiflePickup2'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     CollisionHeight=8.250000
}
