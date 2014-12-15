/**
 * Activated when a new UITabPage becomes the ActivePage of a tab control.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIEvent_TabPageActivated extends UIEvent_TabControl;

defaultproperties
{
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Activated")
   OutputLinks(1)=(LinkDesc="Deactivated")
   ObjName="Page Activated"
   Name="Default__UIEvent_TabPageActivated"
   ObjectArchetype=UIEvent_TabControl'Engine.Default__UIEvent_TabControl'
}
