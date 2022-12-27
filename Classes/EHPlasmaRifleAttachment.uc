class EHPlasmaRifleAttachment extends xWeaponAttachment;

var class<xEmitter>     MuzFlashClass;
var xEmitter            MuzFlash;

simulated function Destroyed()
{
    if (MuzFlash != None)
        MuzFlash.Destroy();

    Super.Destroyed();
}

simulated event ThirdPersonEffects()
{
    local rotator r;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
		if ( FiringMode == 0 )
			WeaponLight();
        else
        {
            if (MuzFlash == None)
            {
                MuzFlash = Spawn(MuzFlashClass);
                AttachToBone(MuzFlash, 'tip');
            }
            if (MuzFlash != None)
            {
                MuzFlash.mStartParticles++;
                r.Roll = Rand(65536);
                SetBoneRotation('Bone_Flash', r, 0, 1.f);
            }
        }
    }

    Super.ThirdPersonEffects();
}

defaultproperties
{
     MuzFlashClass=Class'tk_EHWeapons.PlasmaMuzFlash3rd'
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=200
     LightSaturation=70
     LightBrightness=255.000000
     LightRadius=4.000000
     LightPeriod=3
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Weapons.LinkGun_3rd'
     RelativeLocation=(X=6.000000,Y=-5.000000)
     RelativeRotation=(Pitch=1024)
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.LinkTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
