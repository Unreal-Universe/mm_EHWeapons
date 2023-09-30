class DamTypeEHAssaultBullet extends WeaponDamageType
	abstract;

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHAssaultRifle'
     DeathString="%o was ventilated by %k's enhanced assault rifle."
     FemaleSuicide="%o assaulted herself."
     MaleSuicide="%o assaulted himself."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.700000
}
