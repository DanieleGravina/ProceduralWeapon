/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This action shows the gamercard of the player that create the online game
 * that is currently selected in the UI list
 */
class UIAction_ShowGamercardForServerHost extends UIAction
	native(inherit);

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
   ObjName="Show Server Gamercard"
   ObjCategory="Online"
   Name="Default__UIAction_ShowGamercardForServerHost"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
