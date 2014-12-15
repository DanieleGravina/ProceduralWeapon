/**
 * Opens a new scene.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_OpenScene extends UIAction_Scene
	native(inherit);

/** Output variable for the scene that was opened. */
var	UIScene		OpenedScene;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Opened Scene",PropertyName="OpenedScene",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Open Scene"
   Name="Default__UIAction_OpenScene"
   ObjectArchetype=UIAction_Scene'Engine.Default__UIAction_Scene'
}
