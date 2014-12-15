/**
 * Class description
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIMeshWidget extends UIObject
	native(UIPrivate)
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

var()	const	editconst	StaticMeshComponent		Mesh;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=WidgetMesh ObjName=WidgetMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      Name="WidgetMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Mesh=WidgetMesh
   bSupportsPrimaryStyle=False
   bDebugShowBounds=True
   DebugBoundsColor=(B=64,G=0,R=128,A=255)
   bSupports3DPrimitives=True
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIMeshWidget"
   ObjectArchetype=UIObject'Engine.Default__UIObject'
}
