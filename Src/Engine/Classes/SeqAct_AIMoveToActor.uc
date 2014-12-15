/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_AIMoveToActor extends SeqAct_Latent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Should this move be interruptable? */
var() bool bInterruptable;

defaultproperties
{
   OutputLinks(2)=(LinkDesc="Out")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Destination",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Look At",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Move To Actor (Latent)"
   ObjCategory="AI"
   Name="Default__SeqAct_AIMoveToActor"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
