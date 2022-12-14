class EHShockComboVortex extends MeshEffect;

#exec OBJ LOAD FILE=XEffectMat.utx

var() Rotator InitialRot;

event PostBeginPlay()
{
    Super.PostBeginPlay();
    SetRotation(InitialRot);
}

defaultproperties
{
     InitialRot=(Roll=16384)
     FadeInterp=(OutTime=0.900000)
     ScaleInterp=(Start=0.400000,Mid=1.600000,End=0.200000,InTime=0.400000,OutTime=0.400000,InStyle=IS_InvExp,OutStyle=IS_InvExp)
     LightType=LT_Steady
     LightHue=155
     LightSaturation=85
     LightBrightness=150.000000
     LightRadius=30.000000
     DrawType=DT_Mesh
     bDynamicLight=True
     Mesh=VertMesh'XEffects.ShockVortexMesh'
     Skins(0)=FinalBlend'AW-2k4XP.Weapons.ShockShieldFinal'
     bUnlit=True
     bAlwaysFaceCamera=True
}
