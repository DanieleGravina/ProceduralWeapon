/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class MorphNodeWeight extends MorphNodeWeightBase
	native(Anim)
	hidecategories(Object);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
 
/** Weight to apply to all child nodes of this one. */
var		float	NodeWeight;


/** 
 *	Change the current NodeWeight of this MorphNodeWeight.
 */
native function		SetNodeWeight(float NewWeight);

defaultproperties
{
   NodeConns(0)=(ConnName="In")
   bDrawSlider=True
   Name="Default__MorphNodeWeight"
   ObjectArchetype=MorphNodeWeightBase'Engine.Default__MorphNodeWeightBase'
}
