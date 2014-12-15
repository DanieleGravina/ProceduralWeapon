/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTCTFRedFlag extends UTCTFFlag;

var ParticleSystemComponent RedGlow;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SkelMesh.AttachComponentToSocket(RedGlow,'PoleEmitter');
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=RedParticle ObjName=RedParticle Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'CTF_Flag_IronGuard.Effects.P_CTF_Flag_IronGuard_Idle_Red'
      Name="RedParticle"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   RedGlow=RedParticle
   RespawnEffect=ParticleSystem'CTF_Flag_IronGuard.Effects.P_CTF_Flag_IronGuard_Spawn_Red'
   Begin Object Class=SkeletalMeshComponent Name=TheFlagSkelMesh ObjName=TheFlagSkelMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
      SkeletalMesh=SkeletalMesh'CTF_Flag_IronGuard.Mesh.S_CTF_Flag_IronGuard'
      PhysicsAsset=PhysicsAsset'CTF_Flag_IronGuard.Mesh.S_CTF_Flag_IronGuard_Physics'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
   End Object
   SkelMesh=TheFlagSkelMesh
   Begin Object Class=ParticleSystemComponent Name=ScoreEffect ObjName=ScoreEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Flag.Effects.P_Flagbase_FlagCaptured_Red'
      bAutoActivate=False
      Name="ScoreEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   SuccessfulCaptureSystem=ScoreEffect
   Begin Object Class=DynamicLightEnvironmentComponent Name=FlagLightEnvironment ObjName=FlagLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTCTFFlag:FlagLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTCTFFlag:FlagLightEnvironment'
   End Object
   LightEnvironment=FlagLightEnvironment
   PickupSound=SoundCue'A_Gameplay.CTF.Cue.A_Gameplay_CTF_FlagPickedUp01Cue'
   DroppedSound=SoundCue'A_Gameplay.CTF.Cue.A_Gameplay_CTF_FlagDropped01Cue'
   ReturnedSound=SoundCue'A_Gameplay.CTF.Cue.A_Gameplay_CTF_FlagReturn_Cue'
   Begin Object Class=PointLightComponent Name=FlagLightComponent ObjName=FlagLightComponent Archetype=PointLightComponent'UTGame.Default__UTCTFFlag:FlagLightComponent'
      LightColor=(B=0,G=64,R=255,A=0)
      ObjectArchetype=PointLightComponent'UTGame.Default__UTCTFFlag:FlagLightComponent'
   End Object
   FlagLight=FlagLightComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTCTFFlag:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTCTFFlag:CollisionCylinder'
   End Object
   Components(0)=CollisionCylinder
   Components(1)=FlagLightComponent
   Components(2)=FlagLightEnvironment
   Components(3)=TheFlagSkelMesh
   Components(4)=ScoreEffect
   CollisionComponent=CollisionCylinder
   MessageClass=Class'UTGameContent.UTCTFMessage'
   Name="Default__UTCTFRedFlag"
   ObjectArchetype=UTCTFFlag'UTGame.Default__UTCTFFlag'
}
