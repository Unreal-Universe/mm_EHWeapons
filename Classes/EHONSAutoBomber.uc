class EHONSAutoBomber extends ONSAutoBomber;

var() Vector BombOffset;
var() sound sirensound;

struct BomberGroup
{
var bool ShotDown;
var bool bExisted;
};

var array<EHONSAutoBomber> Bombers;
var Array<BomberGroup> ShotBomber;
var class<EHONSAutoBomber> BomberClass;
var() array<vector> BombersOffsets;
var() int bomberwingsize;

simulated function Tick(float deltaTime)
{
	PlaySound(sirensound, SLOT_Misc, 255.0,, 9000.0);

}

simulated function GetViewAxes( out vector xaxis, out vector yaxis, out vector zaxis )
{
        GetAxes( Rotation, xaxis, yaxis, zaxis );
}

Function PostBeginPlay()
{
	local BomberGroup ShotBombers;
	local int i;

Super.PostBeginPlay();

	for(i = 0; i < bomberwingsize; i ++)
	{
		ShotBombers.ShotDown = false;
		ShotBombers.bExisted = false;
		ShotBomber[i] = ShotBombers;
	}

}

function Bomb(vector Target)
{
	BombTargetCenter = Target;
	SetRotation(rotator(Target - Location));
	Velocity = vector(Rotation) * ((VSize(Location - BombTargetCenter) - BombRange) / 100000 * Speed + MinSpeed);
	SetTimer(0.33, true);
}

function Timer()
{
	local vector NewVelocity, x, y, z;
	local int i;
	local array<vector> BomberStarts;
	local array<vector> BombTargetCenters;
	local BomberGroup ShotBombers;
	local Projectile MyBomb;
	local Controller C;

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


	GetViewAxes(X,Y,Z);

	for(i = 0; i < bomberwingsize; i ++)
	{
	BomberStarts[i] = Location + Y*BombersOffsets[i].Y + X* BombersOffsets[i].x + Z * BombersOffsets[i].Z;
	BombTargetCenters[i] = BombTargetCenter + Y* BombersOffsets[i].Y + Z * BombersOffsets[i].Z;

		if(Bombers[i] != None)
		{
		ShotBombers.ShotDown = Bombers[i].bShotDown;
		ShotBombers.bExisted = true;
		ShotBomber[i] = ShotBombers;
		}

		if(Bombers[i] == None && ShotBomber[i].ShotDown == false && ShotBomber[i].bExisted == False)
		{
		Bombers[i] = spawn(BomberClass, Instigator,, BomberStarts[i], Rotation);

			if (Bombers[i] != None)
			{
			Bombers[i].Bomb(BombTargetCenters[i]);
			}
		}

	}
}

defaultproperties
{
     BombOffset=(Y=500.000000)
     BomberClass=Class'EHWeaponsE.EHONSAutoBomberB'
     BombersOffsets(0)=(X=5000.000000)
     BombersOffsets(1)=(X=1000.000000,Y=-1500.000000)
     BombersOffsets(2)=(X=1000.000000,Y=1500.000000)
     BombersOffsets(3)=(X=200.000000,Y=-3000.000000)
     BombersOffsets(4)=(X=200.000000,Y=3000.000000)
     bomberwingsize=5
     BombRange=8000.000000
     BombClass=Class'EHWeaponsE.EHONSAutoBomberBomb'
     Mesh=SkeletalMesh'EnhancedAnimB.B2Bomber'
}
