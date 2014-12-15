/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_Delay extends SeqAct_Latent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Is this delay currently active? */
var const bool bDelayActive;

var const float DefaultDuration;

/** Default duration to use if no variables are linked */
var() float Duration;

/** Time at which this op was last updated, to prevent multiple updates per tick */
var const float LastUpdateTime;

/** Remaining time left on the duration */
var const float RemainingTime;

/**
 * Determines whether this class should be displayed in the list of available ops in the UI's kismet editor.
 *
 * @param	TargetObject	the widget that this SequenceObject would be attached to.
 *
 * @return	TRUE if this sequence object should be available for use in the UI kismet editor
 */
event bool IsValidUISequenceObject( optional UIScreenObject TargetObject )
{
	return true;
}

defaultproperties
{
   DefaultDuration=1.000000
   Duration=1.000000
   InputLinks(0)=(LinkDesc="Start")
   InputLinks(1)=(LinkDesc="Stop")
   InputLinks(2)=(LinkDesc="Pause")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Duration",PropertyName="Duration")
   ObjName="Delay"
   ObjCategory="Misc"
   Name="Default__SeqAct_Delay"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
