/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_SPMACamera_Content extends UTProj_SPMACamera;

/** Played when the camera is stationary in the air **/
var ParticleSystemComponent PSC_KeepInAirJets;


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if( WorldInfo.NetMode != NM_DedicatedServer )
	{
		if( Instigator.GetTeamNum() == 1 )
		{
			Mesh.SetMaterial( 0, MaterialInterface'VH_SPMA.Materials.MI_VH_SPMA_Camera_Blue' );
		}
		else
		{
			Mesh.SetMaterial( 0, MaterialInterface'VH_SPMA.Materials.MI_VH_SPMA_Camera_Red' );
		}
	}
}


simulated function ShutDown()
{
	PSC_KeepInAirJets.DeactivateSystem();
	Super.ShutDown();
}

simulated event Destroyed()
{
	PSC_KeepInAirJets.DeactivateSystem();
	Super.Destroyed();
}

simulated function DeployCamera()
{
	Super.DeployCamera();

	if (DeploySound != none)
	{
		PlaySound(DeploySound, true);
	}

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		Mesh.PlayAnim('MissleOpen');
		PSC_KeepInAirJets.ActivateSystem();
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=KeepInAirJets ObjName=KeepInAirJets Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Camera_Little_jets'
      bAutoActivate=False
      Name="KeepInAirJets"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   PSC_KeepInAirJets=KeepInAirJets
   Begin Object Class=SkeletalMeshComponent Name=ProjMesh ObjName=ProjMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'VH_SPMA.Mesh.SK_VH_SPMA_Camera'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTProj_SPMACamera_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'VH_SPMA.Anims.K_VH_SPMA_Camera'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_SPMACamera_Content:MyLightEnvironment'
      bUseAsOccluder=False
      Scale=0.150000
      Name="ProjMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=ProjMesh
   DeploySound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_CameraDeploy'
   ShotDownSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Collide'
   PS_StartPoint=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Target_ArcStart'
   PS_Trail=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Target_ArcTrail_Red'
   PS_EndPointOnTarget=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_AIM_01'
   PS_EndPointOffTarget=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_AIM_02'
   AmbientSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_CameraAmbient'
   ExplosionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_ShellBrakingExplode'
   ProjFlightTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Camera_Rocket'
   ProjExplosionTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_SPMA_CamImpact'
   MyDamageType=Class'UTGameContent.UTDmgType_SPMACameraCrush'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_SPMACamera:CollisionCylinder'
      CollisionHeight=32.000000
      CollisionRadius=48.000000
      CollideActors=True
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_SPMACamera:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      AmbientGlow=(R=0.200000,G=0.200000,B=0.200000,A=1.000000)
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(1)=MyLightEnvironment
   Components(2)=ProjMesh
   Components(3)=KeepInAirJets
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SPMACamera_Content"
   ObjectArchetype=UTProj_SPMACamera'UTGame.Default__UTProj_SPMACamera'
}
