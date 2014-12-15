/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class InterpTrackInstSound extends InterpTrackInst
	native(Interpolation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var	float						LastUpdatePosition; 
var	transient AudioComponent	PlayAudioComp;

defaultproperties
{
   Name="Default__InterpTrackInstSound"
   ObjectArchetype=InterpTrackInst'Engine.Default__InterpTrackInst'
}
