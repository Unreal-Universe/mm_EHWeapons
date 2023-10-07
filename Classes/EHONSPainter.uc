class EHONSPainter extends EHPainter;

var float MinZDist;

function bool CanBomb(vector MarkLocation, float NeededRadius)
{
	if (!FastTrace(MarkLocation + MinZDist * vect(0,0,1), MarkLocation))
		return false;

	if (NeededRadius <= 0 || EHONSPainterFire(FireMode[0]) == None)
		return true;

	MarkLocation += vect(0,0,100);
	return ( FastTrace(MarkLocation + vect(1,0,0) * NeededRadius, MarkLocation) && FastTrace(MarkLocation + vect(-1,0,0) * NeededRadius, MarkLocation)
		 && FastTrace(MarkLocation + vect(0,1,0) * NeededRadius, MarkLocation) && FastTrace(MarkLocation + vect(0,-1,0) * NeededRadius, MarkLocation) );
}

function float GetAIRating()
{
	local Bot B;
	local vector HitLocation, HitNormal;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;
	if ( B.IsShootingObjective() && Trace(HitLocation, HitNormal, B.Target.Location - vect(0,0,2000), B.Target.Location, false) != None )
	{
		MarkLocation = HitLocation;
		if ( CanBomb(MarkLocation, 0) )
			return AIRating;
	}
	if ( (B.Enemy == None) || (Instigator.Location.Z < B.Enemy.Location.Z) || !B.EnemyVisible() )
		return 0;
	MarkLocation = B.Enemy.Location - B.Enemy.CollisionHeight * vect(0,0,2);
	if ( CanBomb(MarkLocation, 0) )
		return 2.0;
	if ( TerrainInfo(B.Enemy.Base) == None )
		return 0;
	return 0.1;
}

simulated event RenderOverlays( Canvas Canvas )
{
	local float tileScaleX;
	local float tileScaleY;
	local float bX;
	local float bY;
	local float fX;
	local float fY;
	local float ChargeBar;

	local float barOrgX;
	local float barOrgY;
	local float barSizeX;
	local float barSizeY;

    local EHONSPainterFire EHONSPainterFire;

	CheckOutOfAmmo();

    //    FireSound=Sound'WeaponSounds.LightningGun.LightningScope'
    if ( LastFOV > PlayerController(Instigator.Controller).DesiredFOV )
    {
        PlaySound(Sound'WeaponSounds.LightningGun.LightningZoomIn', SLOT_Misc,,,,,false);
    }
    else if ( LastFOV < PlayerController(Instigator.Controller).DesiredFOV )
    {
        PlaySound(Sound'WeaponSounds.LightningGun.LightningZoomOut', SLOT_Misc,,,,,false);
    }
    LastFOV = PlayerController(Instigator.Controller).DesiredFOV;

    if ( PlayerController(Instigator.Controller).DesiredFOV == PlayerController(Instigator.Controller).DefaultFOV )
	{
        Super.RenderOverlays(Canvas);
		zoomed=false;
	}
	else
    {
		EHONSPainterFire = EHONSPainterFire(FireMode[0]);
        if (EHONSPainterFire.bIsFiring && EHONSPainterFire.bValidMark && Level.TimeSeconds - EHONSPainterFire.MarkTime > 0.4)
        {
            ChargeBar = FMin(1.0, ((Level.TimeSeconds - EHONSPainterFire.MarkTime) / EHONSPainterFire.PaintDuration));
            if (ChargeBar >= 1.0) ChargeBar = 0.0;
        }
        else
            ChargeBar = 0.0;

		tileScaleX = Canvas.SizeX / 640.0f;
		tileScaleY = Canvas.SizeY / 480.0f;

		bX = borderX * tileScaleX;
		bY = borderY * tileScaleY;
		fX = focusX * tileScaleX;
		fY = focusY * tileScaleX;

		barOrgX = RechargeOrigin.X * tileScaleX;
		barOrgY = RechargeOrigin.Y * tileScaleY;

		barSizeX = RechargeSize.X * tileScaleX;
		barSizeY = RechargeSize.Y * tileScaleY;

        SetZoomBlendColor(Canvas);

        Canvas.Style = 255;
		Canvas.SetPos(0,0);
        Canvas.DrawTile( Material'ZoomFB', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 512, 512 ); // !! hardcoded size

		// draw border corners
        Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( Texture'SniperBorder', bX, bY, 0.0, 0.0, Texture'SniperBorder'.USize, Texture'SniperBorder'.VSize );

		Canvas.SetPos(Canvas.SizeX-bX,0);
		Canvas.DrawTile( Texture'SniperBorder', bX, bY, 0.0, 0.0, -Texture'SniperBorder'.USize, Texture'SniperBorder'.VSize );

		Canvas.SetPos(Canvas.SizeX-bX,Canvas.SizeY-bY);
		Canvas.DrawTile( Texture'SniperBorder', bX, bY, 0.0, 0.0, -Texture'SniperBorder'.USize, -Texture'SniperBorder'.VSize );

		Canvas.SetPos(0,Canvas.SizeY-bY);
		Canvas.DrawTile( Texture'SniperBorder', bX, bY, 0.0, 0.0, Texture'SniperBorder'.USize, -Texture'SniperBorder'.VSize );


		Canvas.DrawColor = FocusColor;
        Canvas.DrawColor.A = 255; // 255 was the original -asp. WTF??!?!?!
		Canvas.Style = ERenderStyle.STY_Alpha;

		Canvas.SetPos((Canvas.SizeX*0.5)-fX,(Canvas.SizeY*0.5)-fY);
		Canvas.DrawTile( Texture'SniperFocus', fX*2.0, fY*2.0, 0.0, 0.0, Texture'SniperFocus'.USize, Texture'SniperFocus'.VSize );

        fX = innerArrowsX * tileScaleX;
		fY = innerArrowsY * tileScaleY;

        Canvas.DrawColor = ArrowColor;
        Canvas.SetPos((Canvas.SizeX*0.5)-fX,(Canvas.SizeY*0.5)-fY);
		Canvas.DrawTile( Texture'SniperArrows', fX*2.0, fY*2.0, 0.0, 0.0, Texture'SniperArrows'.USize, Texture'SniperArrows'.VSize );


		// Draw the Charging meter  -AsP
		Canvas.DrawColor = ChargeColor;
        Canvas.DrawColor.A = 255;

		if(ChargeBar <1)
		    Canvas.DrawColor.R = 255*ChargeBar;
		else
        {
            Canvas.DrawColor.R = 0;
		    Canvas.DrawColor.B = 0;
        }

		if(ChargeBar == 1)
		    Canvas.DrawColor.G = 255;
		else
		    Canvas.DrawColor.G = 0;

		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos( barOrgX, barOrgY );
		Canvas.DrawTile(Texture'Engine.WhiteTexture',barSizeX,barSizeY*ChargeBar, 0.0, 0.0,Texture'Engine.WhiteTexture'.USize,Texture'Engine.WhiteTexture'.VSize*ChargeBar);
		zoomed = true;
	}
}

defaultproperties
{
     MinZDist=5000.000000
     FireModeClass(0)=Class'mm_EHWeapons.EHONSPainterFire'
     PutDownAnim="Deselect"
     SelectAnimRate=3.100000
     PutDownAnimRate=2.800000
     Description="The Enhanced Target Painter, similar to the Enhanced Ion Painter, fires a harmless, low power laser with its primary fire. Unlike the Enhanced Ion Painter, however, this weapon calls in a squadron of bombers that launches a string of bombs in the direction the user is facing, centered on the painted target. The bombs will easily incinerate the target and any unfortunates that happen to be nearby."
     EffectOffset=(Y=45.000000)
     Priority=153
     SmallViewOffset=(X=100.000000,Y=22.000000,Z=-32.500000)
     CenteredOffsetY=-7.000000
     CenteredRoll=0
     CenteredYaw=-500
     GroupOffset=2
     PickupClass=Class'mm_EHWeapons.EHONSPainterPickup'
     PlayerViewOffset=(X=100.000000,Y=22.000000,Z=-32.500000)
     PlayerViewPivot=(Yaw=350)
     AttachmentClass=Class'mm_EHWeapons.EHONSPainterAttachment'
     ItemName="Enhanced Target Painter"
     bUseDynamicLights=True
     Mesh=SkeletalMesh'ONSFullAnimations.TargetPainter'
     DrawScale=0.600000
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.EHTargetPainterTEX'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
     HighDetailOverlay=None
}
