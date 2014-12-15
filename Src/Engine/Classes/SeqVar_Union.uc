/**
 * This class is used for linking variables of different types.  It contains a variable of each supported type and can
 * be connected to most types of variables links.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqVar_Union extends SequenceVariable
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * The list of sequence variable classes that are supported by SeqVar_Union
 */
var		array<class<SequenceVariable> >	SupportedVariableClasses;

var()	int			IntValue;
var()	int			BoolValue;
var()	float		FloatValue;
var()	string		StringValue;
var()	Object		ObjectValue;

defaultproperties
{
   SupportedVariableClasses(0)=Class'Engine.SeqVar_Bool'
   SupportedVariableClasses(1)=Class'Engine.SeqVar_Int'
   SupportedVariableClasses(2)=Class'Engine.SeqVar_Object'
   SupportedVariableClasses(3)=Class'Engine.SeqVar_String'
   SupportedVariableClasses(4)=Class'Engine.SeqVar_Float'
   ObjName="Union"
   ObjColor=(B=255,G=255,R=255,A=255)
   Name="Default__SeqVar_Union"
   ObjectArchetype=SequenceVariable'Engine.Default__SequenceVariable'
}
