class EHFlakGlow extends ScaledSprite;

function PostBeginPlay()
{
	if ( Owner != None )
		SetBase(Owner);
}

singular function BaseChange();

defaultproperties
{
     bStatic=False
     bStasis=False
     RemoteRole=ROLE_None
     Texture=Texture'XEffects.GoldGlow'
     DrawScale=0.250000
     Style=STY_Translucent
     bUnlit=True
     bShouldBaseAtStartup=False
     bHardAttach=True
     Mass=0.000000
}
