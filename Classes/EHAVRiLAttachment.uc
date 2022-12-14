class EHAVRiLAttachment extends xWeaponAttachment;

#EXEC OBJ LOAD FILE=EHWeaponSkinsB.utx

defaultproperties
{
     bHeavy=True
     CullDistance=5000.000000
     bUseDynamicLights=True
     Mesh=SkeletalMesh'ONSWeapons-A.AVRiL_3rd'
     RelativeLocation=(X=35.000000,Y=15.000000)
     DrawScale=0.280000
     Skins(0)=Texture'EHWeaponSkinsB.EHAVRiLtex'
     Skins(1)=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX'
     Skins(2)=Texture'EHWeaponSkinsB.EHAVRiLtex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     bUseLightingFromBase=False
}
