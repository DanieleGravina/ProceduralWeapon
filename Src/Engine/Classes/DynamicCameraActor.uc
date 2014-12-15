/*
 * DynamicCameraActor
 * A CameraActor that can be spawned/deleted dynamically in-game.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class DynamicCameraActor extends CameraActor
	native
	notplaceable;

defaultproperties
{
   Begin Object Class=DrawFrustumComponent Name=DrawFrust0 ObjName=DrawFrust0 Archetype=DrawFrustumComponent'Engine.Default__CameraActor:DrawFrust0'
      ObjectArchetype=DrawFrustumComponent'Engine.Default__CameraActor:DrawFrust0'
   End Object
   DrawFrustum=DrawFrust0
   Begin Object Class=StaticMeshComponent Name=CamMesh0 ObjName=CamMesh0 Archetype=StaticMeshComponent'Engine.Default__CameraActor:CamMesh0'
      ObjectArchetype=StaticMeshComponent'Engine.Default__CameraActor:CamMesh0'
   End Object
   MeshComp=CamMesh0
   Components(0)=CamMesh0
   Components(1)=DrawFrust0
   bNoDelete=False
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DynamicCameraActor"
   ObjectArchetype=CameraActor'Engine.Default__CameraActor'
}
