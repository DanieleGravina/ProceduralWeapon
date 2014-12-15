/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTCTFBlueFlagBase extends UTCTFBase_Content
	placeable;

defaultproperties
{
   Begin Object Class=AudioComponent Name=TakenSoundComponent ObjName=TakenSoundComponent Archetype=AudioComponent'UTGameContent.Default__UTCTFBase_Content:TakenSoundComponent'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTCTFBase_Content:TakenSoundComponent'
   End Object
   TakenSound=TakenSoundComponent
   FlagType=Class'UTGameContent.UTCTFBlueFlag'
   Begin Object Class=ParticleSystemComponent Name=EmptyParticles ObjName=EmptyParticles Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Flag.Effects.P_Flagbase_Empty_Idle_Blue'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Name="EmptyParticles"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   FlagEmptyParticles=EmptyParticles
   FlagBaseMaterial=MaterialInstanceConstant'PICKUPS.Base_Flag.Materials.M_Pickups_Base_Flag_Blue'
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'UTGameContent.Default__UTCTFBase_Content:StaticMeshComponent0'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTCTFBase_Content:StaticMeshComponent0'
   End Object
   FlagBaseMesh=StaticMeshComponent0
   NearLocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_NearTheBlueBase'
   NearLocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_NearTheBlueBase'
   NearLocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_NearTheBlueBase'
   MidfieldHighSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_MidfieldHigh'
   MidfieldHighSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_MidfieldHigh'
   MidfieldHighSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_MidfieldHigh'
   MidfieldLowSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_MidfieldLow'
   MidfieldLowSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_MidfieldLow'
   MidfieldLowSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_MidfieldLow'
   bHasLocationSpeech=True
   DefenderTeamIndex=1
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_InTheBlueBase'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_InTheBlueBase'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_InTheBlueBase'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTCTFBase_Content:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTCTFBase_Content:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGameContent.Default__UTCTFBase_Content:Arrow'
      ObjectArchetype=ArrowComponent'UTGameContent.Default__UTCTFBase_Content:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGameContent.Default__UTCTFBase_Content:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGameContent.Default__UTCTFBase_Content:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=DynamicLightEnvironmentComponent Name=FlagBaseLightEnvironment ObjName=FlagBaseLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTCTFBase_Content:FlagBaseLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTCTFBase_Content:FlagBaseLightEnvironment'
   End Object
   Components(3)=FlagBaseLightEnvironment
   Components(4)=StaticMeshComponent0
   Components(5)=EmptyParticles
   CollisionComponent=CollisionCylinder
   Name="Default__UTCTFBlueFlagBase"
   ObjectArchetype=UTCTFBase_Content'UTGameContent.Default__UTCTFBase_Content'
}
