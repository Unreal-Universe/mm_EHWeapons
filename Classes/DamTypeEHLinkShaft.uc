class DamTypeEHLinkShaft extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'HitSmokeBlack';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitSmokeBlack';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'EHHitFlame';
}

defaultproperties
{
     WeaponClass=Class'EHWeaponsE.EHLinkGun'
     DeathString="%o was carved up by %k's green shaft."
     FemaleSuicide="%o shafted herself."
     MaleSuicide="%o shafted himself."
     bDetonatesGoop=True
     bSkeletize=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.500000
}
