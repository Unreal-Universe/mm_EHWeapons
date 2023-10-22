class EHAVRiL extends tK_Weapon
	config(TKWeaponsClient);

#exec OBJ LOAD FILE="Resources\tk_EHWeapons_rc.u" PACKAGE="mm_EHWeapons"
#exec OBJ LOAD FILE="..\Textures\VMWeaponsTX"

var Material BaseMaterial;
var Material ReticleOFFMaterial;
var Material ReticleONMaterial;
var bool bLockedOn;
var tk_Monster HomingTarget;
var float LockCheckFreq, LockCheckTime;
var float MaxLockRange, LockAim;
var Color CrosshairColor;
var float CrosshairX, CrosshairY;
var Texture CrosshairTexture;

replication
{
	reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
		bLockedOn, HomingTarget;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Skins[0] = ReticleOFFMaterial;
	Skins[1] = BaseMaterial;
}

simulated function OutOfAmmo()
{
}

simulated function ActivateReticle(bool bActivate)
{
    if(bActivate)
        Skins[0] = ReticleONMaterial;
    else
        Skins[0] = ReticleOFFMaterial;
}

simulated function WeaponTick(float deltaTime)
{
	local vector StartTrace;
	local rotator Aim;
	local float BestAim, BestDist;
	local bool bLastLockedOn;
	local Monster LastHomingTarget;

	if (Role < ROLE_Authority)
	{
		ActivateReticle(bLockedOn);
		return;
	}

	if (Instigator == None || Instigator.Controller == None)
	{
		bLockedOn = false;
		ActivateReticle(false);
		return;
	}

	if (Level.TimeSeconds < LockCheckTime)
		return;

	LockCheckTime = Level.TimeSeconds + LockCheckFreq;

	bLastLockedOn = bLockedOn;
	LastHomingTarget = HomingTarget;
	if (AIController(Instigator.Controller) != None)
	{
		if (CanLockOnTo(AIController(Instigator.Controller).Focus))
		{
			HomingTarget = tk_Monster(AIController(Instigator.Controller).Focus);
			bLockedOn = true;
		}
		else
			bLockedOn = false;
	}
	else if ( HomingTarget == None || Normal(HomingTarget.Location - Instigator.Location) Dot vector(Instigator.Controller.Rotation) < LockAim
		  || VSize(HomingTarget.Location - Instigator.Location) > MaxLockRange
		  || !FastTrace(HomingTarget.Location, Instigator.Location + Instigator.EyeHeight * vect(0,0,1)) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		Aim = Instigator.GetViewRotation();
		BestAim = LockAim;
		HomingTarget = tk_Monster(Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Aim), StartTrace, MaxLockRange));
		bLockedOn = CanLockOnTo(HomingTarget);
	}

	ActivateReticle(bLockedOn);
	if (!bLastLockedOn && bLockedOn)
		if ( PlayerController(Instigator.Controller) != None )
			PlayerController(Instigator.Controller).ClientPlaySound(Sound'WeaponSounds.LockOn');
}

function bool CanLockOnTo(Actor Other)
{
	// if ((tk_Monster(Other) != None) && (FriendlyMonsterController(tk_Monster(Other).Controller) == None))
	if ((tk_Monster(Other) != None))
		return true;

	return false;
}

function LoseLock()
{
	bLockedOn = false;
}

simulated function Destroyed()
{
	LoseLock();
	super.Destroyed();
}

simulated function DetachFromPawn(Pawn P)
{
	LoseLock();
	Super.DetachFromPawn(P);
}

simulated event RenderOverlays(Canvas Canvas)
{
	if (!FireMode[1].bIsFiring || EHAVRiLAltFire(FireMode[1]) == None)
	{
		if (bLockedOn)
		{
			Canvas.DrawColor = CrosshairColor;
			Canvas.DrawColor.A = 255;
			Canvas.Style = ERenderStyle.STY_Alpha;
			Canvas.SetPos(Canvas.SizeX*0.5-CrosshairX, Canvas.SizeY*0.5-CrosshairY);
			Canvas.DrawTile(CrosshairTexture, CrosshairX*2.0, CrosshairY*2.0, 0.0, 0.0, CrosshairTexture.USize, CrosshairTexture.VSize);
		}

		Super.RenderOverlays(Canvas);
	}
}

// AI Interface
function float SuggestAttackStyle()
{
    return -0.4;
}

function float SuggestDefenseStyle()
{
    return 0.5;
}

function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float ZDiff, dist, Result;

	B = Bot(Instigator.Controller);
	if ( (B.Target != None) && B.Target.IsA('ONSMortarCamera') )
		return 2;

	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	if (Vehicle(B.Enemy) == None)
		return 0;

	result = AIRating;
	ZDiff = Instigator.Location.Z - B.Enemy.Location.Z;
	if ( ZDiff < -200 )
		result += 0.1;
	dist = VSize(B.Enemy.Location - Instigator.Location);
	if ( dist > 2000 )
		return ( FMin(2.0,result + (dist - 2000) * 0.0002) );

	return result;
}

function bool RecommendRangedAttack()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return true;

	return ( VSize(B.Enemy.Location - Instigator.Location) > 2000 * (1 + FRand()) );
}
// end AI Interface

defaultproperties
{
     BaseMaterial=Texture'mm_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     ReticleOFFMaterial=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX'
     ReticleONMaterial=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEXRed'
     LockCheckFreq=0.200000
     MaxLockRange=15000.000000
     LockAim=0.996000
     CrossHairColor=(G=255,A=255)
     CrosshairX=32.000000
     CrosshairY=32.000000
     CrosshairTexture=Texture'ONSInterface-TX.avrilRETICLE'
     FireModeClass(0)=Class'mm_EHWeapons.EHAVRiLFire'
     FireModeClass(1)=Class'mm_EHWeapons.EHAVRiLAltFire'
     PutDownAnim="PutDown"
     SelectAnimRate=2.000000
     PutDownAnimRate=1.750000
     BringUpTime=0.450000
     SelectSound=Sound'WeaponSounds.FlakCannon.SwitchToFlakCannon'
     SelectForce="SwitchToFlakCannon"
     AIRating=0.550000
     CurrentRating=0.550000
     Description="The Enhanced AVRiL, or Enhanced Anti-Vehicle Rocket Launcher, shoots homing missiles that pack quite a punch."
     EffectOffset=(X=100.000000,Y=32.000000,Z=-20.000000)
     DisplayFOV=45.000000
     Priority=80
     HudColor=(B=255,G=0,R=0)
     SmallViewOffset=(X=116.000000,Y=43.500000,Z=-40.500000)
     CenteredRoll=5500
     CustomCrosshair=6
     CustomCrossHairColor=(B=0,R=0)
     CustomCrossHairTextureName="ONSInterface-TX.avrilRETICLEtrack"
     MinReloadPct=0.000000
     InventoryGroup=8
     GroupOffset=1
     PickupClass=Class'mm_EHWeapons.EHAVRiLPickup'
     PlayerViewOffset=(X=100.000000,Y=35.500000,Z=-32.500000)
     BobDamping=2.200000
     AttachmentClass=Class'mm_EHWeapons.EHAVRiLAttachment'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=429,Y1=212,X2=508,Y2=251)
     ItemName="Enhanced AVRiL"
     bUseDynamicLights=True
     Mesh=SkeletalMesh'ONSWeapons-A.AVRiL_1st'
     Skins(0)=Shader'VMWeaponsTX.PlayerWeaponsGroup.AVRiLreticleTEX'
     Skins(1)=Texture'mm_EHWeapons.EHWeaponSkinsB.EHAVRiLtex'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
