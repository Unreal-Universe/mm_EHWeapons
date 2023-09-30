class EHTransFire extends tK_ProjectileFire;

var() Sound TransFireSound;
var() Sound RecallFireSound;
var() string EHTransFireForce;
var() String RecallFireForce;

simulated function PlayFiring()
{
    if (!EHTransLauncher(Weapon).bBeaconDeployed)
    {
        Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
        ClientPlayForceFeedback( EHTransFireForce );  // jdf
    }
}

function Rotator AdjustAim(Vector Start, float InAimError)
{
    return Instigator.Controller.Rotation;
}

simulated function bool AllowFire()
{
    return ( EHTransLauncher(Weapon).AmmoChargeF >= 1.0 );
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local EHTransBeacon EHTransBeacon;

    if (EHTransLauncher(Weapon).EHTransBeacon == None)
    {
		if ( (Instigator == None) || (Instigator.PlayerReplicationInfo == None) || (Instigator.PlayerReplicationInfo.Team == None) )
			EHTransBeacon = Weapon.Spawn(class'mm_EHWeapons.EHTransBeacon',,, Start, Dir);
		else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
			EHTransBeacon = Weapon.Spawn(class'mm_EHWeapons.EHRedBeacon',,, Start, Dir);
		else
			EHTransBeacon = Weapon.Spawn(class'mm_EHWeapons.EHBlueBeacon',,, Start, Dir);
        EHTransLauncher(Weapon).EHTransBeacon = EHTransBeacon;
        Weapon.PlaySound(TransFireSound,SLOT_Interact,,,,,false);
    }
    else
    {
        EHTransLauncher(Weapon).ViewPlayer();
        if ( EHTransLauncher(Weapon).EHTransBeacon.Disrupted() )
        {
			if( (Instigator != None) && (PlayerController(Instigator.Controller) != None) )
				PlayerController(Instigator.Controller).ClientPlaySound(Sound'WeaponSounds.BSeekLost1');
		}
		else
		{
			EHTransLauncher(Weapon).EHTransBeacon.Destroy();
			EHTransLauncher(Weapon).EHTransBeacon = None;
			Weapon.PlaySound(RecallFireSound,SLOT_Interact,,,,,false);
		}
    }
    return EHTransBeacon;
}

defaultproperties
{
     TransFireSound=SoundGroup'WeaponSounds.Translocator.TranslocatorFire'
     RecallFireSound=SoundGroup'WeaponSounds.Translocator.TranslocatorModuleRegeneration'
     EHTransFireForce="EHTranslocatorFire"
     RecallFireForce="TranslocatorModuleRegeneration"
     ProjSpawnOffset=(X=25.000000,Y=8.000000)
     bLeadTarget=False
     bWaitForRelease=True
     bModeExclusive=False
     FireAnimRate=1.500000
     FireRate=0.250000
     AmmoPerFire=1
     ProjectileClass=Class'mm_EHWeapons.EHTransBeacon'
     BotRefireRate=0.300000
}
