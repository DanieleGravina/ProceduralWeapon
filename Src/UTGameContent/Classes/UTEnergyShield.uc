/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTEnergyShield extends UTDeployedActor;

/** Array of current health of each shield piece */
var int ShieldHealth;

/** shield mesh (has collision) */
var StaticMeshComponent ShieldMesh;

/** shield generation effect */
var UTParticleSystemComponent ShieldEffect;

var SkeletalMeshComponent ShieldBase;

/** sounds to play */
var SoundCue SpawnSound, DestroySound, PanelDestroySound;

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( !bDeleteMe && (Role == ROLE_Authority) )
	{
		PlaySound(SpawnSound);
	}
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (Role == ROLE_Authority)
	{
		PlaySound(DestroySound);
	}
}

event Landed(vector HitNormal, Actor HitActor)
{
	PerformDeploy();
}

simulated function PerformDeploy()
{
	bDeployed = true;
	
	ShieldBase.PlayAnim('Deploy');

	ShieldMesh.SetHidden(false);
	ShieldMesh.SetActorCollision(true, false);
	ShieldEffect.SetActive(true);
	bCollideWorld = FALSE;
}

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if ( WorldInfo.GRI.OnSameTeam(EventInstigator, self) )
	{
		return;
	}
	ShieldHealth -= DamageAmount;
	PlaySound(PanelDestroySound);

	if ( ShieldHealth <= 0 )
	{
		destroy();
	}
	
	// call Actor's version to handle any SeqEvent_TakeDamage for scripting
	Super.TakeDamage(DamageAmount, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}

defaultproperties
{
   ShieldHealth=4000
   Begin Object Class=StaticMeshComponent Name=ShieldMesh ObjName=ShieldMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Deployables.Mesh.S_Pickups_Shield_Deployable_Whole'
      HiddenGame=True
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Scale=5.000000
      Name="ShieldMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   ShieldMesh=ShieldMesh
   Begin Object Class=UTParticleSystemComponent Name=ShieldEffect ObjName=ShieldEffect Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Deployables.Effects.P_Deployables_Shield_Projector'
      bAutoActivate=False
      Name="ShieldEffect"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ShieldEffect=ShieldEffect
   Begin Object Class=SkeletalMeshComponent Name=DeployableMesh ObjName=DeployableMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Shield'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTEnergyShield:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Shield'
      bUseAsOccluder=False
      CastShadow=False
      Name="DeployableMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   ShieldBase=DeployableMesh
   SpawnSound=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_OpenCue'
   DestroySound=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_CloseCue'
   PanelDestroySound=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_PanelBlowCue'
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDeployedActor:DeployedLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDeployedActor:DeployedLightEnvironment'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ShieldAmbient'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(1)=AmbientSoundComponent
   Components(2)=DeployableMesh
   Components(3)=ShieldMesh
   Components(4)=ShieldEffect
   Begin Object Class=AudioComponent Name=AmbientComponent ObjName=AmbientComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_OutsideLoopCue'
      bAutoPlay=True
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(5)=AmbientComponent
   bPushedByEncroachers=False
   bAlwaysRelevant=True
   bHardAttach=True
   bBlockActors=False
   bProjTarget=True
   LifeSpan=90.000000
   CollisionComponent=DeployableMesh
   Name="Default__UTEnergyShield"
   ObjectArchetype=UTDeployedActor'UTGame.Default__UTDeployedActor'
}
