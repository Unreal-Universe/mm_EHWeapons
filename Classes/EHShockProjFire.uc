class EHShockProjFire extends tK_ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

// for bot combos
function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile p;

    p = Super.SpawnProjectile(Start,Dir);
	if ( (EHShockRifle(Instigator.Weapon) != None) && (p != None) )
		EHShockRifle(Instigator.Weapon).SetComboTarget(EHShockProjectile(P));
	return p;
}

defaultproperties
{
     ProjSpawnOffset=(X=24.000000,Y=8.000000,Z=0.000000)
     bSplashDamage=True
     TransientSoundVolume=0.400000
     FireAnim="AltFire"
     FireAnimRate=1.500000
     FireSound=Sound'mm_EHWeapons.EHSounds.EHShockAlt'
     FireForce="EHShockRifleAltFire"
     FireRate=0.600000
     AmmoClass=Class'mm_EHWeapons.EHShockAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=60.000000,Y=20.000000)
     ShakeRotRate=(X=1000.000000,Y=1000.000000)
     ShakeRotTime=2.000000
     ProjectileClass=Class'mm_EHWeapons.EHShockProjectile'
     BotRefireRate=0.350000
     FlashEmitterClass=Class'mm_EHWeapons.EHShockProjMuzFlash'
}
