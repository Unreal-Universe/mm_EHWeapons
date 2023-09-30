class MutEHWeaponsE extends Mutator
    config(EHWeaponsMut);

var bool bAllowTranslocator;
var bool bAllowPlayerLights;

var bool CompatMode;	// Turning this on disables weapon replacement.

var config bool bAllowOverride;  //I like the weapons, But I dont want the pickup ovveride.

replication
{
	reliable if (Role < ROLE_Authority)
		SetClientStuff;
}

//====================================================================
// GetInventoryClassOverride
// override weapon classes for LMS and Mutant
//====================================================================

function string GetInventoryClassOverride(string InventoryClassName) {
         if(bAllowOverride) 
         {
	if (CompatMode)
       		return Super.GetInventoryClassOverride(InventoryClassName);

		if (InventoryClassName ~= "XWeapons.Shieldgun")
        		return "mm_EHWeapons.EHShieldgun";
       	if (InventoryClassName ~= "XWeapons.AssaultRifle")
        		return "mm_EHWeapons.EHAssaultRifle";
        if (InventoryClassName ~= "XWeapons.Translauncher")
        		return "mm_EHWeapons.EHTranslauncher";
       	return Super.GetInventoryClassOverride(InventoryClassName);
       	}
}
//===================================================================

function ModifyPlayer(Pawn Other)
{
	local xPawn P;
     if(bAllowOverride) {
	P = xPawn(Other);

	Other.GiveWeapon("mm_EHWeapons.EHGrappleGun");
    if (P != None)
    Other.GiveWeapon("mm_EHWeapons.EHPlasmaRifle");
    }





	if ( NextMutator != None )
		NextMutator.ModifyPlayer(Other);




	if (P != None)
	{
		P.default.AmbientGlow = 12;
		P.default.bDramaticLighting = false;
		P.AmbientGlow = 12;
		P.bDramaticLighting = false;
	}

	//if (Level.NetMode != NM_StandAlone)
		//SetClientStuff(Other);
}

simulated function SetClientStuff(Pawn Other)
{
	local Pawn P;

	Other.default.AmbientGlow = 12;
	Other.default.bDramaticLighting = false;
	Other.AmbientGlow = 12;
	Other.bDramaticLighting = false;
	log("WHAT ON INTERNET WHAT ON INTERNET WHAT ON INTERNET");

	foreach DynamicActors(class'Pawn', P)
	{
		P.default.AmbientGlow = 12;
		P.default.bDramaticLighting = false;
		P.AmbientGlow = 12;
		P.bDramaticLighting = false;
	}
}

simulated event Tick(float deltatime)
{
	local Pawn P;

	Super.Tick(deltatime);

	foreach DynamicActors(class'Pawn', P)
	{
		P.default.AmbientGlow = 12;
		P.default.bDramaticLighting = false;
		P.AmbientGlow = 12;
		P.bDramaticLighting = false;
	}
}

//=============================================================================
simulated function BeginPlay()
{

    local xWeaponBase xWB;
    local WeaponLocker WL;
    local int x;

    if(bAllowOverride) 
    {
    foreach DynamicActors(class'WeaponLocker', WL)
    {
         for(x=0; x<8; x++)
         {
              if(WL.Weapons[x].WeaponClass == class'Redeemer')
                   WL.Weapons[x].WeaponClass = class'EHRedeemerII';
              if(WL.Weapons[x].WeaponClass == class'Painter')
                   WL.Weapons[x].WeaponClass = class'EHPainter';
              if(WL.Weapons[x].WeaponClass == class'ONSPainter')
                   WL.Weapons[x].WeaponClass = class'EHONSPainter';
         }
    }

    foreach DynamicActors(class'xWeaponBase', xWB)
    {
         if((xWB.IsA('xWeaponBase')) && (xWB.WeaponType == class'Redeemer'))
              xWB.WeaponType = class'EHRedeemerII';
         else if((xWB.IsA('NewWeaponBase')) && (NewWeaponBase(xWB).WeaponType == class'Redeemer'))
              NewWeaponBase(xWB).WeaponType = class'EHRedeemerII';
              if((xWB.IsA('xWeaponBase')) && (xWB.WeaponType == class'Painter'))
              xWB.WeaponType = class'EHPainter';
         else if((xWB.IsA('NewWeaponBase')) && (NewWeaponBase(xWB).WeaponType == class'Painter'))
              NewWeaponBase(xWB).WeaponType = class'EHPainter';
         if((xWB.IsA('xWeaponBase')) && (xWB.WeaponType == class'ONSPainter'))
              xWB.WeaponType = class'EHONSPainter';
         else if((xWB.IsA('NewWeaponBase')) && (NewWeaponBase(xWB).WeaponType == class'ONSPainter'))
              NewWeaponBase(xWB).WeaponType = class'EHONSPainter';
    }

     }



    Super.BeginPlay();
}

//=============================================================================
function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
    local int i;
    local WeaponLocker L;

    if(bAllowOverride == True) {
    bSuperRelevant = 0;

    if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "OnslaughtFull.ONSPainter" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHONSPainter';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "OnslaughtFull.ONSPainterPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHONSPainterPickup" );
            return false;
        }
         }

    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "OnslaughtFull.ONSPainter" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHONSPainter';
        }
    }

//============================================================================

     if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.Painter" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHPainter';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.PainterPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHPainterPickup" );
            return false;
        }
         }

    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.Painter" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHPainter';
        }
    }

//============================================================================
     if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "xWeapons.Redeemer" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHRedeemerII';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "xWeapons.RedeemerPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHRedeemerIIPickup" );
            return false;
        }
         }

    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "xWeapons.Redeemer" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHRedeemerII';
        }
    }


     if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "Onslaught.ONSMineLayer" )
        {
            xWeaponBase(Other).WeaponType = class'EHMineLauncher';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSMineLayerPickup" )
        {
            ReplaceWith( Other, "EHMinePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSMineAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHMineAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "Onslaught.ONSMineLayer" )
                L.Weapons[i].WeaponClass = class'EHMineLauncher';
        }
    }

        if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "Onslaught.ONSGrenadeLauncher" )
        {
            xWeaponBase(Other).WeaponType = class'EHONSGrenadeLauncher';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSGrenadePickup" )
        {
            ReplaceWith( Other, "EHONSGrenadePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSGrenadeAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHONSGrenadeAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "Onslaught.ONSGrenadeLauncher" )
                L.Weapons[i].WeaponClass = class'EHONSGrenadeLauncher';
        }
    }
        if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.SniperRifle" )
        {
            xWeaponBase(Other).WeaponType = class'EHLightningRifle';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.SniperRiflePickup" )
        {
            ReplaceWith( Other, "EHLightningRiflePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.SniperAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHLightningAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.SniperRifle" )
                L.Weapons[i].WeaponClass = class'EHLightningRifle';
        }
    }

        if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.LinkGun" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHLinkGun';
            return false;
        }
    }
   else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.LinkGunPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHLinkGunPickup" );
            return false;
        }
         }
   else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.LinkAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHLinkAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.LinkGun" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHLinkGun';
        }
     }
                if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.Minigun" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHMinigun';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.MinigunPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHMinigunPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.MinigunAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHMinigunAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.Minigun" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHMinigun';
        }
    }

                if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.Painter" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHPainter';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.PainterPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHPainterPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.PainterAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHPainterAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.Painter" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHPainter';
        }
    }
                if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.BioRifle" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHBioRifle';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.BioRiflePickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHBioRiflePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.BioAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHBioAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.BioRifle" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHBioRifle';
        }
    }

                if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.AssaultRifle" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHAssaultRifle';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.AssaultRiflePickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHAssaultRiflePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.AssaultAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHAssaultAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.AssaultRifle" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHAssaultRifle';
        }
    }

                if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.ShockRifle" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHShockRifle';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.ShockRiflePickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHShockRiflePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.ShockAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHShockAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.ShockRifle" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHShockRifle';
        }
    }

            if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.Shieldgun" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHShieldgun';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.ShieldgunPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHShieldgunPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.ShieldAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHShieldAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.Shieldgun" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHShieldgun';
        }
    }


            if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "XWeapons.FlakCannon" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHFlakCannon';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.FlakCannonPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHFlakCannonPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "XWeapons.FlakAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHFlakAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "XWeapons.FlakCannon" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHFlakCannon';
        }
    }


        if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "Onslaught.ONSAVRiL" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHAVRiL';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSAVRiLPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHAVRiLPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "Onslaught.ONSAVRiLAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHAVRiLAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "Onslaught.ONSAVRiL" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHAVRiL';
        }
    }

    if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "xWeapons.RocketLauncher" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHRocketLauncher';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "xWeapons.RocketLauncherPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHRocketLauncherPickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "xWeapons.RocketAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHRocketAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "xWeapons.RocketLauncher" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHRocketLauncher';
        }
    }


    if ( xWeaponBase(Other) != None )
    {
        if ( string( xWeaponBase(Other).WeaponType ) ~= "UTClassic.ClassicSniperRifle" )
        {
            xWeaponBase(Other).WeaponType = class'mm_EHWeapons.EHSniperRifle';
            return false;
        }
    }
    else if ( WeaponPickup(Other) != None )
    {
        if ( string(Other.Class) ~= "UTClassic.ClassicSniperRiflePickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHSniperRiflePickup" );
            return false;
        }
         }
    else if ( Ammo(Other) != None )
    {
        if ( string(Other.Class) ~= "UTClassic.ClassicSniperAmmoPickup" )
        {
            ReplaceWith( Other, "mm_EHWeapons.EHSniperAmmoPickup" );
            return false;
        }

    }
    else if ( WeaponLocker(Other) != None )
    {
        L = WeaponLocker(Other);

        for (i = 0; i < L.Weapons.Length; i++)
        {
            if ( string( L.Weapons[i].WeaponClass ) ~= "UTClassic.ClassicSniperRifle" )
                L.Weapons[i].WeaponClass = class'mm_EHWeapons.EHSniperRifle';
        }
    }
    }

    return true;
}

//=============================================================================

defaultproperties
{
     bAllowTranslocator=True
     GroupName="Enhanced Weapons (Edited)"
     FriendlyName="Enhanced Weapons (Edited)"
     Description="Enhanced Weapons are enhanced versions of the stock UT'04 weapons without the ambient glow. After the polar opposite to Bright Skins? Tactical Shadows reduces the garish and tacky glow and excessive lighting on the player models making them blend far more easily into the lighting whilst also bringing back the tactical gameplay of hiding in shadows to avoid or surprise enemies. - http://fraghouse.beyondunreal.com|Edited by aeon for his invasion server, No credit is claimed here."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
