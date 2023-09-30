class DamTypeEHShockBeam extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHShockRifle'
     DeathString="%o was fatally enlightened by %k's shock beam."
     FemaleSuicide="%o somehow managed to shoot herself with the shock rifle."
     MaleSuicide="%o somehow managed to shoot himself with the shock rifle."
     bDetonatesGoop=True
     bCauseConvulsions=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.750000
     VehicleDamageScaling=0.850000
     VehicleMomentumScaling=0.500000
}
