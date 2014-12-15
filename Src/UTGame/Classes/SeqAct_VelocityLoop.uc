/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_VelocityLoop extends SeqAct_Latent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() SoundCue LoopSound;

var bool bPlayingSound;

var transient float TotalVelocity;
var transient array<Actor> SoundSources;

defaultproperties
{
   InputLinks(0)=(LinkDesc="Start")
   InputLinks(1)=(LinkDesc="Stop")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Velocity",MinVars=1,MaxVars=255)
   ObjName="Velocity Loop"
   ObjCategory="DemoGame"
   Name="Default__SeqAct_VelocityLoop"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
