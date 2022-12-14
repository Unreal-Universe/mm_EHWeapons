class DamTypeEHLinkPlasma extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'EHBioSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'EHBioSmoke';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'EHBioSmoke';
}

defaultproperties
{
     WeaponClass=Class'EHWeaponsE.EHLinkGun'
     DeathString="%o was served an extra helping of %k's plasma."
     FemaleSuicide="%o fried herself with her own plasma blast."
     MaleSuicide="%o fried himself with his own plasma blast."
     bDetonatesGoop=True
     bDelayedDamage=True
     FlashFog=(X=700.000000)
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.500000
     VehicleDamageScaling=0.670000
}
