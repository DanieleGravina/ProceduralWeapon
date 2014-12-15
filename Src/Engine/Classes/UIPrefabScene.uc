/**
 * This is a special type of scene used for allowing UIPrefabs to be opened for edit in the UI editor.  It is created
 * on demand and is never saved into a package.  It only allows a single child widget to be added which must be a
 * UIPrefab object.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIPrefabScene extends UIScene
	native(UIPrivate)
	transient
	inherits(FCallbackEventDevice)
	notplaceable;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'Engine.Default__UIScene:SceneEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIScene:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UIPrefabScene"
   ObjectArchetype=UIScene'Engine.Default__UIScene'
}
