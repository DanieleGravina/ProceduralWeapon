/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_BioShot extends UTProjectile;

var Vector			SurfaceNormal;
var float			RestTime;
var float			DripTime;
var bool 			bCheckedSurface;
var bool			bOnMover;
var bool			bLanding;
var bool			bExploded;
var repnotify float RemainingRestTime;

var enum HitType
{
	HIT_None,
	HIT_Wall,
	HIT_Ceiling,
	HIT_Floor
} HitMode;

var float WallThreshold;
var ParticleSystem WallHit;
var ParticleSystem FloorHit;
var ParticleSystem CeilingHit;
var ParticleSystem HitPawnTemplate;
var ParticleSystem HitBioTemplate;
var Emitter HitEmitter;
var MaterialInterface GooDecalTemplate;

/** sound to play on explosion due to being stepped in */
var SoundCue SteppedInSound;
var array<MaterialInterface> GooDecalChoices;
var MaterialInstanceConstant GooDecalMaterial;
var MeshComponent GooMesh;

/** used to notify AI of bio on the ground */
var UTAvoidMarker FearSpot;

replication
{
	if (bNetDirty)
		RemainingRestTime;
}

simulated event PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	if ( PhysicsVolume.bWaterVolume && !NewVolume.bWaterVolume )
		Buoyancy = 0.5 * (Buoyancy + 1.08);
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (FearSpot != None)
	{
		FearSpot.Destroy();
	}
}

/**
 * Explode this glob
 */
simulated function Explode(Vector HitLocation, vector HitNormal)
{
	if ( bExploded )
		return;

	bExploded = true;
	SpawnExplosionEffects(HitLocation, HitNormal );
	Shutdown();
}

simulated function Shutdown()
{
	super.ShutDown();

		if (FearSpot != None)
	{
		FearSpot.Destroy();
	}
}

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{

	if (GooDecalMaterial != None)
	{
		GooDecalMaterial.SetScalarParameterValue('Blend',1);
	}

	if(HitEmitter != none) // shut down
	{
		HitEmitter.bCurrentlyActive=false;
		HitEmitter.Lifespan = 0.0001f; // seriously, goo, go away. :)
	}
	super.SpawnExplosionEffects(HitLocation, HitNormal);
}

simulated function GrowCollision()
{
	CollisionComponent.SetTranslation(vect(16,0,0));
	SetCollisionSize(24,16);
}

auto state Flying
{
	simulated event Landed(vector HitNormal, Actor FloorActor)
	{
		local float nDecalExtent;
		local ParticleSystem CurrentHit;

		if ( bLanding )
			return;
		bLanding = true;
		if (WorldInfo.NetMode != NM_DedicatedServer && !WorldInfo.bDropDetail && FloorActor != None && (Pawn(FloorActor) == None) && EffectIsRelevant(Location, false, MaxEffectDistance) )
		{
			GooDecalTemplate = GooDecalChoices[Rand(GooDecalChoices.length)];

			nDecalExtent= 70 + Rand(15);
			nDecalExtent *= DrawScale/default.DrawScale;

			GooDecalMaterial = new(self) class'MaterialInstanceConstant';
			GooDecalMaterial.SetParent(GooDecalTemplate);
			GooDecalMaterial.SetScalarParameterValue('Blend', 0);

			WorldInfo.MyDecalManager.SpawnDecal(GooDecalMaterial, Location, rotator(-HitNormal), nDecalExtent, nDecalExtent, 10.0, true);

			PlaySound(ImpactSound, true);
		}

		SurfaceNormal = HitNormal;
		if(Abs(HitNormal.Z) > WallThreshold) // A wall will have a low Z in the HitNormal since it's a unit vector
		{
			// is normal pointing up (floor) or down (ceiling)?
			CurrentHit = (HitNormal.Z >= 0) ? FloorHit : CeilingHit;
			HitMode = (HitNormal.Z >=0) ? HIT_Floor : HIT_Ceiling;
		}
		else
		{
			CurrentHit = WallHit;
			HitMode = HIT_Wall;
		}
		if (WorldInfo.NetMode != NM_DedicatedServer && CurrentHit != none)
		{
			HitEmitter = Spawn(class'UTEmitter', self,, location, rotator(HitNormal));
			HitEmitter.SetBase(self);
			HitEmitter.SetTemplate(CurrentHit, true);
		}

		bBlockedByInstigator = true;
		bCollideWorld = false;
		bProjTarget = true;
		GrowCollision();
		SetPhysics(PHYS_None);
		if(GooMesh != none)
		{
			GooMesh.SetHidden(true);
		}
		bCheckedsurface = false;

		// spawn marker so AI can avoid
		if (FearSpot == None && WorldInfo.Game != None && WorldInfo.Game.NumBots > 0)
		{
			FearSpot = Spawn(class'UTAvoidMarker');
		}

		GotoState('OnGround');

		if (FloorActor != None && !FloorActor.bStatic && !FloorActor.bWorldGeometry)
		{
			bOnMover = true;
			SetBase(FloorActor);
			if (Base == None)
			{
				Explode(Location, HitNormal);
			}
		}

		bLanding = false;
	}

	simulated function HitWall( Vector HitNormal, Actor Wall, PrimitiveComponent WallComp )
	{
		Landed(HitNormal, Wall);
	}

	simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
	{
		if ( (UTProj_BioShot(Other) != None) || Other.bProjTarget )
		{
			if ( !bExploded )
			{
				if(UTPawn(Other) != none)
				{
					ProjExplosionTemplate=HitPawnTemplate;
				}
				else
				{
					if(UTProj_BioGlob(Other) != none || UTProj_BioGlobling(Other) != none || UTProj_Bioshot(Other) != none)
					{
						ProjExplosionTemplate=HitBioTemplate;
					}
				}
				Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
				Explode( HitLocation, HitNormal );
			}
		}
   	}
}

state OnGround
{
	simulated function BeginState(Name PreviousStateName)
	{
		RemainingRestTime = RestTime;
		SetTimer(0.5, true);
	}

	simulated function Timer()
	{
		RemainingRestTime -= 0.5;
		if ( RemainingRestTime <= 0.0 )
		{
			Explode(Location, SurfaceNormal );
		}
	}

	simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
	{
		if ( (Other.bProjTarget && (Other != Base)) || (UTProj_BioShot(Other) != None) )
		{
			if ( !bExploded )
			{
				if(UTProj_BioGlob(Other) != none || UTProj_BioGlobling(Other) != none || UTProj_Bioshot(Other) != none)
				{
					ProjExplosionTemplate=HitBioTemplate;
				}
				Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
				ExplosionSound=SteppedInSound;
				Explode(Location, SurfaceNormal );
			}
		}
	}

	simulated event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
	{
		//`log(self$" take damage!");
		RemainingRestTime = -1.0;
		Timer();
	}

	simulated function HitWall( Vector HitNormal, Actor Wall, PrimitiveComponent WallComp );
}


simulated function MyOnParticleSystemFinished(ParticleSystemComponent PSC)
{
	return;
}

defaultproperties
{
   RestTime=3.000000
   DripTime=1.800000
   WallThreshold=0.300000
   WallHit=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Impact_Primary_Wall'
   FloorHit=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Impact_Primary_Floor'
   CeilingHit=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Impact_Primary_Ceiling'
   HitPawnTemplate=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Player_Hit'
   HitBioTemplate=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Blob_hits_Blob_Burst'
   GooDecalTemplate=DecalMaterial'WP_BioRifle.Materials.Bio_Splat_Decal'
   SteppedInSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactFizzle_Cue'
   GooDecalChoices(0)=DecalMaterial'WP_BioRifle.Materials.Bio_Splat_Decal'
   GooDecalChoices(1)=DecalMaterial'WP_BioRifle.Materials.Bio_Splat_Decal_001'
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'WP_BioRifle.Mesh.S_Bio_Ball'
      CullDistance=12000.000000
      CachedCullDistance=12000.000000
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Name="ProjectileMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   GooMesh=ProjectileMesh
   ExplosionSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue'
   ProjExplosionTemplate=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Primary_PoP'
   MaxEffectDistance=7000.000000
   CheckRadius=40.000000
   ExplosionLightClass=Class'UTGame.UTBioExplosionLight'
   Buoyancy=1.500000
   Damage=21.000000
   MomentumTransfer=40000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_BioGoo'
   ImpactSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      CollideActors=True
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=ProjectileMesh
   Physics=PHYS_Falling
   LifeSpan=12.000000
   CollisionComponent=CollisionCylinder
   RotationRate=(Pitch=50000,Yaw=0,Roll=0)
   DesiredRotation=(Pitch=30000,Yaw=0,Roll=0)
   Name="Default__UTProj_BioShot"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
