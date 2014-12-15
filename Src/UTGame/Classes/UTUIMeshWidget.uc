/**
 * UT Specialized version of UIMeshWidget, adds some lights and optionally rotates the model.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTUIMeshWidget extends UIMeshWidget
	native(UI)
	placeable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Amount of degrees to rotate per second. */
var() vector	RotationRate;

/** Light for the mesh widget. */
var() SkeletalMeshComponent SkeletalMeshComp;

/** Light for the mesh widget. */
var() LightComponent DefaultLight;

/** Light direction. */
var() vector	LightDirection;

/** Light for the mesh widget. */
var() LightComponent DefaultLight2;

/** Light direction. */
var() vector	LightDirection2;

/** Base Height to use for scaling, all meshes are fit within this height. A value of < 0 means no auto scaling. */
var() float			BaseHeight;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=WidgetSKMesh ObjName=WidgetSKMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      Name="WidgetSKMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   SkeletalMeshComp=WidgetSKMesh
   Begin Object Class=DirectionalLightComponent Name=WidgetLight ObjName=WidgetLight Archetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
      Name="WidgetLight"
      ObjectArchetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
   End Object
   DefaultLight=WidgetLight
   LightDirection=(X=0.000000,Y=45.000000,Z=180.000000)
   Begin Object Class=DirectionalLightComponent Name=WidgetLight2 ObjName=WidgetLight2 Archetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
      Name="WidgetLight2"
      ObjectArchetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
   End Object
   DefaultLight2=WidgetLight2
   LightDirection2=(X=0.000000,Y=-45.000000,Z=180.000000)
   BaseHeight=-1.000000
   Begin Object Class=StaticMeshComponent Name=WidgetMesh ObjName=WidgetMesh Archetype=StaticMeshComponent'Engine.Default__UIMeshWidget:WidgetMesh'
      ObjectArchetype=StaticMeshComponent'Engine.Default__UIMeshWidget:WidgetMesh'
   End Object
   Mesh=WidgetMesh
   bDebugShowBounds=False
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIMeshWidget:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIMeshWidget:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIMeshWidget"
   ObjectArchetype=UIMeshWidget'Engine.Default__UIMeshWidget'
}
