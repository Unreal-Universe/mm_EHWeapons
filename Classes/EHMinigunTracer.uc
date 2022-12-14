class EHMinigunTracer extends Emitter;

#exec OBJ LOAD FILE=..\Textures\AW-2004Particles.utx

simulated function SpawnParticle( int Amount )
{
	local PlayerController PC;
	local vector Dir, LineDir, LinePos, RealLocation;

	Super.SpawnParticle(Amount);

    if ( (Instigator == None) || Instigator.IsFirstPerson() )
		return;

	// see if local player controller near bullet, but missed
	PC = Level.GetLocalPlayerController();
	if ( (PC != None) && (PC.Pawn != None) )
	{
		Dir.X = Emitters[0].StartVelocityRange.X.Min;
		Dir.Y = Emitters[0].StartVelocityRange.Y.Min;
		Dir.Z = Emitters[0].StartVelocityRange.Z.Min;
		Dir = Normal(Dir);
		LinePos = (Location + (Dir dot (PC.Pawn.Location - Location)) * Dir);
		LineDir = PC.Pawn.Location - LinePos;
		if ( VSize(LineDir) < 150 )
		{
			RealLocation = Location;
			SetLocation(LinePos);
			if ( FRand() < 0.5 )
				PlaySound(sound'Impact3Snd',,,,80);
			else
				PlaySound(sound'Impact7Snd',,,,80);
			SetLocation(RealLocation);
		}
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseDirectionAs=PTDU_Right
         RespawnDeadParticles=False
         UseSizeScale=True
         UseAbsoluteTimeForSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.200000)
         ColorScale(0)=(Color=(B=100,G=100,R=255))
         ColorScale(1)=(RelativeTime=0.030000,Color=(B=150,G=255,R=255))
         MaxParticles=100
         SizeScale(1)=(RelativeTime=0.030000,RelativeSize=1.300000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=20.000000,Max=20.000000))
         ScaleSizeByVelocityMultiplier=(X=0.002000)
         Texture=Texture'EHWeaponSkinsB.EHMinigunTracerShot'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=10000.000000,Max=10000.000000))
     End Object
     Emitters(0)=SpriteEmitter'EHWeaponsE.EHMinigunTracer.SpriteEmitter13'

     bNoDelete=False
     bHardAttach=True
}
