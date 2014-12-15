/**
 * SceneCapture2DActor
 *
 * Place this actor in the level to capture it to a render target texture.
 * Uses a 2D scene capture component
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SceneCapture2DActor extends SceneCaptureActor
	native
	placeable;

/** used to draw the frustum lines and the texture surface */
var const DrawFrustumComponent DrawFrustum;

// so we do not load this Mesh on the console (some how it is being loaded even tho the correct flags are set)
var notforconsole StaticMesh CameraMesh;
var StaticMeshComponent CameraComp;

event PreBeginPlay()
{
	Super.PreBeginPlay();

	CameraComp.SetStaticMesh( CameraMesh );
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
   Begin Object Class=DrawFrustumComponent Name=DrawFrust0 ObjName=DrawFrust0 Archetype=DrawFrustumComponent'Engine.Default__DrawFrustumComponent'
      FrustumColor=(B=255,G=255,R=255,A=255)
      Name="DrawFrust0"
      ObjectArchetype=DrawFrustumComponent'Engine.Default__DrawFrustumComponent'
   End Object
   DrawFrustum=DrawFrust0
   CameraMesh=StaticMesh'EditorMeshes.MatineeCam_SM'
   Begin Object Class=StaticMeshComponent Name=CamMesh0 ObjName=CamMesh0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      HiddenGame=True
      CastShadow=False
      CollideActors=False
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="CamMesh0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   CameraComp=CamMesh0
   Begin Object Class=SceneCapture2DComponent Name=SceneCapture2DComponent0 ObjName=SceneCapture2DComponent0 Archetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
      Name="SceneCapture2DComponent0"
      ObjectArchetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
   End Object
   SceneCapture=SceneCapture2DComponent0
   Components(0)=SceneCapture2DComponent0
   Components(1)=CamMesh0
   Components(2)=DrawFrust0
   Name="Default__SceneCapture2DActor"
   ObjectArchetype=SceneCaptureActor'Engine.Default__SceneCaptureActor'
}
