class DamTypeEHBioGlob extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'mm_EHWeapons.EHBioGoopSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'mm_EHWeapons.EHBioGoopSmoke';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'mm_EHWeapons.EHBioGoopSmoke';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHBioRifle'
     DeathString="%o was slimed by %k's enhanced bio-rifle."
     FemaleSuicide="%o was slimed by her own goop."
     MaleSuicide="%o was slimed by his own goop."
     bDetonatesGoop=True
     bSkeletize=True
     bDelayedDamage=True
     bLeaveBodyEffect=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=3.000000
}
