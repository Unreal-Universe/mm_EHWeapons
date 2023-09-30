class DamTypeEHLightningShot extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'mm_EHWeapons.HitElectricity';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'mm_EHWeapons.HitElectricity';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'mm_EHWeapons.HitElectricity';
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHLightningRifle'
     DeathString="%o rode %k's lightning."
     FemaleSuicide="%o had an electrifying experience."
     MaleSuicide="%o had an electrifying experience."
     bDetonatesGoop=True
     bCauseConvulsions=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     VehicleDamageScaling=0.850000
}
