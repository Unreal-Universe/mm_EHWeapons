class EHONSAutoBomberB extends EHONSAutoBomber;



simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == ROLE_Authority && Instigator != None)
		Team = Instigator.GetTeamNum();

	if (Level.NetMode != NM_DedicatedServer)
	{
	    LoopAnim('Flying');
		spawn(class'ONSAutoBomberWarpEffect',,,, Rotation + rot(0,16384,0));
		Level.GetLocalPlayerController().PlayStatusAnnouncement('Incoming_air', 0, true);
	}
}

function Timer()
{
	local Projectile MyBomb;
	local Controller C;
	local vector Newvelocity, X, Y, Z;

	GetViewAxes(X,Y,Z);

	NewVelocity = 0.5*Velocity + frand()*Y*BombOffset.Y;

	if (FRand() < 0.5)
	{
		//high skill enemies who don't have anything else to shoot at will try to shoot bomber down
		for (C = Level.ControllerList; C != None; C = C.NextController)
			if ( AIController(C) != None && C.Pawn != None && C.GetTeamNum() != Team && AIController(C).Skill >= 5.0
			     && !C.Pawn.IsFiring() && (C.Enemy == None || !C.LineOfSightTo(C.Enemy)) && C.Pawn.CanAttack(self) )
			{
				C.Focus = self;
				C.FireWeaponAt(self);
			}
	}

	if (VSize(Location - BombTargetCenter) < BombRange)
	{
		//drop a bomb
		MyBomb = spawn(BombClass,,, Location - ((CollisionHeight + BombClass.default.CollisionHeight) * vect(0,0,2)), rotator(vect(0,0,-1)));
		Velocity = Normal(Velocity) * MinSpeed;
		Acceleration = vect(0,0,-1);
		MyBomb.Velocity = NewVelocity;
	}
}

simulated function GetViewAxes( out vector xaxis, out vector yaxis, out vector zaxis )
{
        GetAxes( Rotation, xaxis, yaxis, zaxis );
}

defaultproperties
{
     sirensound=Sound'WeaponSounds.Translocator.TranslocatorReturn'
     Mesh=SkeletalMesh'EnhancedAnimB.PhantomMesh'
}
