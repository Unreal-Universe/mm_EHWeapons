class NewEHExplosionA extends Emitter;

#exec OBJ LOAD FILE="..\Textures\VMParticleTextures.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-800.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=4.500000
         MaxParticles=4
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=3.500000,Max=7.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=2.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=200.000000,Max=1800.000000))
     End Object
     Emitters(0)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.600000
         MaxParticles=40
         DetailMode=DM_High
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=3.000000,Max=6.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=2.000000,Max=1.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         FadeOutStartTime=2.500000
         MaxParticles=4
         DetailMode=DM_High
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=3.500000,Max=7.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'mm_EHWeapons.EHWeaponSkinsB.EHfire3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=100.000000,Max=1600.000000))
     End Object
     Emitters(2)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=15.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         Opacity=0.800000
         FadeOutStartTime=2.000000
         FadeInEndTime=0.100000
         MaxParticles=18
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-28.000000,Max=28.000000))
         AlphaRef=8
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Max=3.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=10.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(3)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=15.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         Opacity=0.800000
         FadeOutStartTime=2.000000
         FadeInEndTime=0.100000
         MaxParticles=18
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-32.000000,Max=128.000000))
         AlphaRef=8
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Max=3.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=130.000000,Max=420.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(4)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationRange=(X=(Min=-64.000000,Max=64.000000),Y=(Min=-64.000000,Max=64.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=55.000000,Max=120.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Fire.GrenadeTest'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.550000,Max=1.800000)
     End Object
     Emitters(5)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter265
         UseDirectionAs=PTDU_Right
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=179,G=236,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=20,G=97,R=167))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=2.000000,Max=6.000000))
         ScaleSizeByVelocityMultiplier=(X=0.006000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.750000,Max=1.250000)
         StartVelocityRange=(X=(Min=400.000000,Max=1400.000000),Y=(Min=-1200.000000,Max=1200.000000),Z=(Min=-1200.000000,Max=1200.000000))
     End Object
     Emitters(6)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter265'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.600000
         MaxParticles=6
         StartLocationRange=(X=(Min=-64.000000,Max=64.000000),Y=(Min=-64.000000,Max=64.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=55.000000,Max=120.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'VMParticleTextures.VehicleExplosions.VMExp2_framesANIM'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.550000,Max=1.800000)
     End Object
     Emitters(7)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter266
         UseDirectionAs=PTDU_Right
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=179,G=236,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=20,G=97,R=167))
         Opacity=0.600000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=1.000000,Max=2.000000))
         ScaleSizeByVelocityMultiplier=(X=0.006000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=0.750000,Max=1.250000)
         StartVelocityRange=(X=(Min=40.000000,Max=140.000000),Y=(Min=-120.000000,Max=120.000000),Z=(Min=-120.000000,Max=120.000000))
     End Object
     Emitters(8)=SpriteEmitter'mm_EHWeapons.NewEHExplosionA.SpriteEmitter266'

     AutoDestroy=True
     bNoDelete=False
}
