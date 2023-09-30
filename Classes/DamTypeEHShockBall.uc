class DamTypeEHShockBall extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHShockRifle'
     DeathString="%o was wasted by %k's shock core."
     FemaleSuicide="%o snuffed herself with the shock core."
     MaleSuicide="%o snuffed himself with the shock core."
     bDetonatesGoop=True
     bCauseConvulsions=True
     bDelayedDamage=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
}
