/**
 * This class allows designers to manipulate UIRangeData values.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqVar_UIRange extends SequenceVariable
	native(UISequence);

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

/**
 * The value associated with this sequence variable.
 */
var()	UIRoot.UIRangeData	RangeValue;

/**
 * Determines whether this class should be displayed in the list of available ops in the level kismet editor.
 *
 * @return	TRUE if this sequence object should be available for use in the level kismet editor
 */
event bool IsValidLevelSequenceObject()
{
	return false;
}

defaultproperties
{
   ObjName="UI Range"
   ObjCategory="UI"
   ObjColor=(B=192,G=128,R=128,A=255)
   Name="Default__SeqVar_UIRange"
   ObjectArchetype=SequenceVariable'Engine.Default__SequenceVariable'
}
