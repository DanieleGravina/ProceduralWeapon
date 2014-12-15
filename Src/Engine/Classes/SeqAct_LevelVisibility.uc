/**
 * SeqAct_LevelVisibility
 *
 * Kismet action exposing associating/ dissociating of levels.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_LevelVisibility extends SeqAct_Latent
	native(Sequence);

/** LevelStreaming object that is going to be associated/ dissociated on request */
var() LevelStreaming Level;

/** LevelStreaming object name */
var() Name LevelName;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   InputLinks(0)=(LinkDesc="Make Visible")
   InputLinks(1)=(LinkDesc="Hide")
   ObjName="Change Level Visibility"
   ObjCategory="Level"
   Name="Default__SeqAct_LevelVisibility"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
