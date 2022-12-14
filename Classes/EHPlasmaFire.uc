class EHPlasmaFire extends ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

defaultproperties
{
     ProjSpawnOffset=(X=24.000000,Y=8.000000,Z=0.000000)
     bSplashDamage=True
     TransientSoundVolume=0.400000
     FireAnimRate=1.500000
     FireSound=Sound'EHSounds.EHPlasmaFire'
     FireForce="EHPlasmaRifleFire"
     FireRate=0.220000
     AmmoClass=Class'EHWeaponsE.EHLinkAmmo'
     AmmoPerFire=1
     ProjectileClass=Class'EHWeaponsE.EHPlasmaProjectile'
     BotRefireRate=0.350000
     FlashEmitterClass=Class'EHWeaponsE.PlasmaMuzFlash'
     aimerror=800.000000
     Spread=0.120000
     SpreadStyle=SS_Random
}
