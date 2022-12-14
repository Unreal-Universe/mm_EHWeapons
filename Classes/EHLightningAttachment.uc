class EHLightningAttachment extends xWeaponAttachment;

var() EHLightningCharge3rd charge;

simulated function Destroyed()
{
    if (charge != None)
        charge.Destroy();

    Super.Destroyed();
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer )
    {
        if (charge == None)
        {
            charge = Spawn(class'EHLightningCharge3rd');
            AttachToBone(charge, 'tip');
        }
        WeaponLight();
    }

    Super.ThirdPersonEffects();
}

defaultproperties
{
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=165
     LightSaturation=170
     LightBrightness=255.000000
     LightRadius=5.000000
     LightPeriod=3
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Weapons.Sniper_3rd'
     Skins(0)=Texture'EHWeaponSkinsB.LightningRifleTex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
