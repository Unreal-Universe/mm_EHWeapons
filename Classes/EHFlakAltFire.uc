class EHFlakAltFire extends tK_ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter == None )
		FlashEmitter = Weapon.GetFireMode(0).FlashEmitter;
}

defaultproperties
{
     ProjSpawnOffset=(X=25.000000,Y=9.000000,Z=-12.000000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     FireAnim="AltFire"
     FireEndAnim=
     FireAnimRate=0.900000
     FireSound=Sound'mm_EHWeapons.EHSounds.EHFlakAltFire'
     FireForce="EHFlakCannonAltFire"
     FireRate=1.110000
     AmmoClass=Class'mm_EHWeapons.EHFlakAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'mm_EHWeapons.EHFlakShell'
     BotRefireRate=0.500000
     WarnTargetPct=0.900000
}
