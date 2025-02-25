class EHShieldEffect3rd extends AimedAttachment;

#exec OBJ LOAD FILE=XEffectMat.utx

var float Brightness, DesiredBrightness;
var int HitCount, OldHitCount;
var EHShieldSparks Sparks;

replication
{
    unreliable if (Role == ROLE_Authority && !bHidden)
        HitCount;
}

simulated function Destroyed()
{
    if (Sparks != None)
        Sparks.Destroy();
}

simulated function Flash(int Drain)
{
	if ( Level.NetMode != NM_DedicatedServer )
	{
		if (Sparks == None)
		{
			Sparks = Spawn(class'EHShieldSparks');
		}

		if (Instigator != None && Instigator.IsFirstPerson())
		{
			Sparks.SetLocation(Location+Vect(0,0,20)+VRand()*12.0);
			Sparks.SetRotation(Rotation);
			Sparks.mStartParticles = 16;
		}
		else if ( EffectIsRelevant(Location,false) )
		{
			Sparks.SetLocation(Location+VRand()*8.0);
			Sparks.SetRotation(Rotation);
			Sparks.mStartParticles = 16;
		}
	}
    Brightness = FMin(Brightness + Drain / 2, 250.0);
    Skins[0] = Skins[1];
    SetTimer(0.2, false);
}

simulated function Timer()
{
    Skins[0] = default.Skins[0];
}

function SetBrightness(int b, bool hit) // server only please
{
    DesiredBrightness = FMin(50+b*2, 250.0);
    if (hit)
    {
        HitCount++;
        Flash(50);
    }
}

simulated function PostNetReceive()
{
    if (OldHitCount == -1)
    {
        OldHitCount = HitCount;
    }
    else if (HitCount != OldHitCount)
    {
        Flash(50);
        OldHitCount = HitCount;
    }
}

defaultproperties
{
     Brightness=250.000000
     DesiredBrightness=250.000000
     OldHitCount=-1
     BaseOffset=(Z=10.000000)
     AimedOffset=(X=28.000000,Y=28.000000,Z=34.000000)
     DownwardBias=16.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.Shield'
     bHidden=True
     bReplicateInstigator=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=3.200000
     Skins(0)=Shader'mm_EHWeapons.EHWeaponSkinsB.ShieldShader'
     Skins(1)=Shader'mm_EHWeapons.EHWeaponSkinsB.ShieldShader'
     AmbientGlow=250
     bUnlit=True
     bOwnerNoSee=True
     bNetNotify=True
}
