class EHShieldAltFire extends tK_WeaponFire;

var EHShieldEffect EHShieldEffect;
var() float AmmoRegenTime;
var() float ChargeupTime;
var	  float RampTime;
var Sound ChargingSound;                // charging sound
var() byte	ShieldSoundVolume;

simulated function DestroyEffects()
{
    if ( Weapon.Role == ROLE_Authority )
    {
        if ( EHShieldEffect != None )
            EHShieldEffect.Destroy();
    }
    Super.DestroyEffects();
}

function DoFireEffect()
{
    local EHShieldAttachment Attachment;

    Attachment = EHShieldAttachment(Weapon.ThirdPersonActor);
    Instigator.AmbientSound = ChargingSound;
    Instigator.SoundVolume = ShieldSoundVolume;

    if( Attachment != none && Attachment.EHShieldEffect3rd != none )
        Attachment.EHShieldEffect3rd.bHidden = false;

    SetTimer(AmmoRegenTime, true);
}

function PlayFiring()
{
    ClientPlayForceFeedback("ShieldNoise");  // jdf
    SetTimer(AmmoRegenTime, true);
    Weapon.LoopAnim('Shield');
}

function StopFiring()
{
    local EHShieldAttachment Attachment;

    Attachment = EHShieldAttachment(Weapon.ThirdPersonActor);
	Instigator.AmbientSound = None;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;

    if( Attachment != none && Attachment.EHShieldEffect3rd != none )
    {
        Attachment.EHShieldEffect3rd.bHidden = true;
        StopForceFeedback( "ShieldNoise" );  // jdf
    }

    SetTimer(AmmoRegenTime, true);
}

function TakeHit(int Drain)
{
    if (EHShieldEffect != None)
    {
        EHShieldEffect.Flash(Drain);
    }

    SetBrightness(true);
}

function StartBerserk()
{
}

function StopBerserk()
{
}

function StartSuperBerserk()
{
}

function SetBrightness(bool bHit)
{
    local EHShieldAttachment Attachment;
 	local float Brightness;

	Brightness = Weapon.AmmoAmount(1);
	if ( RampTime < ChargeUpTime )
		Brightness *= RampTime/ChargeUpTime;
    if (EHShieldEffect != None)
        EHShieldEffect.SetBrightness(Brightness);

    Attachment = EHShieldAttachment(Weapon.ThirdPersonActor);
    if( Attachment != None )
        Attachment.SetBrightness(Brightness, bHit);
}

function DrawMuzzleFlash(Canvas Canvas)
{
    Super.DrawMuzzleFlash(Canvas);

    if (EHShieldEffect == None)
        EHShieldEffect = Weapon.Spawn(class'EHShieldEffect', instigator);

    if ( bIsFiring && Weapon.AmmoAmount(1) > 0 )
    {
        EHShieldEffect.SetLocation( Weapon.GetEffectStart() );
        EHShieldEffect.SetRotation( Instigator.GetViewRotation() );
        Canvas.DrawActor( EHShieldEffect, false, false, Weapon.DisplayFOV );
    }
}

function Timer()
{
    if (!bIsFiring)
    {
		RampTime = 0;
        if ( !Weapon.AmmoMaxed(1) )
            Weapon.AddAmmo(1,1);
        else
            SetTimer(0, false);
    }
    else
    {
        if ( !Weapon.ConsumeAmmo(1,1) )
        {
            if (Weapon.ClientState == WS_ReadyToFire)
                Weapon.PlayIdle();
            StopFiring();
        }
        else
			RampTime += AmmoRegenTime;
    }

	SetBrightness(false);
}

defaultproperties
{
     AmmoRegenTime=0.200000
     ChargeupTime=3.000000
     ChargingSound=Sound'GeneralAmbience.electricalfx12'
     ShieldSoundVolume=220
     bPawnRapidFireAnim=True
     bWaitForRelease=True
     FireAnim=
     FireLoopAnim=
     FireEndAnim="Idle"
     FireSound=SoundGroup'WeaponSounds.Translocator.TranslocatorModuleRegeneration'
     FireForce="TranslocatorModuleRegeneration"
     FireRate=1.000000
     AmmoClass=Class'mm_EHWeapons.EHShieldAmmo'
     AmmoPerFire=15
     BotRefireRate=1.000000
}
