class DamTypeEHIonBlast extends WeaponDamageType
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
     WeaponClass=Class'EHWeaponsE.EHPainter'
     DeathString="%o was OBLITERATED by %k!"
     FemaleSuicide="%o was OBLITERATED"
     MaleSuicide="%o was OBLITERATED"
     bArmorStops=False
     bDetonatesGoop=True
     bSkeletize=True
     bCauseConvulsions=True
     bSuperWeapon=True
     bThrowRagdoll=True
     GibModifier=0.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
}
