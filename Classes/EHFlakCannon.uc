class EHFlakCannon extends tK_Weapon
    config(TKWeaponsClient);

#EXEC OBJ LOAD FILE=InterfaceContent.utx

// AI Interface
function float GetAIRating()
{
	local Bot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if ( (B.Target != None) && (Pawn(B.Target) == None) && (VSize(B.Target.Location - Instigator.Location) < 1250) )
		return 0.9;

	if ( B.Enemy == None )
	{
		if ( (B.Target != None) && VSize(B.Target.Location - B.Pawn.Location) > 3500 )
			return 0.2;
		return AIRating;
	}

	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 750 )
	{
		if ( EnemyDist > 2000 )
		{
			if ( EnemyDist > 3500 )
				return 0.2;
			return (AIRating - 0.3);
		}
		if ( EnemyDir.Z < -0.5 * EnemyDist )
			return (AIRating - 0.3);
	}
	else if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return (AIRating + 0.35);
	else if ( EnemyDist < 400 )
		return (AIRating + 0.2);
	return FMax(AIRating + 0.2 - (EnemyDist - 400) * 0.0008, 0.2);
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	local vector EnemyDir;
	local float EnemyDist;
	local bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 750 )
	{
		if ( EnemyDir.Z < -0.5 * EnemyDist )
			return 1;
		return 0;
	}
	else if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return 0;
	else if ( (EnemyDist < 400) || (EnemyDir.Z > 30) )
		return 0;
	else if ( FRand() < 0.65 )
		return 1;
	return 0;
}

function float SuggestAttackStyle()
{
	if ( (AIController(Instigator.Controller) != None)
		&& (AIController(Instigator.Controller).Skill < 3) )
		return 0.4;
    return 0.8;
}

function float SuggestDefenseStyle()
{
    return -0.4;
}
// End AI Interface

defaultproperties
{
     FireModeClass(0)=Class'mm_EHWeapons.EHFlakFire'
     FireModeClass(1)=Class'mm_EHWeapons.EHFlakAltFire'
     SelectAnim="Pickup"
     PutDownAnim="PutDown"
     SelectSound=Sound'WeaponSounds.FlakCannon.SwitchToFlakCannon'
     SelectForce="SwitchToEHFlakCannon"
     AIRating=0.750000
     CurrentRating=0.750000
     Description="Trident Defensive Technologies Series 7 Flechette Cannon has been taken to the next step in evolution with the production of the Mk3 "
     EffectOffset=(X=200.000000,Y=32.000000,Z=-25.000000)
     DisplayFOV=60.000000
     Priority=100
     HudColor=(G=128)
     SmallViewOffset=(X=5.000000,Y=14.000000,Z=-6.000000)
     CenteredOffsetY=-4.000000
     CenteredRoll=3000
     CenteredYaw=-500
     CustomCrosshair=16
     CustomCrossHairColor=(B=0,G=128)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Triad3"
     InventoryGroup=7
     PickupClass=Class'mm_EHWeapons.EHFlakCannonPickup'
     PlayerViewOffset=(X=-7.000000,Y=8.000000)
     PlayerViewPivot=(Yaw=16884,Roll=200)
     BobDamping=1.400000
     AttachmentClass=Class'mm_EHWeapons.EHFlakAttachment'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=169,Y1=172,X2=245,Y2=208)
     ItemName="Enhanced Flak Cannon"
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=255.000000
     LightRadius=4.000000
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Weapons.Flak_1st'
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.FlakTex02'
     Skins(1)=Texture'WeaponSkins.Skins.FlakTex1'
     Skins(2)=Texture'mm_EHWeapons.EHWeaponSkinsB.FlakTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
