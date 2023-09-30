class DamTypeEHAssaultGrenade extends WeaponDamageType
	abstract;

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHAssaultRifle'
     DeathString="%o tried to juggle %k's grenade."
     FemaleSuicide="%o jumped on her own grenade."
     MaleSuicide="%o jumped on his own grenade."
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
}
