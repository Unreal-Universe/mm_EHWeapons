class EHShieldAttachment extends xWeaponAttachment;

var EHForceRing EHForceRing3rd;
var EHShieldEffect3rd EHShieldEffect3rd;

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        EHShieldEffect3rd;
}

simulated function Destroyed()
{
    if (EHShieldEffect3rd != None)
        EHShieldEffect3rd.Destroy();

    if (EHForceRing3rd != None)
        EHForceRing3rd.Destroy();

    Super.Destroyed();
}

function InitFor(Inventory I)
{
    Super.InitFor(I);

	if ( (Instigator.PlayerReplicationInfo == None) || (Instigator.PlayerReplicationInfo.Team == None)
		|| (Instigator.PlayerReplicationInfo.Team.TeamIndex > 1) )
		EHShieldEffect3rd = Spawn(class'EHShieldEffect3rd', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		EHShieldEffect3rd = Spawn(class'EHShieldEffect3rdRED', I.Instigator);
	else
		EHShieldEffect3rd = Spawn(class'EHShieldEffect3rdBLUE', I.Instigator);
    EHShieldEffect3rd.SetBase(I.Instigator);
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
        if ( FiringMode == 0 )
        {
            if (EHForceRing3rd == None)
            {
                EHForceRing3rd = Spawn(class'EHForceRing');
                AttachToBone(EHForceRing3rd, 'tip');
            }

            EHForceRing3rd.Fire();
        }
    }

    Super.ThirdPersonEffects();
}

function SetBrightness(int b, bool hit)
{
    if (EHShieldEffect3rd != None)
        EHShieldEffect3rd.SetBrightness(b, hit);
}

defaultproperties
{
     bHeavy=True
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Weapons.ShieldGun_3rd'
     Skins(0)=Texture'mm_EHWeapons.EHWeaponSkinsB.ShieldTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
