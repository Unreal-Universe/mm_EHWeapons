class DamTypeEHMinigunBullet extends WeaponDamageType
	abstract;
static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'ImpactDust';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'ImpactDust';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'ImpactDust';
}

defaultproperties
{
     WeaponClass=Class'tk_EHWeapons.EHMinigun'
     DeathString="%o was mowed down by %k's enhanced minigun."
     FemaleSuicide="%o turned the enhanced minigun on herself."
     MaleSuicide="%o turned the enhanced minigun on himself."
     bDetonatesGoop=True
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.650000
}
