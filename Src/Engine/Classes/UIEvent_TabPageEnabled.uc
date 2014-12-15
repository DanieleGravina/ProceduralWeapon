/**
 * Activated when a tab page and tab button are enabled or disabled.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIEvent_TabPageEnabled extends UIEvent_TabControl;

defaultproperties
{
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Enabled")
   OutputLinks(1)=(LinkDesc="Disabled")
   ObjName="Page Enabled/Disabled"
   Name="Default__UIEvent_TabPageEnabled"
   ObjectArchetype=UIEvent_TabControl'Engine.Default__UIEvent_TabControl'
}
