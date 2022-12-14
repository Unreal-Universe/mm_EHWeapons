class DamTypeEHLightningShot extends WeaponDamageType
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
     WeaponClass=Class'EHWeaponsE.EHLightningRifle'
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
