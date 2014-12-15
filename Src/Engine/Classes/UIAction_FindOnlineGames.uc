/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This action creates an online game based upon the settings object that
 * is bound to the UI widget
 */
class UIAction_FindOnlineGames extends UIAction
	native(inherit);

/** The datastore to perform the search on */
var() name DataStoreName;

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
   ObjName="Find Online Games"
   ObjCategory="Online"
   Name="Default__UIAction_FindOnlineGames"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
