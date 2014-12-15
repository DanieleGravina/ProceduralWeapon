/**
 * Changes the ControllerId for the player that owns the widgets in the targets array.  This action's logic is executed
 * by a handler function.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetControllerId extends UIAction;

defaultproperties
{
   bAutoTargetOwner=True
   VariableLinks(0)=(MaxVars=1)
   ObjName="Set Controller ID"
   ObjCategory="Player"
   Name="Default__UIAction_SetControllerId"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
