/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTCTFBlueFlag extends UTCTFFlag;

var ParticleSystemComponent BlueGlow;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SkelMesh.AttachComponentToSocket(BlueGlow,'PoleEmitter');
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=BlueParticle ObjName=BlueParticle Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'CTF_Flag_IronGuard.Effects.P_CTF_Flag_IronGuard_Idle_Blue'
      Name="BlueParticle"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   BlueGlow=BlueParticle
   RespawnEffect=ParticleSystem'CTF_Flag_IronGuard.Effects.P_CTF_Flag_IronGuard_Spawn_Blue'
   Begin Object Class=SkeletalMeshComponent Name=TheFlagSkelMesh ObjName=TheFlagSkelMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
      SkeletalMesh=SkeletalMesh'CTF_Flag_IronGuard.Mesh.S_CTF_Flag_IronGuard'
      PhysicsAsset=PhysicsAsset'CTF_Flag_IronGuard.Mesh.S_CTF_Flag_IronGuard_Physics'
      Materials(0)=None
      Materials(1)=Material'CTF_Flag_IronGuard.Materials.M_CTF_Flag_IG_FlagBlue'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
   End Object
   SkelMesh=TheFlagSkelMesh
   Begin Object Class=ParticleSystemComponent Name=ScoreEffect ObjName=ScoreEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Flag.Effects.P_Flagbase_FlagCaptured_Blue'
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
      LightColor=(B=255,G=128,R=64,A=0)
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
   Name="Default__UTCTFBlueFlag"
   ObjectArchetype=UTCTFFlag'UTGame.Default__UTCTFFlag'
}
