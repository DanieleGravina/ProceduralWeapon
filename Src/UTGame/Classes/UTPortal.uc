/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTPortal extends PortalTeleporter
	placeable;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__PortalTeleporter:StaticMeshComponent1'
      ObjectArchetype=StaticMeshComponent'Engine.Default__PortalTeleporter:StaticMeshComponent1'
   End Object
   CameraComp=StaticMeshComponent1
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent2 ObjName=StaticMeshComponent2 Archetype=StaticMeshComponent'Engine.Default__PortalTeleporter:StaticMeshComponent2'
      ObjectArchetype=StaticMeshComponent'Engine.Default__PortalTeleporter:StaticMeshComponent2'
   End Object
   StaticMesh=StaticMeshComponent2
   Begin Object Class=SceneCapturePortalComponent Name=SceneCapturePortalComponent0 ObjName=SceneCapturePortalComponent0 Archetype=SceneCapturePortalComponent'Engine.Default__PortalTeleporter:SceneCapturePortalComponent0'
      ObjectArchetype=SceneCapturePortalComponent'Engine.Default__PortalTeleporter:SceneCapturePortalComponent0'
   End Object
   SceneCapture=SceneCapturePortalComponent0
   Components(0)=SceneCapturePortalComponent0
   Components(1)=StaticMeshComponent1
   Components(2)=StaticMeshComponent2
   bEdShouldSnap=True
   CollisionComponent=StaticMeshComponent2
   Name="Default__UTPortal"
   ObjectArchetype=PortalTeleporter'Engine.Default__PortalTeleporter'
}
