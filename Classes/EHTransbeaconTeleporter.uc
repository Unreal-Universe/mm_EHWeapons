class EHTransbeaconTeleporter extends Keypoint;

var() name JumpSpotTag;
var JumpSpot myJumpSpot;

function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( JumpSpotTag != '' )
		ForEach AllActors(class'JumpSpot',myJumpSpot,JumpSpotTag)
			break;
}

event Touch(Actor Other)
{
	if ( (EHTransBeacon(Other) == None) || (myJumpSpot == None) )
		return;

	Other.SetLocation(myJumpSpot.Location);
	if ( EHTransBeacon(Other).Trail != None )
	    EHTransBeacon(Other).Trail.mRegen = false;
}

defaultproperties
{
     CollisionRadius=30.000000
     CollisionHeight=30.000000
     bCollideActors=True
}
