class EHLinkAltFire extends ProjectileFire;

var sound EHLinkedFireSound;
var string EHLinkedFireForce;  // jdf

function DrawMuzzleFlash(Canvas Canvas)
{
    if (FlashEmitter != None)
    {
        FlashEmitter.SetRotation(Weapon.Rotation);
        Super.DrawMuzzleFlash(Canvas);
    }
}

simulated function bool AllowFire()
{
    return ( Weapon.AmmoAmount(ThisModeNum) >= 1 );
}

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local EHLinkProjectile Proj;

    Start += Vector(Dir) * 10.0 * EHLinkGun(Weapon).Links;
    Proj = Weapon.Spawn(class'EHWeaponsE.EHLinkProjectile',,, Start, Dir);
    if ( Proj != None )
    {
		Proj.Links = EHLinkGun(Weapon).Links;
		Proj.LinkAdjust();
	}
    return Proj;
}

function FlashMuzzleFlash()
{
    if (FlashEmitter != None)
    {
        if (EHLinkGun(Weapon).Links > 0)
            FlashEmitter.Skins[0] = FinalBlend'XEffectMat.LinkMuzProjYellowFB';
        else
            FlashEmitter.Skins[0] = FinalBlend'XEffectMat.LinkMuzProjGreenFB';
    }
    Super.FlashMuzzleFlash();
}

function ServerPlayFiring()
{
    if (EHLinkGun(Weapon).Links > 0)
        FireSound = EHLinkedFireSound;
    else
        FireSound = default.FireSound;
    Super.ServerPlayFiring();
}

function PlayFiring()
{
    if (EHLinkGun(Weapon).Links > 0)
        FireSound = EHLinkedFireSound;
    else
        FireSound = default.FireSound;
    Super.PlayFiring();
}

defaultproperties
{
     EHLinkedFireSound=Sound'WeaponSounds.LinkGun.BLinkedFire'
     EHLinkedFireForce="BLinkedFire"
     ProjSpawnOffset=(X=25.000000,Y=8.000000,Z=-3.000000)
     FireLoopAnim=
     FireEndAnim=
     FireAnimRate=0.750000
     FireSound=Sound'WeaponSounds.BaseFiringSounds.BPulseRifleAltFire'
     FireForce="TranslocatorFire"
     FireRate=0.200000
     AmmoClass=Class'EHWeaponsE.EHLinkAmmo'
     AmmoPerFire=2
     ShakeRotMag=(X=40.000000)
     ShakeRotRate=(X=2000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=1.000000)
     ShakeOffsetRate=(Y=-2000.000000)
     ShakeOffsetTime=4.000000
     ProjectileClass=Class'EHWeaponsE.EHLinkProjectile'
     BotRefireRate=0.990000
     WarnTargetPct=0.100000
     FlashEmitterClass=Class'XEffects.LinkMuzFlashProj1st'
}
