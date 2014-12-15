/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_GetVelocity extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() editconst float Velocity;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Velocity",PropertyName="Velocity",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get Velocity"
   ObjCategory="Actor"
   Name="Default__SeqAct_GetVelocity"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
