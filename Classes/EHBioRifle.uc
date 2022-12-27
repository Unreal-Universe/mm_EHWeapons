class EHBioRifle extends Weapon
    config(tk_EHWeaponsClient);

#EXEC OBJ LOAD FILE=InterfaceContent.utx

function DropFrom(vector StartLocation)
{
	if ( bCanThrow && (AmmoAmount(0) == 0) )
		AddAmmo(1,0);
    Super.DropFrom(StartLocation);
}

// AI Interface
function float GetAIRating()
{
	local Bot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if ( B.Enemy == None )
	{
		if ( (B.Target != None) && VSize(B.Target.Location - B.Pawn.Location) > 3500 )
			return 0.2;
		return AIRating;
	}

	// if retreating, favor this weapon
	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 1500 )
		return 0.1;
	if ( B.IsRetreating() )
		return (AIRating + 0.4);
	if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return (AIRating + 0.35);
	if ( -1 * EnemyDir.Z > EnemyDist )
		return AIRating + 0.1;
	if ( EnemyDist > 1000 )
		return 0.35;
	return AIRating;
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	if ( FRand() < 0.8 )
		return 0;
	return 1;
}

function float SuggestAttackStyle()
{
	local Bot B;
	local float EnemyDist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0.4;

	EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
	if ( EnemyDist > 1500 )
		return 1.0;
	if ( EnemyDist > 1000 )
		return 0.4;
	return -0.4;
}

function float SuggestDefenseStyle()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if ( VSize(B.Enemy.Location - Instigator.Location) < 1600 )
		return -0.6;
	return 0;
}

// End AI Interface

simulated function AnimEnd(int Channel)
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);

    if (anim == 'AltFire')
        LoopAnim('Hold', 1.0, 0.1);
    else
        Super.AnimEnd(Channel);
}

simulated function bool HasAmmo()
{
    return ( (AmmoAmount(0) >= 1) || FireMode[1].bIsFiring );
}

defaultproperties
{
     FireModeClass(0)=Class'tk_EHWeapons.EHBioFire'
     FireModeClass(1)=Class'tk_EHWeapons.EHBioChargedFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'WeaponSounds.FlakCannon.SwitchToFlakCannon'
     SelectForce="SwitchToFlakCannon"
     AIRating=0.550000
     CurrentRating=0.550000
     Description="The Enhanced GES BioRifle continues to be one of the most controversial weapons in the Tournament. Loved by some, loathed by others, the BioRifle has long been the subject of debate over its usefulness.||Some Tournament purists argue that it is the equivalent of a cowardly minefield. Others argue that it enhances the tactical capabilities of defensive combatants.|Despite the debate, the weapon provides rapid-fire wide-area coverage in primary firing mode, and a single-fire variable payload secondary firing mode. In layman's terms, this equates to being able to pepper an area with small globs of Biosludge, or launch one large glob at the target."
     EffectOffset=(X=100.000000,Y=32.000000,Z=-20.000000)
     DisplayFOV=60.000000
     Priority=49
     HudColor=(B=255,G=0,R=0)
     SmallViewOffset=(X=19.000000,Y=9.000000,Z=-6.000000)
     CenteredOffsetY=-8.000000
     CustomCrosshair=14
     CustomCrossHairColor=(G=0,R=0)
     CustomCrossHairScale=1.333000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Triad1"
     InventoryGroup=3
     PickupClass=Class'tk_EHWeapons.EHBioRiflePickup'
     PlayerViewOffset=(X=7.000000,Y=3.000000)
     BobDamping=2.200000
     AttachmentClass=Class'tk_EHWeapons.EHBioAttachment'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=179,Y1=127,X2=241,Y2=175)
     ItemName="Enhanced Bio-Rifle"
     LightType=LT_Pulse
     LightHue=85
     LightSaturation=127
     LightBrightness=150.000000
     LightRadius=2.000000
     LightPeriod=60
     bUseDynamicLights=True
     bDynamicLight=True
     Mesh=SkeletalMesh'Weapons.BioRifle_1st'
     Skins(0)=Texture'tk_EHWeapons.EHWeaponSkinsB.BioRifleTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
