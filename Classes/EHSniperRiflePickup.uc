class EHSniperRiflePickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=NewWeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Material'XGameShaders.WeaponEnvShader');
    L.AddPrecacheMaterial(Texture'NewSniperRifle.COGAssaultZoomedCrosshair');
    L.AddPrecacheMaterial(Texture'NewSniperRifle.NewSniper1');
    L.AddPrecacheMaterial(Texture'NewSniperRifle.Sniper2');
	L.AddPrecacheMaterial(Texture'Engine.WhiteTexture');
	L.AddPrecacheStaticMesh(StaticMesh'NewWeaponStatic.newsniperpickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'XGameShaders.WeaponEnvShader');
    Level.AddPrecacheMaterial(Texture'NewSniperRifle.COGAssaultZoomedCrosshair');
    Level.AddPrecacheMaterial(Texture'NewSniperRifle.NewSniper1');
    Level.AddPrecacheMaterial(Texture'NewSniperRifle.Sniper2');
	Level.AddPrecacheMaterial(Texture'Engine.WhiteTexture');
	super.UpdatePrecacheMaterials();
}

defaultproperties
{
     MaxDesireability=0.750000
     InventoryType=Class'mm_EHWeapons.EHSniperRifle'
     PickupMessage="You got the Enhanced Sniper Rifle."
     PickupSound=Sound'NewWeaponSounds.NewSniper_load'
     PickupForce="Enhanced Sniper Rifle"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NewWeaponStatic.newsniperpickup'
     DrawScale=0.210000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.Sniper12'
     AmbientGlow=12
}
