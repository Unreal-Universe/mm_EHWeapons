class EHBioFire extends tK_ProjectileFire;

function DrawMuzzleFlash(Canvas Canvas)
{
    if (FlashEmitter != None)
        FlashEmitter.SetRotation(Weapon.Rotation);
    Super.DrawMuzzleFlash(Canvas);
}

function float MaxRange()
{
	return 1500;
}

defaultproperties
{
     ProjSpawnOffset=(X=20.000000,Y=9.000000,Z=-6.000000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     FireEndAnim=
     FireSound=Sound'mm_EHWeapons.EHSounds.EHBioRifleFire'
     FireForce="EHBioRifleFire"
     FireRate=0.330000
     AmmoClass=Class'mm_EHWeapons.EHBioAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=70.000000)
     ShakeRotRate=(X=1000.000000)
     ShakeRotTime=1.800000
     ShakeOffsetMag=(Z=-2.000000)
     ShakeOffsetRate=(Z=1000.000000)
     ShakeOffsetTime=1.800000
     ProjectileClass=Class'mm_EHWeapons.EHBioGlob'
     BotRefireRate=0.800000
     FlashEmitterClass=Class'XEffects.BioMuzFlash1st'
}
