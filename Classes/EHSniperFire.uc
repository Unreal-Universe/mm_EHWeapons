class EHSniperFire extends tK_InstantFire;

var() float HeadShotDamageMult;
var() class<DamageType> DamageTypeHeadShot;
var name FireAnims[3];

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'dummy01');
}

function FlashMuzzleFlash()
{
    local rotator r;

    r.Yaw = 16384;
    Weapon.SetBoneRotation('dummy01', r, 0, 1.f);
    Super.FlashMuzzleFlash();
}

function DoTrace(Vector Start, Rotator Dir)
{
    local Vector X,Y,Z, End, HitLocation, HitNormal, ArcEnd;
    local Actor Other;
    local SniperWallHitEffect S;
    local Pawn HeadShotPawn;

    Weapon.GetViewAxes(X, Y, Z);
    if ( Weapon.WeaponCentered() )
        ArcEnd = (Instigator.Location +
			Weapon.EffectOffset.X * X +
			1.5 * Weapon.EffectOffset.Z * Z);
	else
        ArcEnd = (Instigator.Location +
			Instigator.CalcDrawOffset(Weapon) +
			Weapon.EffectOffset.X * X +
			Weapon.Hand * Weapon.EffectOffset.Y * Y +
			Weapon.EffectOffset.Z * Z);
            Weapon.Spawn(class'mm_EHWeapons.EHSniperTracerEffect',,,Start,Dir);
    X = Vector(Dir);
    End = Start + TraceRange * X;
    Other = Weapon.Trace(HitLocation, HitNormal, End, Start, true);


    if ( Other != None && (Other != Instigator) )
    {
        if ( !Other.bWorldGeometry )
        {
            if (Vehicle(Other) != None)
                HeadShotPawn = Vehicle(Other).CheckForHeadShot(HitLocation, X, 1.0);

            if (HeadShotPawn != None)
                HeadShotPawn.TakeDamage(DamageMax * HeadShotDamageMult, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
 			else if ( (Pawn(Other) != None) && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))
                Other.TakeDamage(DamageMax * HeadShotDamageMult, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
            else
                Other.TakeDamage(DamageMax, Instigator, HitLocation, Momentum*X, DamageType);
        }
        else
				HitLocation = HitLocation + 2.0 * HitNormal;
    }
    else
    {
        HitLocation = End;
        HitNormal = Normal(Start - End);
    }

    if ( (HitNormal != Vect(0,0,0)) && (HitScanBlockingVolume(Other) == None) )
    {
		S = Weapon.Spawn(class'SniperWallHitEffect',,, HitLocation, rotator(-1 * HitNormal));
		if ( S != None )
			S.FireStart = Start;
	}
}

function PlayFiring()
{
	Weapon.PlayAnim(FireAnims[Rand(3)], FireAnimRate, TweenTime);
    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,,Default.FireAnimRate/FireAnimRate,false);
    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

defaultproperties
{
     HeadShotDamageMult=2.000000
     DamageTypeHeadShot=Class'mm_EHWeapons.DamTypeEHSniperHeadshot'
     FireAnims(0)="Fire1"
     FireAnims(1)="Fire2"
     FireAnims(2)="fire3"
     DamageType=Class'mm_EHWeapons.DamTypeEHSniper'
     DamageMin=60
     DamageMax=60
     TraceRange=17000.000000
     FireAnimRate=1.500000
     FireSound=Sound'mm_EHWeapons.EHSounds.EHSniperShot'
     FireForce="NewSniperShot"
     FireRate=1.330000
     AmmoClass=Class'mm_EHWeapons.EHSniperAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-15.000000,Z=10.000000)
     ShakeOffsetRate=(X=-4000.000000,Z=4000.000000)
     ShakeOffsetTime=1.600000
     BotRefireRate=0.400000
     WarnTargetPct=0.500000
     FlashEmitterClass=Class'XEffects.AssaultMuzFlash1st'
     aimerror=850.000000
}
