/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTEMPMine extends UTDeployedActor;

var SoundCue ExplosionSound;
var ParticleSystem ExplosionEffect;
var float EMPRadius;
/** used to tell client to play explosion effect */
var repnotify byte ExplosionCount;

replication
{
	if (bNetDirty)
		ExplosionCount;
}

event Landed(vector HitNormal, Actor HitActor)
{
	if ( UTVehicle(HitActor) != None )
	{
		LifeSpan = FMin(LifeSpan, 30.0);
	}
	PerformDeploy();
	if ( !bDeleteMe )
	{
		SetTimer(0.1, true, 'CheckEMP');
	}
}

simulated function PerformDeploy()
{
	bDeployed = true;
	SkeletalMeshComponent(Mesh).PlayAnim('Deploy');
}

function CheckEmp()
{
	local UTVehicle V;
	local bool bActivated;
	local UTPlayerController OldDriver;

	ForEach CollidingActors(class'UTVehicle', V, EMPRadius,, true)
	{
		if (!V.bIsDisabled
			&& (!WorldInfo.GRI.OnSameTeam(self, V) || ((UTTeamGame(WorldInfo.Game) != None) && (UTTeamGame(WorldInfo.Game).FriendlyFireScale > 0) && (UTStealthVehicle(V) == None) && (UTVehicle_Leviathan(V) == None))) )
		{
			OldDriver = UTPlayerController(V.Controller);
			if ( V.DisableVehicle() )
			{
				bActivated = true;
				OldDriver.ClientPlaySound(ExplosionSound);
			}
		}
	}

	if (bActivated)
	{
		ExplosionCount++;
		SetTimer(3.0, false, 'ClearExplosionCount');
		PlayExplosionEffect();
		MakeNoise(1.0);
		// always leave some delay after last explosion to give time to replicate effect to clients
		if (LifeSpan > 0.5)
		{
			LifeSpan = FMax(LifeSpan - 4.0, 0.5);
		}
	}
}

function ClearExplosionCount()
{
	ExplosionCount = 0;
}

simulated function PlayExplosionEffect()
{
	local vector SpawnLocation;
	local rotator SpawnRotation;

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		PlaySound(ExplosionSound, true);
		SkeletalMeshComponent(Mesh).GetSocketWorldLocationAndRotation( 'EMPBurst', SpawnLocation, SpawnRotation );
		WorldInfo.MyEmitterPool.SpawnEmitter(ExplosionEffect, SpawnLocation, SpawnRotation);
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'ExplosionCount')
	{
		if (ExplosionCount != 0)
		{
			PlayExplosionEffect();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

defaultproperties
{
   ExplosionSound=SoundCue'A_Pickups_Deployables.EMPMine.EMPMine_ShockCue'
   ExplosionEffect=ParticleSystem'PICKUPS.Deployables.Effects.P_Deployables_EMP_Mine_Pulse'
   EMPRadius=500.000000
   Begin Object Class=SkeletalMeshComponent Name=DeployableMesh ObjName=DeployableMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_EMP_Mine'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTEMPMine:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_EMP_Mine'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTEMPMine:DeployedLightEnvironment'
      bUseAsOccluder=False
      Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
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
   Begin Object Class=CylinderComponent Name=ColComp ObjName=ColComp Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      Name="ColComp"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   Components(2)=ColComp
   bOrientOnSlope=True
   LifeSpan=60.000000
   CollisionComponent=ColComp
   Name="Default__UTEMPMine"
   ObjectArchetype=UTDeployedActor'UTGame.Default__UTDeployedActor'
}
