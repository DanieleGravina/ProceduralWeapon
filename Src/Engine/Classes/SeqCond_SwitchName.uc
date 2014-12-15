/**
 * Base class for all switch condition ops which use a name value for branching.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class SeqCond_SwitchName extends SeqCond_SwitchBase
	native(inherit)
	abstract;

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

/** Stores class name to compare for each output link and whether it should fall through to next node */
struct native SwitchNameCase
{
	/** the value of this case statement */
	var() Name NameValue;

	/** indicates whether control should fall through to the next case upon a match*/
	var() bool bFallThru;
};

/**
 * Stores the list of values which are handled by this switch object.
 */
var() array<SwitchNameCase> SupportedValues;

/* === Events === */
/**
 * Ensures that the last item in the value array represents the "default" item.  Child classes should override this method to ensure that
 * their value array stays synchronized with the OutputLinks array.
 */
event VerifyDefaultCaseValue()
{
	Super.VerifyDefaultCaseValue();

	SupportedValues.Length = OutputLinks.Length;
	SupportedValues[SupportedValues.Length-1].NameValue = 'Default';
	SupportedValues[SupportedValues.Length-1].bFallThru = false;
}

/**
 * Returns whether fall through is enabled for the specified case value.
 */
event bool IsFallThruEnabled( int ValueIndex )
{
	// by default, fall thru is not enabled on anything
	return ValueIndex >= 0 && ValueIndex < SupportedValues.Length && SupportedValues[ValueIndex].bFallThru;
}

/**
 * Insert an empty element into this switch's value array at the specified index.
 */
event InsertValueEntry( int InsertIndex )
{
	InsertIndex = Clamp(InsertIndex, 0, SupportedValues.Length);

	SupportedValues.Insert(InsertIndex, 1);
}

/**
 * Remove an element from this switch's value array at the specified index.
 */
event RemoveValueEntry( int RemoveIndex )
{
	if ( RemoveIndex >= 0 && RemoveIndex < SupportedValues.Length )
	{
		SupportedValues.Remove(RemoveIndex, 1);
	}
}

defaultproperties
{
   SupportedValues(0)=(NameValue="Default")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Name',LinkDesc="Name Value",MinVars=1,MaxVars=255)
   ObjName="Switch Name"
   Name="Default__SeqCond_SwitchName"
   ObjectArchetype=SeqCond_SwitchBase'Engine.Default__SeqCond_SwitchBase'
}
