class EHAssaultFire extends tK_InstantFire;

var float LastFireTime;
var float ClickTime;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

function FlashMuzzleFlash()
{
    local rotator r;
    r.Roll = Rand(65536);
    Weapon.SetBoneRotation('Bone_Flash', r, 0, 1.f);
    //Weapon.Spawn(class'EHTracerProjectile');
    Super.FlashMuzzleFlash();
}

event ModeDoFire()
{
	if ( Level.TimeSeconds - LastFireTime > 0.5 )
		Spread = Default.Spread;
	else
		Spread = FMin(Spread+0.02,0.12);
	LastFireTime = Level.TimeSeconds;
	Super.ModeDoFire();
}

simulated function bool AllowFire()
{
    if (Super.AllowFire())
        return true;
    else
    {
        if ( (PlayerController(Instigator.Controller) != None) && (Level.TimeSeconds > ClickTime) )
        {
            Instigator.PlaySound(Sound'WeaponSounds.P1Reload5');
			ClickTime = Level.TimeSeconds + 0.25;
		}
        return false;
    }
}

function StartBerserk()
{
    DamageMin = default.DamageMin * 1.33;
    DamageMax = default.DamageMax * 1.33;
}

function StopBerserk()
{
    DamageMin = default.DamageMin;
    DamageMax = default.DamageMax;
}

function StartSuperBerserk()
{
    FireRate = default.FireRate * 1.5/Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * 0.667 * Level.GRI.WeaponBerserk;
    DamageMin = default.DamageMin * 1.5;
    DamageMax = default.DamageMax * 1.5;
    if (EHAssaultRifle(Weapon) != None && EHAssaultRifle(Weapon).bDualMode)
    	FireRate *= 0.55;
}

defaultproperties
{
     DamageType=Class'tk_EHWeapons.DamTypeEHAssaultBullet'
     DamageMin=7
     DamageMax=7
     Momentum=0.000000
     bPawnRapidFireAnim=True
     FireLoopAnim=
     FireEndAnim=
     FireSound=Sound'tk_EHWeapons.EHSounds.EHASFire'
     FireForce="EHAssaultRifleFire"
     FireRate=0.160000
     AmmoClass=Class'tk_EHWeapons.EHAssaultAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=50.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=1.000000,Y=1.000000,Z=1.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'tk_EHWeapons.EHAssaultMuzFlash1st'
     aimerror=800.000000
     Spread=0.020000
     SpreadStyle=SS_Random
}
