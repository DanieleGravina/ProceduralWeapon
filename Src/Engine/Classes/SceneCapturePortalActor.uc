/**
 * SceneCapturePortalActor
 *
 * Place this actor in a level to capture the scene
 * to a texture target using a SceneCapturePortalComponent
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SceneCapturePortalActor extends SceneCaptureReflectActor
	native
	placeable;

// so we do not load this Mesh on the console (some how it is being loaded even tho the correct flags are set)
var notforconsole StaticMesh CameraMesh;
var StaticMeshComponent CameraComp;

// so we do not load this Mesh on the console (some how it is being loaded even tho the correct flags are set)
var notforconsole StaticMesh TexPropPlaneMesh;


event PreBeginPlay()
{
	Super.PreBeginPlay();

	CameraComp.SetStaticMesh( CameraMesh );
	StaticMesh.SetStaticMesh( TexPropPlaneMesh );
}


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   CameraMesh=StaticMesh'EditorMeshes.MatineeCam_SM'
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      HiddenGame=True
      CastShadow=False
      CollideActors=False
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Scale3D=(X=-1.000000,Y=1.000000,Z=1.000000)
      Name="StaticMeshComponent1"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   CameraComp=StaticMeshComponent1
   TexPropPlaneMesh=StaticMesh'EditorMeshes.TexPropPlane'
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent2 ObjName=StaticMeshComponent2 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      HiddenGame=True
      CastShadow=False
      CollideActors=False
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="StaticMeshComponent2"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   StaticMesh=StaticMeshComponent2
   Begin Object Class=SceneCapturePortalComponent Name=SceneCapturePortalComponent0 ObjName=SceneCapturePortalComponent0 Archetype=SceneCapturePortalComponent'Engine.Default__SceneCapturePortalComponent'
      Name="SceneCapturePortalComponent0"
      ObjectArchetype=SceneCapturePortalComponent'Engine.Default__SceneCapturePortalComponent'
   End Object
   SceneCapture=SceneCapturePortalComponent0
   Components(0)=SceneCapturePortalComponent0
   Components(1)=StaticMeshComponent1
   Components(2)=StaticMeshComponent2
   Rotation=(Pitch=0,Yaw=0,Roll=0)
   Name="Default__SceneCapturePortalActor"
   ObjectArchetype=SceneCaptureReflectActor'Engine.Default__SceneCaptureReflectActor'
}
