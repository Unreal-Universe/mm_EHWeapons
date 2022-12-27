class EHAVRiLAttachment extends xWeaponAttachment;

#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="tk_EHWeapons"

defaultproperties
{
     bHeavy=True
     CullDistance=5000.000000
     bUseDynamicLights=True
     Mesh=SkeletalMesh'ONSWeapons-A.AVRiL_3rd'
     RelativeLocation=(X=35.000000,Y=15.000000)
     DrawScale=0.280000
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     Skins(1)=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX'
     Skins(2)=Texture'tk_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     bUseLightingFromBase=False
}
