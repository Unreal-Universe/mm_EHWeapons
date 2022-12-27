class DamTypeEHSniperHeadshot extends WeaponDamageType
	abstract;

var class<LocalMessage> KillerMessage;
var sound HeadHunter; // OBSOLETE

static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Default.KillerMessage, 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}

defaultproperties
{
     KillerMessage=Class'XGame.SpecialKillMessage'
     WeaponClass=Class'tk_EHWeapons.EHSniperRifle'
     DeathString="%k put a bullet in %o's skull."
     FemaleSuicide="%o shot herself in the head."
     MaleSuicide="%o shot himself in the head."
     bAlwaysSevers=True
     bSpecial=True
     bCauseConvulsions=True
     VehicleDamageScaling=0.650000
}
