/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTCTFBase_Content extends UTCTFBase
	abstract;

defaultproperties
{
   Begin Object Class=AudioComponent Name=TakenSoundComponent ObjName=TakenSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.CTF.Cue.A_Gameplay_CTF_FlagAlarm_Cue'
      Name="TakenSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TakenSound=TakenSoundComponent
   BaseExitTime=8.000000
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Base_Flag.Mesh.S_Pickups_Base_Flag'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTCTFBase_Content:FlagBaseLightEnvironment'
      CullDistance=7000.000000
      CachedCullDistance=7000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True,Dynamic=True)
      CollideActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-64.000000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   FlagBaseMesh=StaticMeshComponent0
   CTFAnnouncerMessagesClass=Class'UTGameContent.UTCTFMessage'
   bHasSensor=True
   IconCoords=(U=377.000000,V=438.000000,UL=45.000000,VL=44.000000)
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTCTFBase:CollisionCylinder'
      CollisionHeight=60.000000
      CollisionRadius=60.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTCTFBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   GoodSprite=None
   BadSprite=None
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTCTFBase:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTCTFBase:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTCTFBase:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTCTFBase:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=DynamicLightEnvironmentComponent Name=FlagBaseLightEnvironment ObjName=FlagBaseLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="FlagBaseLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(3)=FlagBaseLightEnvironment
   Components(4)=StaticMeshComponent0
   RemoteRole=ROLE_SimulatedProxy
   bStatic=False
   bAlwaysRelevant=True
   CollisionComponent=CollisionCylinder
   Name="Default__UTCTFBase_Content"
   ObjectArchetype=UTCTFBase'UTGame.Default__UTCTFBase'
}
