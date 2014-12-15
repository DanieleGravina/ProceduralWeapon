/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTShapedCharge extends UTDeployedActor
	abstract;

/** Countdown to explosion */
var int Count;

var vector FloorNormal;

/** Explosion effect */
var ParticleSystem ShapedChargeExplosion;

/** Class of ExplosionLight */
var class<UTExplosionLight> ExplosionLightClass;

/** The sound that is played when it explodes */
var SoundCue	ExplosionSound;

/** When the deployable has landed this system starts running*/
var ParticleSystemComponent	LandEffects;

var class<UTDamageType> ChargeDamageType;

/** explosion damage properties */
var int Damage;
var float DamageRadius, DamageMomentum;

var float ChargeColourBlend;

/** MIC for ramping colour */
var MaterialInstanceConstant	ChargeMI;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ChargeMI = Mesh.CreateAndSetMaterialInstanceConstant(0);
}

event Landed(vector HitNormal, Actor HitActor)
{
	if(Role == ROLE_Authority)
	{
		FloorNormal = HitNormal;
		settimer(1.0, true, 'CountDown');
		SetPhysics(PHYS_None);
		PerformDeploy();
	}
}

simulated function PerformDeploy()
{
	bDeployed = true;
	if(WorldInfo.NetMode != NM_DedicatedServer)
	{
		if(LandEffects != none && !LandEffects.bIsActive)
		{
			LandEffects.SetActive(true);
		}
	}
}

function CountDown()
{
	Count--;

	if ( Count <= 0 )
	{
		// blow up
		Destroy();
	}
}

simulated function Tick(float DeltaTime)
{
	if( bDeployed )
	{
		ChargeColourBlend += (DeltaTime * 0.5);
		ChargeColourBlend = FClamp(ChargeColourBlend, 0.0, 1.0);
		ChargeMI.SetScalarParameterValue('SC_Fill', ChargeColourBlend);
	}
}

simulated function Destroyed()
{
	local rotator Dir;

	if ( Role == ROLE_Authority )
	{
		HurtRadius(Damage,DamageRadius, ChargeDamageType, DamageMomentum, Location);
	}
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		// spawn client side explosion effect
		if ( EffectIsRelevant(Location, false) )
		{
			Dir = rotator(FloorNormal);
			WorldInfo.MyEmitterPool.SpawnEmitter(ShapedChargeExplosion, Location, Dir);
			UTEmitterPool(WorldInfo.MyEmitterPool).SpawnExplosionLight( ExplosionLightClass,
						Location + (0.25 * ExplosionLightClass.default.TimeShift[0].Radius * (vect(1,0,0) >> Dir)) );
		}
		PlaySound(ExplosionSound, true);
	}

	super.Destroyed();
}

defaultproperties
{
   Count=5
   ShapedChargeExplosion=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_Impact_MID'
   ExplosionLightClass=Class'UTGame.UTTankShellExplosionLight'
   ExplosionSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Impact_Cue'
   ChargeDamageType=Class'UTGameContent.UTDmgType_ShapedCharge'
   Damage=1200
   DamageRadius=500.000000
   DamageMomentum=200000.000000
   Begin Object Class=SkeletalMeshComponent Name=DeployableMesh ObjName=DeployableMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_ShapeCharge_1P'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTShapedCharge:DeployedLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Rotation=(Pitch=0,Yaw=32768,Roll=0)
      Name="DeployableMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=DeployableMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDeployedActor:DeployedLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDeployedActor:DeployedLightEnvironment'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Components(1)=DeployableMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=0.000000
      CollisionRadius=0.000000
      Name="CollisionCylinder"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   Components(2)=CollisionCylinder
   bOrientOnSlope=True
   LifeSpan=10.000000
   CollisionComponent=CollisionCylinder
   Name="Default__UTShapedCharge"
   ObjectArchetype=UTDeployedActor'UTGame.Default__UTDeployedActor'
}
