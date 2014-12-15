/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetMusicTrack extends SequenceAction
	dependson(SeqVar_MusicTrackBank)
	native(Sequence);


/** This is the track bank that should be used if there is one not attached **/
var() name TrackBankName;



// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   InputLinks(0)=(LinkDesc="Set Music Track")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_MusicTrackBank',LinkDesc="MusicTrackBank",bWriteable=True,MaxVars=1)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_MusicTrack',LinkDesc="MusicTrack",MinVars=1,MaxVars=1)
   ObjName="Set Music Track"
   ObjCategory="Sound"
   Name="Default__SeqAct_SetMusicTrack"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
