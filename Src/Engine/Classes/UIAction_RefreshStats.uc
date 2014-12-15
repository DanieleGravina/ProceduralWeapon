/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This action tells the stats data store to resubmit its read request
 */
class UIAction_RefreshStats extends UIAction
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
   ObjName="Refresh Stats"
   ObjCategory="Online"
   Name="Default__UIAction_RefreshStats"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
