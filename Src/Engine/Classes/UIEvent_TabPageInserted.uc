/**
 * Class description
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIEvent_TabPageInserted extends UIEvent_TabControl;

/** the position [into the tab control's pages array] where this page was inserted */
var	int	InsertedIndex;

defaultproperties
{
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Page Location",PropertyName="InsertedIndex",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Page Added"
   Name="Default__UIEvent_TabPageInserted"
   ObjectArchetype=UIEvent_TabControl'Engine.Default__UIEvent_TabControl'
}
