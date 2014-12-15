/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_ToggleDynamicChannel extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   InputLinks(0)=(LinkDesc="Turn On")
   InputLinks(1)=(LinkDesc="Turn Off")
   InputLinks(2)=(LinkDesc="Toggle")
   VariableLinks(0)=(LinkDesc="Light",PropertyName=)
   ObjName="Toggle Dynamic Channel"
   ObjCategory="Toggle"
   Name="Default__SeqAct_ToggleDynamicChannel"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
