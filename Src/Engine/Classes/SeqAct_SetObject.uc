/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetObject extends SeqAct_SetSequenceVariable
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Default value to use if no variables are linked */
var() Object DefaultValue;

var Object Value;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Value",PropertyName="Value",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Object"
   Name="Default__SeqAct_SetObject"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
