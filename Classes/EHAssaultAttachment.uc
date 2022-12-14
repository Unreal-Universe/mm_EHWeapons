class EHAssaultAttachment extends xWeaponAttachment;

var byte OldSpawnHitCount;
var class<xEmitter>     mMuzFlashClass;
var xEmitter            mMuzFlash3rd;
var xEmitter            mMuzFlash3rdAlt;
var bool bDualGun;
var EHAssaultAttachment TwinGun;
var float AimAlpha;
//=============Tracers===========================
var class<Emitter>      mTracerClass;
var() editinline Emitter mTracer;
var float				mTracerInterval;
var() float             mTracerIntervalPrimary;
var() float				mTracerPullback;
var() float				mTracerMinDistance;
var() float				mTracerSpeed;
var float               mLastTracerTime;
var float               mCurrentRoll;
var float               mRollInc;
var float               mRollUpdateTime;
var vector	mOldHitLocation;
//===============================================
replication
{
	reliable if ( Role == ROLE_Authority )
		bDualGun, TwinGun;
}

simulated function Hide(bool NewbHidden)
{
	bHidden = NewbHidden;
	if ( TwinGun != None )
		TwinGun.bHidden = bHidden;
}

simulated function Destroyed()
{
	if ( bDualGun )
	{
		if ( Instigator != None )
		{
			Instigator.SetBoneDirection(AttachmentBone, Rotation,, 0, 0);
			Instigator.SetBoneDirection('lfarm', Rotation,, 0, 0);
		}
	}
	if (mTracer != None)  //=============
        mTracer.Destroy();
    if (mMuzFlash3rd != None)
        mMuzFlash3rd.Destroy();
    if (mMuzFlash3rdAlt != None)
        mMuzFlash3rdAlt.Destroy();
    Super.Destroyed();
}
//===============Tracers============================
simulated function UpdateRoll(float dt)
{
    local rotator r;

    UpdateRollTime(false);

    if (mRollInc <= 0.f)
        return;

    mCurrentRoll += dt*mRollInc;
    mCurrentRoll = mCurrentRoll % 65536.f;
    r.Roll = int(mCurrentRoll);


}

simulated function UpdateRollTime(bool bUpdate)
{
    local float diff;

    diff = Level.TimeSeconds - mRollUpdateTime;

    if (bUpdate)
        mRollUpdateTime = Level.TimeSeconds;

    // TODO: clean up!
    if (diff > 0.2)
    {
        mRollInc = 0.f;
    }
}
simulated function vector GetTracerStart()
{
    local Pawn p;

    p = Pawn(Owner);

    if ( (p != None) && p.IsFirstPerson() && p.Weapon != None )
    {
        // 1st person
        return p.Weapon.GetEffectStart();
    }


    // 3rd person
	if ( mMuzFlash3rd != None )
		return mMuzFlash3rd.Location;
	else
		return Location;
}

simulated function UpdateTracer()
{
    local vector SpawnLoc, SpawnDir, SpawnVel;
	local float hitDist;

    if (Level.NetMode == NM_DedicatedServer)
        return;

    if (mTracer == None)
    {
        mTracer = Spawn(mTracerClass);
        AttachToBone(mTracer, 'tip');
    }


    if (mTracer != None && Level.TimeSeconds > mLastTracerTime + mTracerInterval)
    {
		SpawnLoc = GetTracerStart();
		mTracer.SetLocation(SpawnLoc);

		hitDist = VSize(mHitLocation - SpawnLoc) - mTracerPullback;

		// If we have a hit but the hit location has not changed
		if(mHitLocation == mOldHitLocation)
			SpawnDir = vector( Instigator.GetViewRotation() );
		else
			SpawnDir = Normal(mHitLocation - SpawnLoc);

		if(hitDist > mTracerMinDistance)
		{
			SpawnVel = SpawnDir * mTracerSpeed;

			mTracer.Emitters[0].StartVelocityRange.X.Min = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.X.Max = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.Y.Min = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Y.Max = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Z.Min = SpawnVel.Z;
			mTracer.Emitters[0].StartVelocityRange.Z.Max = SpawnVel.Z;

			mTracer.Emitters[0].LifetimeRange.Min = hitDist / mTracerSpeed;
			mTracer.Emitters[0].LifetimeRange.Max = mTracer.Emitters[0].LifetimeRange.Min;

			mTracer.SpawnParticle(1);
		}

		mLastTracerTime = Level.TimeSeconds;

        GotoState('TickTracer');
    }

	mOldHitLocation = mHitLocation;
}

//==================================================


simulated function Tick(float deltatime)
{
	local rotator newRot;

	if ( !bDualGun || (Level.NetMode == NM_DedicatedServer) )
	{
		Disable('Tick');
		return;
	}

	AimAlpha = AimAlpha * ( 1 - 2*DeltaTime);

	// point in firing direction
	if ( Instigator != None )
	{
		newRot = Instigator.Rotation;
		if ( AimAlpha < 0.5 )
			newRot.Yaw += 4500 * (1 - 2*AimAlpha);
		Instigator.SetBoneDirection('lfarm', newRot,, 1.0, 1);

		newRot.Roll += 32768;
		Instigator.SetBoneDirection(AttachmentBone, newRot,, 1.0, 1);

	}
}

/* UpdateHit
- used to update properties so hit effect can be spawn client side
*/
function UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
    NetUpdateTime = Level.TimeSeconds - 1;//================
	SpawnHitCount++;
	mHitLocation = HitLocation;
	mHitActor = HitActor;
	mHitNormal = HitNormal;
}

simulated function MakeMuzzleFlash()
{
    local rotator r;

	AimAlpha = 1;
	if ( TwinGun != None )
		TwinGun.AimAlpha = 1;
	if (mMuzFlash3rd == None)
    {
        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'tip');
    }
    mMuzFlash3rd.mStartParticles++;
    r.Roll = Rand(65536);
    SetBoneRotation('Bone_Flash', r, 0, 1.f);
}

simulated event ThirdPersonEffects()
{
	local rotator r;
	local PlayerController PC;

    if ( Level.NetMode != NM_DedicatedServer )
	{
		AimAlpha = 1;
		if ( TwinGun != None )
			TwinGun.AimAlpha = 1;
        if (FiringMode == 0)
        {
            mTracerInterval = mTracerIntervalPrimary;
            mRollInc = 65536.f*3.f;//====================
			WeaponLight();
			if ( OldSpawnHitCount != SpawnHitCount )
			{
				OldSpawnHitCount = SpawnHitCount;
				GetHitInfo();
				PC = Level.GetLocalPlayerController();
				if ( ((Instigator != None) && (Instigator.Controller == PC)) || (VSize(PC.ViewTarget.Location - mHitLocation) < 4000) )
				{
					Spawn(class'HitEffect'.static.GetHitEffect(mHitActor, mHitLocation, mHitNormal),,, mHitLocation, Rotator(mHitNormal));
		            CheckForSplash();
					UpdateRollTime(true);//======================
					UpdateTracer();//======================
				}
			}
			MakeMuzzleFlash();
            if ( !bDualGun && (TwinGun != None) )
				TwinGun.MakeMuzzleFlash();
        }
        else if (FiringMode == 1 && FlashCount > 0)
        {
			WeaponLight();
            if (mMuzFlash3rdAlt == None)
            {
                mMuzFlash3rdAlt = Spawn(mMuzFlashClass);
                AttachToBone(mMuzFlash3rdAlt, 'tip2');
            }
            mMuzFlash3rdAlt.mStartParticles++;
            r.Roll = Rand(65536);
            SetBoneRotation('Bone_Flash02', r, 0, 1.f);
        }
    }

    Super.ThirdPersonEffects();
}
state TickTracer
{
    simulated function Tick(float deltaTime)
    {
        UpdateRoll(deltaTime);
    }
}

defaultproperties
{
     mMuzFlashClass=Class'XEffects.AssaultMuzFlash3rd'
     mTracerClass=Class'EHWeaponsE.EHNewTracer'
     mTracerIntervalPrimary=0.120000
     mTracerPullback=50.000000
     mTracerSpeed=10000.000000
     bRapidFire=True
     SplashEffect=Class'XGame.BulletSplash'
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=255.000000
     LightRadius=4.000000
     LightPeriod=3
     bUseDynamicLights=True
     Mesh=SkeletalMesh'NewWeapons2004.NewAssaultRifle_3rd'
     RelativeLocation=(X=-20.000000,Y=-5.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
     Skins(0)=Texture'EHWeaponSkinsB.AssaultRifleTex02'
     AmbientGlow=12
     bShadowCast=True
     bStaticLighting=True
}
