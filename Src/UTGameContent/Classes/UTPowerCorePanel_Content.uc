/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTPowerCorePanel_Content extends UTPowerCorePanel;

defaultproperties
{
   BreakSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CorePanelBreakCue'
   HitSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CorePanelImpactCue'
   Begin Object Class=StaticMeshComponent Name=GibMesh ObjName=GibMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Power_Core_Panel'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTPowerCorePanel_Content:PanelLightEnvironmentComp'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      BlockActors=False
      RBCollideWithChannels=(Default=True,Pawn=True,Vehicle=True,GameplayPhysics=True,EffectPhysics=True)
      bNotifyRigidBodyCollision=True
      Scale=0.600000
      ScriptRigidBodyCollisionThreshold=10.000000
      Name="GibMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Mesh=GibMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=PanelLightEnvironmentComp ObjName=PanelLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      AmbientGlow=(R=0.800000,G=0.800000,B=0.800000,A=1.000000)
      bCastShadows=False
      bDynamic=False
      Name="PanelLightEnvironmentComp"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(0)=PanelLightEnvironmentComp
   Components(1)=GibMesh
   Physics=PHYS_RigidBody
   TickGroup=TG_PostAsyncWork
   bGameRelevant=True
   bCollideActors=True
   bProjTarget=True
   bNoEncroachCheck=True
   LifeSpan=8.000000
   CollisionComponent=GibMesh
   Name="Default__UTPowerCorePanel_Content"
   ObjectArchetype=UTPowerCorePanel'UTGame.Default__UTPowerCorePanel'
}
