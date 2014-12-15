/**
 * SeqAct_MultiLevelStreaming
 *
 * Kismet action exposing loading and unloading of multiple levels at once.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_MultiLevelStreaming extends SeqAct_LevelStreamingBase
	native(Sequence);

struct native LevelStreamingNameCombo
{
	/** Cached LevelStreaming object that is going to be loaded/ unloaded on request.	*/
	var		const LevelStreaming		Level;
	/** LevelStreaming object name.														*/
	var()	const Name					LevelName;
};

/** Array of levels to load/ unload														*/
var() array<LevelStreamingNameCombo>	Levels;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   ObjName="Stream Multiple Levels"
   Name="Default__SeqAct_MultiLevelStreaming"
   ObjectArchetype=SeqAct_LevelStreamingBase'Engine.Default__SeqAct_LevelStreamingBase'
}
