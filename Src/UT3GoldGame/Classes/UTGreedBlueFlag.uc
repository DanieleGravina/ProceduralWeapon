/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGreedBlueFlag extends UTGreedFlag;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=TheFlagSkelMesh ObjName=TheFlagSkelMesh Archetype=SkeletalMeshComponent'UT3GoldGame.Default__UTGreedFlag:TheFlagSkelMesh'
      ObjectArchetype=SkeletalMeshComponent'UT3GoldGame.Default__UTGreedFlag:TheFlagSkelMesh'
   End Object
   SkelMesh=TheFlagSkelMesh
   Begin Object Class=ParticleSystemComponent Name=ScoreEffect ObjName=ScoreEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Flag.Effects.P_Flagbase_FlagCaptured_Blue'
      bAutoActivate=False
      Name="ScoreEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   SuccessfulCaptureSystem=ScoreEffect
   Begin Object Class=DynamicLightEnvironmentComponent Name=FlagLightEnvironment ObjName=FlagLightEnvironment Archetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedFlag:FlagLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedFlag:FlagLightEnvironment'
   End Object
   LightEnvironment=FlagLightEnvironment
   Begin Object Class=PointLightComponent Name=FlagLightComponent ObjName=FlagLightComponent Archetype=PointLightComponent'UT3GoldGame.Default__UTGreedFlag:FlagLightComponent'
      ObjectArchetype=PointLightComponent'UT3GoldGame.Default__UTGreedFlag:FlagLightComponent'
   End Object
   FlagLight=FlagLightComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UT3GoldGame.Default__UTGreedFlag:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UT3GoldGame.Default__UTGreedFlag:CollisionCylinder'
   End Object
   Components(0)=CollisionCylinder
   Components(1)=FlagLightComponent
   Components(2)=FlagLightEnvironment
   Components(3)=TheFlagSkelMesh
   Components(4)=ScoreEffect
   CollisionComponent=CollisionCylinder
   MessageClass=Class'UTGameContent.UTCTFMessage'
   Name="Default__UTGreedBlueFlag"
   ObjectArchetype=UTGreedFlag'UT3GoldGame.Default__UTGreedFlag'
}
