/**
 * This event is activated when a widget enters a new state.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIEvent_OnEnterState extends UIEvent_State
	native(inherit);

defaultproperties
{
   Description="Activated whenever a widget enters a new menu state, such as disabled or focused"
   ObjPosX=424
   ObjPosY=216
   ObjName="Enter State"
   Name="Default__UIEvent_OnEnterState"
   ObjectArchetype=UIEvent_State'Engine.Default__UIEvent_State'
}
