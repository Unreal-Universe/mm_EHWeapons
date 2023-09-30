class EHFlakFire extends tK_ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

defaultproperties
{
     ProjPerFire=9
     ProjSpawnOffset=(X=25.000000,Y=5.000000,Z=-6.000000)
     FireEndAnim=
     FireAnimRate=3.950000
     FireSound=Sound'mm_EHWeapons.EHSounds.EHFlakFire'
     FireForce="EHFlakCannonFire"
     FireRate=0.894700
     AmmoClass=Class'mm_EHWeapons.EHFlakAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'mm_EHWeapons.EHFlakChunk'
     BotRefireRate=0.700000
     FlashEmitterClass=Class'XEffects.FlakMuzFlash1st'
     Spread=1400.000000
     SpreadStyle=SS_Random
}
