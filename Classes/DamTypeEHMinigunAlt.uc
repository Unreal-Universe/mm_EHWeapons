class DamTypeEHMinigunAlt extends WeaponDamageType
	abstract;
static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'EHHitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitSmoke';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHMinigun'
     DeathString="%o was mowed down by %k's enhanced minigun."
     FemaleSuicide="%o turned the enhanced minigun on herself."
     MaleSuicide="%o turned the enhanced minigun on himself."
     bDetonatesGoop=True
     bRagdollBullet=True
     bBulletHit=True
     GibModifier=0.500000
     FlashFog=(X=600.000000)
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.650000
}
