/**
 * UI-specific version of the ConsoleCommand action, which is capable of automatically attaching to the owning widget.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_ConsoleCommand extends UIAction;

var() string Command;

defaultproperties
{
   bAutoTargetOwner=True
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Command",PropertyName="Command",MinVars=1,MaxVars=255)
   ObjName="Console Command"
   ObjCategory="Misc"
   Name="Default__UIAction_ConsoleCommand"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
