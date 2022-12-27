class EHNewIonEffect extends Emitter;

#exec OBJ LOAD FILE="..\Sounds\GeneralAmbience.uax"

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'tk_EHWeapons.Simple.ParticleSphere3'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=2.000000
         MaxParticles=1
         StartLocationRange=(Z=(Min=-50.000000,Max=-50.000000))
         SizeScale(0)=(RelativeSize=0.010000)
         SizeScale(1)=(RelativeTime=1.500000,RelativeSize=50.009998)
         StartSizeRange=(Z=(Min=0.800000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(0)=MeshEmitter'tk_EHWeapons.EHNewIonEffect.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=128,G=128,R=128,A=128))
         Opacity=0.500000
         StartLocationRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         StartSpinRange=(X=(Min=0.231000,Max=0.853000))
         StartSizeRange=(X=(Min=350.000000,Max=350.000000))
         Sounds(0)=(Sound=Sound'ONSVehicleSounds-S.Explosions.Explosion03',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         Sounds(1)=(Sound=Sound'ONSVehicleSounds-S.Explosions.Explosion06',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         Sounds(2)=(Sound=Sound'ONSVehicleSounds-S.Explosions.Explosion08',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         SpawningSound=PTSC_LinearGlobal
         SpawningSoundProbability=(Min=0.300000,Max=0.300000)
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSstructureTextures.CoreBreachGroup.exp7_framesBLUE'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tk_EHWeapons.EHNewIonEffect.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.PlasmaSphere'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.800000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.500000,RelativeSize=50.000000)
         StartSizeRange=(Z=(Min=0.800000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(2)=MeshEmitter'tk_EHWeapons.EHNewIonEffect.MeshEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'tk_EHWeapons.Complex.IonSphere'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=1.800000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=14.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.010000)
         StartSizeRange=(Z=(Min=0.800000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(3)=MeshEmitter'tk_EHWeapons.EHNewIonEffect.MeshEmitter2'

     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'tk_EHWeapons.Complex.ExplosionRing'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=2.000000
         MaxParticles=1
         StartLocationRange=(Z=(Min=-50.000000,Max=-50.000000))
         SizeScale(0)=(RelativeSize=8.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.010000)
         StartSizeRange=(Z=(Min=0.800000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(4)=MeshEmitter'tk_EHWeapons.EHNewIonEffect.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=128,G=128,R=128,A=128))
         Opacity=0.500000
         FadeOutStartTime=0.800000
         FadeInEndTime=0.200000
         StartLocationRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         StartSpinRange=(X=(Min=0.231000,Max=0.853000))
         StartSizeRange=(X=(Max=150.000000))
         Sounds(0)=(Sound=Sound'GeneralAmbience.electricalfx6',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         Sounds(1)=(Sound=Sound'GeneralAmbience.electricalfx5',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         Sounds(2)=(Sound=Sound'GeneralAmbience.electricalfx20',Radius=(Min=1024.000000,Max=1024.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.500000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
         SpawningSound=PTSC_LinearGlobal
         SpawningSoundProbability=(Min=0.300000,Max=0.300000)
         InitialParticlesPerSecond=40.000000
         Texture=Texture'AW-2004Particles.Energy.ElecPanels'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.800000,Max=1.800000)
     End Object
     Emitters(5)=SpriteEmitter'tk_EHWeapons.EHNewIonEffect.SpriteEmitter10'

     AutoDestroy=True
     LightType=LT_Steady
     LightHue=155
     LightSaturation=85
     LightBrightness=150.000000
     LightRadius=100.000000
     bNoDelete=False
     bDynamicLight=True
}
