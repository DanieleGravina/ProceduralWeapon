/**
 * This class allows the designer to play a sound cue using a UISoundCue alias name.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_PlayUISoundCue extends UIAction
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()		string			SoundCueName;

defaultproperties
{
   bAutoTargetOwner=True
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failure")
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Cue Name",PropertyName="SoundCueName",MinVars=1,MaxVars=255)
   ObjName="Play UI Sound Cue"
   ObjCategory="Sound"
   Name="Default__UIAction_PlayUISoundCue"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
