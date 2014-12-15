/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This action creates an online game based upon the settings object that
 * is bound to the UI widget
 */
class UIAction_CreateOnlineGame extends UIAction
	native(inherit);

/** The datastore to call create on */
var() name DataStoreName;

/** Map to load before starting the online game, if blank, no map will be loaded. */
var() string MapName;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bAutoTargetOwner=True
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Failure")
   OutputLinks(1)=(LinkDesc="Success")
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Map Name",PropertyName="MapName",MinVars=1,MaxVars=255)
   ObjName="Create Online Game"
   ObjCategory="Online"
   Name="Default__UIAction_CreateOnlineGame"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
