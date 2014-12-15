/**
 * SeqAct_PrepareMapChange
 *
 * Kismet action exposing kicking off async map changes
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_PrepareMapChange extends SeqAct_Latent
	native(Sequence);

/** The main level that should be transitioned to.										*/
var() name			MainLevelName;

/** Additional secondary levels that should be pre-loaded before the switcheroo.		*/
var() array<name>	InitiallyLoadedSecondaryLevelNames;

/** If this is TRUE, then a much larger time slice will be given to the loading code (useful for loading during a movie, etc) */
var() bool			bIsHighPriority;

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

defaultproperties
{
   InputLinks(0)=(LinkDesc="PrepareLoad")
   ObjName="Prepare Map Change"
   ObjCategory="Level"
   Name="Default__SeqAct_PrepareMapChange"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
