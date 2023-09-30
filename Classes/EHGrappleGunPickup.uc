class EHGrappleGunPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=NewWeaponPickups.usx
#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"

static function StaticPrecache(LevelInfo L)
{
	if ( class'EHGrappleGun'.Default.bUseOldWeaponMesh )
    L.AddPrecacheMaterial(Texture'XEffectMat.link_muz_green');
    L.AddPrecacheMaterial(Texture'XEffectMat.link_muzmesh_green');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkGreen');
	L.AddPrecacheMaterial(Texture'XEffectMat.link_spark_green');
	L.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.PlasmaShaft');
	L.AddPrecacheMaterial(Texture'XEffectMat.Link.link_muz_blue');
	L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkBlue');
	L.AddPrecacheMaterial(Texture'XEffectMat.Link.link_muz_red');
	L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkRed');
    L.AddPrecacheMaterial(Texture'XEffectMat.link_muz_yellow');
    L.AddPrecacheMaterial(Texture'XEffectMat.link_muzmesh_yellow');
    L.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkYellow');
	L.AddPrecacheMaterial(Texture'XEffectMat.link_spark_yellow');
	L.AddPrecacheMaterial(Texture'UT2004Weapons.NewWeaps.LinkPowerBlue');
	L.AddPrecacheMaterial(Texture'UT2004Weapons.NewWeaps.LinkPowerRed');
	L.AddPrecacheMaterial(Texture'EpicParticles.Flares.FlickerFlare');


	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.linkprojectile');
	L.AddPrecacheStaticMesh(StaticMesh'NewWeaponPickups.LinkPickupSM');
}

simulated function UpdatePrecacheMaterials()
{
	if ( class'LinkGun'.Default.bUseOldWeaponMesh )
    Level.AddPrecacheMaterial(Texture'XEffectMat.link_muz_green');
    Level.AddPrecacheMaterial(Texture'XEffectMat.link_muzmesh_green');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkGreen');
	Level.AddPrecacheMaterial(Texture'XEffectMat.link_spark_green');
	Level.AddPrecacheMaterial(Texture'XEffectMat.Link.link_muz_blue');
	Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkBlue');
	Level.AddPrecacheMaterial(Texture'XEffectMat.Link.link_muz_red');
	Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkRed');
	Level.AddPrecacheMaterial(Texture'AW-2004Particles.Weapons.PlasmaShaft');
    Level.AddPrecacheMaterial(Texture'XEffectMat.link_muz_yellow');
    Level.AddPrecacheMaterial(Texture'XEffectMat.link_muzmesh_yellow');
    Level.AddPrecacheMaterial(Texture'mm_EHWeapons.EHWeaponSkinsB.LinkYellow');
	Level.AddPrecacheMaterial(Texture'XEffectMat.link_spark_yellow');
	Level.AddPrecacheMaterial(Texture'UT2004Weapons.NewWeaps.LinkPowerBlue');
	Level.AddPrecacheMaterial(Texture'UT2004Weapons.NewWeaps.LinkPowerRed');
	Level.AddPrecacheMaterial(Texture'EpicParticles.Flares.FlickerFlare');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.linkprojectile');
	Super.UpdatePrecacheStaticMeshes();
}

function float BotDesireability(Pawn Bot)
{
	local Bot B;
	local DestroyableObjective O;

	B = Bot(Bot.Controller);
	if (B != None && B.Squad != None)
	{
		O = DestroyableObjective(B.Squad.SquadObjective);
		if ( O != None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity && VSize(Bot.Location - O.Location) < 2000
		     && (AllowRepeatPickup() || Bot.FindInventoryType(InventoryType) == None) )
			return MaxDesireability * 2;
	}

	return Super.BotDesireability(Bot);
}

defaultproperties
{
     StandUp=(Y=0.250000,Z=0.000000)
     MaxDesireability=0.700000
     InventoryType=Class'mm_EHWeapons.EHGrappleGun'
     PickupMessage="You got the Enhanced Grapple Gun."
     PickupSound=Sound'PickupSounds.LinkGunPickup'
     PickupForce="EHGrappleGunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponPickups.LinkPickupSM'
     bUseDynamicLights=True
     DrawScale=0.650000
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
