class EHRIIGroundExplosion extends Emitter;

function PostBeginPlay()
{
	local PlayerController PC;

	PC = Level.GetLocalPlayerController();
	if ( PC == None )
	{
		Destroy();
		return;
	}
	if ( Level.bDropDetail || (Level.DetailMode == DM_Low) || (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 8000) )
	{
		Emitters[0].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=40.000000)
         ColorScale(1)=(RelativeTime=0.185714,Color=(B=56,G=56,R=56,A=255))
         ColorScale(2)=(RelativeTime=0.639286,Color=(B=77,G=77,R=77,A=255))
         ColorScale(3)=(RelativeTime=0.875000,Color=(B=53,G=53,R=53,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(6)=(RelativeTime=1.000000)
         FadeOutStartTime=1.000000
         FadeInEndTime=0.200000
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=190.000000,Max=200.000000))
         SphereRadiusRange=(Min=1800.000000,Max=1800.000000)
         StartSpinRange=(X=(Min=0.200000,Max=0.200000))
         StartSizeRange=(X=(Max=660.000000),Y=(Max=660.000000),Z=(Max=660.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         InitialDelayRange=(Max=0.064000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=300.000000,Max=500.000000))
     End Object
     Emitters(0)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=125,G=125,R=125,A=125))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.480000
         FadeOutStartTime=1.513600
         FadeInEndTime=0.200000
         MaxParticles=6
         StartLocationRange=(Z=(Min=200.500000,Max=200.500000))
         StartSpinRange=(X=(Min=0.020000,Max=0.020000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.500000)
         SizeScale(2)=(RelativeTime=2.250000,RelativeSize=2.800000)
         SizeScale(3)=(RelativeTime=3.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=840.000000,Max=860.000000),Y=(Min=840.000000,Max=860.000000),Z=(Min=0.000000,Max=860.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.700000,Max=4.700000)
     End Object
     Emitters(1)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationRange=(Z=(Min=200.000000,Max=220.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=0.200000,Max=0.200000))
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=3.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=840.000000,Max=860.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=3.500000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=120.000000,Max=140.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(2)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter55'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=125,G=125,R=125,A=125))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=125,G=125,R=125,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=1.686190
         FadeInEndTime=0.200000
         DetailMode=DM_High
         StartLocationOffset=(Z=220.000000)
         StartLocationRange=(X=(Min=-1800.000000,Max=1800.000000),Y=(Min=-1800.000000,Max=1800.000000),Z=(Min=190.000000,Max=200.000000))
         SphereRadiusRange=(Min=1180.000000,Max=1180.000000)
         StartSpinRange=(X=(Min=0.020000,Max=0.020000))
         SizeScale(1)=(RelativeTime=2.070000,RelativeSize=2.650000)
         SizeScale(2)=(RelativeTime=3.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=840.000000,Max=860.000000),Y=(Min=840.000000,Max=860.000000),Z=(Min=840.000000,Max=860.000000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.600000,Max=3.900000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=400.000000,Max=600.000000))
     End Object
     Emitters(3)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter5'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'ArboreaLanscape.Cliffs.littlerock01'
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-3800.000000)
         DampingFactorRange=(X=(Min=0.458000,Max=0.580000),Y=(Min=0.458000,Max=0.580000),Z=(Min=0.458000,Max=0.580000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.670000
         MaxParticles=120
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-1400.000000,Max=2400.000000),Y=(Min=-1400.000000,Max=2400.000000),Z=(Min=1400.000000,Max=2400.000000))
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.024000,Max=0.087000),Y=(Min=0.024000,Max=0.087000),Z=(Min=0.024000,Max=0.087000))
         InitialParticlesPerSecond=300.000000
         StartVelocityRange=(X=(Min=-1600.000000,Max=1600.000000),Y=(Min=-1600.000000,Max=1600.000000),Z=(Min=1030.000000,Max=2900.000000))
     End Object
     Emitters(4)=MeshEmitter'mm_EHWeapons.EHRIIGroundExplosion.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.700000
         FadeOutStartTime=1.119000
         FadeInEndTime=0.200000
         MaxParticles=6
         StartLocationRange=(Z=(Min=200.500000,Max=200.500000))
         StartSpinRange=(X=(Min=0.020000,Max=0.020000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=2.250000,RelativeSize=2.500000)
         SizeScale(3)=(RelativeTime=5.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=840.000000,Max=860.000000),Y=(Min=840.000000,Max=860.000000),Z=(Min=840.000000,Max=860.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=6.500000,Max=6.500000)
     End Object
     Emitters(5)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=164))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=170))
         FadeOutStartTime=5.740000
         FadeInEndTime=1.080000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationRange=(Z=(Min=200.000000,Max=210.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=0.070000,Max=0.070000))
         StartSpinRange=(X=(Min=0.020000,Max=0.020000))
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.340000,RelativeSize=2.520000)
         SizeScale(3)=(RelativeTime=3.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=640.000000,Max=660.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=10.600000,Max=10.600000)
         InitialDelayRange=(Min=0.059000,Max=0.059000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=500.000000,Max=800.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(6)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter77
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=1.000000)
         ColorScale(0)=(Color=(B=155,G=155,R=155,A=155))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=155,R=155,A=155))
         Opacity=0.500000
         FadeOutStartTime=7.119000
         FadeInEndTime=4.200000
         MaxParticles=60
         StartLocationRange=(X=(Min=-280.000000,Max=280.000000),Y=(Min=-280.000000,Max=280.000000),Z=(Min=2.000000,Max=1800.000000))
         SpinsPerSecondRange=(X=(Min=0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=0.020000,Max=0.020000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=1.300000)
         SizeScale(2)=(RelativeTime=2.250000,RelativeSize=1.500000)
         SizeScale(3)=(RelativeTime=5.000000,RelativeSize=1.800000)
         StartSizeRange=(X=(Min=320.000000,Max=380.000000),Y=(Min=320.000000,Max=380.000000),Z=(Min=320.000000,Max=380.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=10.500000,Max=10.500000)
     End Object
     Emitters(7)=SpriteEmitter'mm_EHWeapons.EHRIIGroundExplosion.SpriteEmitter77'

     AutoDestroy=True
     bNoDelete=False
}
