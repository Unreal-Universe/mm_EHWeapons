class EHShockBeamFire extends tK_InstantFire;

var() class<EHShockBeamEffect> BeamEffectClass;

#exec OBJ LOAD FILE=..\Sounds\WeaponSounds.uax

function DoFireEffect()
{
    local Vector StartTrace,X,Y,Z;
    local Rotator R, Aim;

    Instigator.MakeNoise(1.0);

    StartTrace = Instigator.Location + Instigator.EyePosition();
    if ( PlayerController(Instigator.Controller) != None )
    {
		// for combos
	   Weapon.GetViewAxes(X,Y,Z);
		StartTrace = StartTrace + X*class'EHShockProjFire'.Default.ProjSpawnOffset.X;
		if ( !Weapon.WeaponCentered() )
			StartTrace = StartTrace + Weapon.Hand * Y*class'EHShockProjFire'.Default.ProjSpawnOffset.Y + Z*class'ShockProjFire'.Default.ProjSpawnOffset.Z;
	}

    Aim = AdjustAim(StartTrace, AimError);
	R = rotator(vector(Aim) + VRand()*FRand()*Spread);
    DoTrace(StartTrace, R);
}

function InitEffects()
{
	if ( Level.DetailMode == DM_Low )
		FlashEmitterClass = None;
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

// for bot combos
function Rotator AdjustAim(Vector Start, float InAimError)
{
	if ( (EHShockRifle(Weapon) != None) && (EHShockRifle(Weapon).ComboTarget != None) )
		return Rotator(EHShockRifle(Weapon).ComboTarget.Location - Start);

	return Super.AdjustAim(Start, InAimError);
}

function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum)
{
    local EHShockBeamEffect Beam;

    if (Weapon != None)
    {
        Beam = Weapon.Spawn(BeamEffectClass,,, Start, Dir);
        if (ReflectNum != 0) Beam.Instigator = None; // prevents client side repositioning of beam start
            Beam.AimAt(HitLocation, HitNormal);
    }
}

defaultproperties
{
     BeamEffectClass=Class'tk_EHWeapons.EHShockBeamEffect'
     DamageType=Class'tk_EHWeapons.DamTypeEHShockBeam'
     DamageMin=45
     DamageMax=45
     TraceRange=17000.000000
     Momentum=60000.000000
     bReflective=True
     FireSound=Sound'tk_EHWeapons.EHSounds.EHShockFire'
     FireForce="ShockRifleFire"
     FireRate=0.700000
     AmmoClass=Class'tk_EHWeapons.EHShockAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-600.000000)
     ShakeOffsetTime=3.200000
     BotRefireRate=0.700000
     FlashEmitterClass=Class'tk_EHWeapons.EHShockBeamMuzFlash'
     aimerror=700.000000
}
