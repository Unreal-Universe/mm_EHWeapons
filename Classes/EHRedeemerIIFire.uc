class EHRedeemerIIFire extends tK_ProjectileFire;

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile p;

    p = Super.SpawnProjectile(Start,Dir);
    if ( p == None )
        p = Super.SpawnProjectile(Instigator.Location,Dir);
    if ( p == None )
    {
	 	Weapon.Spawn(class'SmallRedeemerExplosion');
		Weapon.HurtRadius(500, 400, class'DamTypeEHRedeemerII', 100000, Instigator.Location);
	}
    return p;
}

function float MaxRange()
{
	return 20000;
}

defaultproperties
{
     ProjSpawnOffset=(X=100.000000,Z=0.000000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     TransientSoundVolume=1.000000
     FireSound=Sound'mm_EHWeapons.EHSounds.EHRedeemerFire'
     FireForce="redeemer_shoot"
     FireRate=1.000000
     AmmoClass=Class'mm_EHWeapons.EHRedeemerIIAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'mm_EHWeapons.EHRedeemerIIProjectile'
     BotRefireRate=0.500000
}
