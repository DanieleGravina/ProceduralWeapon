/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class MorphTarget extends Object
	native(Anim)
	noexport
	hidecategories(Object);
	
/** morph mesh vertex data for each LOD */
var	const native array<int>		MorphLODModels; //FMorphTargetLODModel

defaultproperties
{
   Name="Default__MorphTarget"
   ObjectArchetype=Object'Core.Default__Object'
}
