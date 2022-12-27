class EHPainterPickup extends UTWeaponPickup;

function PrebeginPlay()
{
	Super.PreBeginPlay();
	if ( Level.Game.IsA('xMutantGame') )
		Destroy();
}

function SetWeaponStay()
{
	bWeaponStay = false;
}

function float GetRespawnTime()
{
	return ReSpawnTime;
}

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.IonBeamPanner');
	L.AddPrecacheMaterial(Material'XEffectMat.ion_grey');
	L.AddPrecacheMaterial(Material'XEffectMat.Ion_beam');
	L.AddPrecacheMaterial(Material'EpicParticles.Smokepuff2');
	L.AddPrecacheMaterial(Material'EpicParticles.IonBurn2');
	L.AddPrecacheMaterial(Material'EpicParticles.BurnFlare1');
	L.AddPrecacheMaterial(Material'EpicParticles.WhiteStreak01aw');
	L.AddPrecacheMaterial(Material'EpicParticles.Smokepuff');
	L.AddPrecacheMaterial(Material'EpicParticles.SoftFlare');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.PainterPickup');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Material'tk_EHWeapons.EHWeaponSkinsB.IonBeamPanner');
	Level.AddPrecacheMaterial(Material'XEffectMat.ion_grey');
	Level.AddPrecacheMaterial(Material'XEffectMat.Ion_beam');
	Level.AddPrecacheMaterial(Material'EpicParticles.Smokepuff2');
	Level.AddPrecacheMaterial(Material'EpicParticles.IonBurn2');
	Level.AddPrecacheMaterial(Material'EpicParticles.BurnFlare1');
	Level.AddPrecacheMaterial(Material'EpicParticles.WhiteStreak01aw');
	Level.AddPrecacheMaterial(Material'EpicParticles.Smokepuff');
	Level.AddPrecacheMaterial(Material'EpicParticles.SoftFlare');

	super.UpdatePrecacheMaterials();
}

defaultproperties
{
     bWeaponStay=False
     MaxDesireability=1.500000
     InventoryType=Class'tk_EHWeapons.EHPainter'
     RespawnTime=120.000000
     PickupMessage="You got the Enhanced Ion Painter."
     PickupSound=Sound'PickupSounds.LinkGunPickup'
     PickupForce="LinkGunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.PainterPickup'
     bUseDynamicLights=True
     DrawScale=0.600000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.PainterTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
