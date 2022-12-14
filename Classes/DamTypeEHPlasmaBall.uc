class DamTypeEHPlasmaBall extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'EHWeaponsE.HitElectricity';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'EHWeaponsE.HitElectricity';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'EHWeaponsE.HitElectricity';
}

defaultproperties
{
     WeaponClass=Class'EHWeaponsE.EHPlasmaRifle'
     DeathString="%o was wasted by %k's plasma ball."
     FemaleSuicide="%o snuffed herself with the plasma ball."
     MaleSuicide="%o snuffed himself with the plasma ball."
     bDetonatesGoop=True
     bCauseConvulsions=True
     bDelayedDamage=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DeathOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.800000
     DeathOverlayTime=0.800000
}
