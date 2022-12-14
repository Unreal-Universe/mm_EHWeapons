class MinigunBulletDecal extends xScorch;

function PostBeginPlay()
{
	if ( FRand() < 0.75 )
		LifeSpan *= 0.5;
	Super.PostBeginPlay();
}

defaultproperties
{
     RandomOrient=False
     ProjTexture=Texture'EHWeaponSkinsB.bulletHole'
     bClipStaticMesh=True
     CullDistance=3000.000000
     bHighDetail=True
     LifeSpan=3.200000
     DrawScale=0.180000
}
