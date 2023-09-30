class DamTypeEHGrenadeChunk extends WeaponDamageType
	abstract;

var sound FlakMonkey; //OBSOLETE

static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.flakcount++;
		if ( (xPRI.flakcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('FlackMonkey',15);
	}
}

defaultproperties
{
     WeaponClass=Class'mm_EHWeapons.EHAssaultRifle'
     DeathString="%o was shredded by %k's enhanced grenade shrapnel."
     FemaleSuicide="%o was perforated by her own grenade shrapnel."
     MaleSuicide="%o was perforated by his own grenade shrapnel."
     bDelayedDamage=True
     bBulletHit=True
     VehicleMomentumScaling=0.500000
}
