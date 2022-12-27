class DamTypeEHAVRiLRocket extends WeaponDamageType
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
     WeaponClass=Class'tk_EHWeapons.EHAVRiL'
     DeathString="%k blew %o away with an ENHANCED AVRiL."
     FemaleSuicide="%o pointed her gun the wrong way."
     MaleSuicide="%o pointed his gun the wrong way."
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=1.600000
}
