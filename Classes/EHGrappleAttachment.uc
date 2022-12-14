class EHGrappleAttachment extends xWeaponAttachment;

var EHLinkMuzFlashBeam3rd MuzFlash;
var int Links;
var bool	bReplicateLinkColor;

enum ELinkColor
{
	LC_Green,
	LC_Red,
	LC_Blue,
	LC_Gold,
};

var ELinkColor	LinkColor;

replication
{
    reliable if ( Role == ROLE_Authority )
        Links;

    reliable if ( bReplicateLinkColor && !bNetOwner && bNetDirty && Role == ROLE_Authority )
       LinkColor;
}

/* change link color, and update all effects */
simulated function SetLinkColor( ELinkColor NewColor )
{
	if ( NewColor == LinkColor )
		return;

	if ( bReplicateLinkColor )
		NetUpdateTime = Level.TimeSeconds - 1;
	LinkColor = NewColor;
	if ( Level.NetMode != NM_DedicatedServer )
		UpdateLinkColor();
}

simulated function UpdateLinkColor()
{
	if ( Instigator != None && Instigator.Weapon != None )
		EHGrappleGun(Instigator.Weapon).UpdateLinkColor( LinkColor );

	if ( MuzFlash != None )
	{
		switch ( LinkColor )
		{
			case LC_Gold	: MuzFlash.Skins[0] = None;	break;
			case LC_Green	:
			default			: MuzFlash.Skins[0] = none;	break;
		}
	}
}

simulated function Destroyed()
{
    if ( MuzFlash != None )
        MuzFlash.Destroy();

    super.Destroyed();
}

simulated event ThirdPersonEffects()
{
    local Rotator R;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
        if (FiringMode == 0)
        {
            if (MuzFlash == None)
            {
                MuzFlash = Spawn(none);
                //AttachToBone(MuzFlash, 'tip');
				UpdateLinkColor();
            }
            if (MuzFlash != None)
            {
                MuzFlash.mSizeRange[0] = MuzFlash.default.mSizeRange[0] * (class'EHGrappleFire'.default.LinkScale[Min(Links,5)]+1); // (1.0 + 0.3*float(Links));
                MuzFlash.mSizeRange[1] = MuzFlash.mSizeRange[0];

				if ( Links > 0 )
					SetLinkColor( LC_Gold );
				else
					SetLinkColor( LC_Green );

                MuzFlash.Trigger(self, None);
                R.Roll = Rand(65536);
                SetBoneRotation('Bone_Flash', R, 0, 1.0);
            }
        }
    }

    super.ThirdPersonEffects();
}

defaultproperties
{
     bRapidFire=True
     bAltRapidFire=True
     bMatchWeapons=True
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Weapons.TransLauncher_3rd'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
