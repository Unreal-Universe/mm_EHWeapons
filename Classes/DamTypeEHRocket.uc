class DamTypeEHRocket extends WeaponDamageType
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
     WeaponClass=Class'tk_EHWeapons.EHRocketLauncher'
     DeathString="%o got blown to hell by %k's rocket."
     FemaleSuicide="%o fired her rocket prematurely."
     MaleSuicide="%o fired his rocket prematurely."
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleMomentumScaling=1.300000
}
