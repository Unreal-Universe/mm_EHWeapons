class EHShockBeamEffect extends xEmitter;

var Vector HitNormal;
var class<EHShockBeamCoil> CoilClass;
var class<EHShockMuzFlash> MuzFlashClass;
var class<EHShockMuzFlash3rd> MuzFlash3Class;

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        HitNormal;
}

function AimAt(Vector hl, Vector hn)
{
    HitNormal = hn;
    mSpawnVecA = hl;
    if (Level.NetMode != NM_DedicatedServer)
        SpawnEffects();
}

simulated function PostNetBeginPlay()
{
    if (Role < ROLE_Authority)
        SpawnEffects();
}

simulated function SpawnImpactEffects(rotator HitRot, vector EffectLoc)
{
	Spawn(class'EHShockImpactFlare',,, EffectLoc, HitRot);
	Spawn(class'EHShockImpactRing',,, EffectLoc, HitRot);
	Spawn(class'ShockImpactScorch',,, EffectLoc, Rotator(-HitNormal));
	Spawn(class'EHShockExplosionCore',,, EffectLoc+HitNormal*8, HitRot);
}

simulated function bool CheckMaxEffectDistance(PlayerController P, vector SpawnLocation)
{
	return !P.BeyondViewDistance(SpawnLocation,3000);
}

simulated function SpawnEffects()
{
    local EHShockBeamCoil Coil;
    local xWeaponAttachment Attachment;

    if (Instigator != None)
    {
        if ( Instigator.IsFirstPerson() )
        {
			if ( (Instigator.Weapon != None) && (Instigator.Weapon.Instigator == Instigator) )
				SetLocation(Instigator.Weapon.GetEffectStart());
			else
				SetLocation(Instigator.Location);
            Spawn(MuzFlashClass,,, Location);
        }
        else
        {
            Attachment = xPawn(Instigator).WeaponAttachment;
            if (Attachment != None && (Level.TimeSeconds - Attachment.LastRenderTime) < 1)
                SetLocation(Attachment.GetTipLocation());
            else
                SetLocation(Instigator.Location + Instigator.EyeHeight*Vect(0,0,1) + Normal(mSpawnVecA - Instigator.Location) * 25.0);
            Spawn(MuzFlash3Class);
        }
    }

    if ( EffectIsRelevant(mSpawnVecA + HitNormal*2,false) && (HitNormal != Vect(0,0,0)) )
		SpawnImpactEffects(Rotator(HitNormal),mSpawnVecA + HitNormal*2);

    if ( (!Level.bDropDetail && (Level.DetailMode != DM_Low) && (VSize(Location - mSpawnVecA) > 40) && !Level.GetLocalPlayerController().BeyondViewDistance(Location,0))
		|| ((Instigator != None) && Instigator.IsFirstPerson()) )
    {
	    Coil = Spawn(CoilClass,,, Location, Rotation);
	    if (Coil != None)
		    Coil.mSpawnVecA = mSpawnVecA;
    }
}

defaultproperties
{
     CoilClass=Class'mm_EHWeapons.EHShockBeamCoil'
     MuzFlashClass=Class'mm_EHWeapons.EHShockMuzFlash'
     MuzFlash3Class=Class'mm_EHWeapons.EHShockMuzFlash3rd'
     mParticleType=PT_Beam
     mMaxParticles=5
     mLifeRange(0)=1.000000
     mRegenDist=150.000000
     mSizeRange(0)=6.000000
     mSizeRange(1)=6.000000
     mAttenKa=0.100000
     bReplicateInstigator=True
     bReplicateMovement=False
     RemoteRole=ROLE_SimulatedProxy
     NetPriority=3.000000
     LifeSpan=1.000000
     Texture=TexPanner'mm_EHWeapons.EHWeaponSkinsB.ShockBeamPanner'
     Skins(0)=TexPanner'mm_EHWeapons.EHWeaponSkinsB.ShockBeamPanner'
     Style=STY_Additive
}
