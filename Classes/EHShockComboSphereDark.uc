class EHShockComboSphereDark extends MeshEffect;

#exec OBJ LOAD FILE=XEffectMat.utx
#exec OBJ LOAD File=WarEffectsTextures.utx

event PostBeginPlay()
{
    Super.PostBeginPlay();
    SetRotation(RotRand());
}

defaultproperties
{
     FadeInterp=(InTime=0.150000,OutTime=0.750000)
     ScaleInterp=(Start=0.100000,Mid=1.200000,InTime=0.300000,OutTime=0.300000,InStyle=IS_InvExp,OutStyle=IS_InvExp)
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'Editor.TexPropSphere'
     Skins(0)=Shader'mm_EHWeapons.EHWeaponSkinsB.DarkShader'
     bUnlit=True
}
