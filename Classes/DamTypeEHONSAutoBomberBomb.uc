class DamTypeEHONSAutoBomberBomb extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'EHHitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'EHHitFlame';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHONSPainter'
     DeathString="%k blew %o away with an enhanced air strike."
     FemaleSuicide="%o blew herself away with an enhanced air strike."
     MaleSuicide="%o blew himself away with an enhanced air strike."
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=1.600000
}
