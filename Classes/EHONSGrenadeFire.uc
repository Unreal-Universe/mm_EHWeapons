//-----------------------------------------------------------
//
//-----------------------------------------------------------
class EHONSGrenadeFire extends BioFire;

simulated function bool AllowFire()
{
	if (EHONSGrenadeLauncher(Weapon).CurrentGrenades >= EHONSGrenadeLauncher(Weapon).MaxGrenades)
		return false;

	return Super.AllowFire();
}

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local EHONSGrenadeProjectile G;

	G = EHONSGrenadeProjectile(Super.SpawnProjectile(Start, Dir));
	if (G != None && EHONSGrenadeLauncher(Weapon) != None)
	{
		G.SetOwner(Weapon);
		EHONSGrenadeLauncher(Weapon).Grenades[EHONSGrenadeLauncher(Weapon).Grenades.length] = G;
		EHONSGrenadeLauncher(Weapon).CurrentGrenades++;
	}

	return G;
}

defaultproperties
{
     bSplashDamage=False
     bRecommendSplashDamage=False
     FireSound=Sound'NewWeaponSounds.NewGrenadeShoot'
     FireRate=0.650000
     AmmoClass=Class'EHWeaponsE.EHONSGrenadeAmmo'
     ProjectileClass=Class'EHWeaponsE.EHONSGrenadeProjectile'
}
