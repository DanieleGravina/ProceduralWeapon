/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_GetProperty extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Name of property to search for */
var() Name PropertyName;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Object",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Int",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Float",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="String",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Bool",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get Property"
   ObjCategory="Object Property"
   Name="Default__SeqAct_GetProperty"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
