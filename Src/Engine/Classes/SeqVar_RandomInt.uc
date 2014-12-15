/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqVar_RandomInt extends SeqVar_Int
	native(Sequence);

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

/** Min value for randomness */
var() int Min;

/** Max value for randomness */
var() int Max;

defaultproperties
{
   Max=100
   ObjName="Random Int"
   Name="Default__SeqVar_RandomInt"
   ObjectArchetype=SeqVar_Int'Engine.Default__SeqVar_Int'
}
