class EHMineFire extends tK_BioFire;

var class<Projectile> RedMineClass;
var class<Projectile> BlueMineClass;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile p;
    local int x;

    if (Weapon.Instigator.GetTeamNum() == 0)
        ProjectileClass = RedMineClass;

    if (Weapon.Instigator.GetTeamNum() == 1)
        ProjectileClass = BlueMineClass;

    if( ProjectileClass != None )
        p = Weapon.Spawn(ProjectileClass, Weapon,, Start, Dir);

    if( p == None )
        return None;

    p.Damage *= DamageAtten;
    if (EHMineLauncher(Weapon) != None)
    {
        if (EHMineLauncher(Weapon).CurrentMines >= EHMineLauncher(Weapon).MaxMines)
	{
		for (x = 0; x < EHMineLauncher(Weapon).Mines.length; x++)
		{
			if (EHMineLauncher(Weapon).Mines[x] == None)
			{
				EHMineLauncher(Weapon).Mines.Remove(x, 1);
				x--;
			}
			else
			{
				EHMineLauncher(Weapon).Mines[x].Destroy();
				EHMineLauncher(Weapon).Mines.Remove(x, 1);
				break;
			}
		}
	}
	EHMineLauncher(Weapon).Mines[EHMineLauncher(Weapon).Mines.length] = p;
    	EHMineLauncher(Weapon).CurrentMines++;
    }

    return p;
}

function PlayFiring()
{
    Super.PlayFiring();
    EHMineLauncher(Weapon).PlayFiring(true);
}

defaultproperties
{
     RedMineClass=Class'mm_EHWeapons.EHMineProjectileRED'
     BlueMineClass=Class'mm_EHWeapons.EHMineProjectileBLUE'
     FireSound=Sound'ONSVehicleSounds-S.SpiderMines.SpiderMineFire01'
     FireRate=1.100000
     AmmoClass=Class'mm_EHWeapons.EHMineAmmo'
     ProjectileClass=Class'mm_EHWeapons.EHMineProjectile'
}
