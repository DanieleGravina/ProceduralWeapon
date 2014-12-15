/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqCond_GetServerType extends SequenceCondition
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   OutputLinks(0)=(LinkDesc="Standalone")
   OutputLinks(1)=(LinkDesc="Dedicated Server")
   OutputLinks(2)=(LinkDesc="Listen Server")
   ObjName="Server Type"
   Name="Default__SeqCond_GetServerType"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
