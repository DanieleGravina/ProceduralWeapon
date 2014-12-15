/**
 * This event is activated when a widget leaves its current state.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIEvent_OnLeaveState extends UIEvent_State
	native(inherit);

defaultproperties
{
   Description="Activated whenever a widget leaves a menu state, such as disabled or focused"
   ObjPosX=424
   ObjPosY=384
   ObjName="Leave State"
   Name="Default__UIEvent_OnLeaveState"
   ObjectArchetype=UIEvent_State'Engine.Default__UIEvent_State'
}
