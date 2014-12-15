/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 * This node blends in the 'Weapon' branch when anything other than the rifle is being used.
 */

class UTAnimBlendByWeapType extends AnimNodeBlendPerBone
	native(Animation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Children(0)=(Name="Default")
   Children(1)=(Name="Weapon")
   Name="Default__UTAnimBlendByWeapType"
   ObjectArchetype=AnimNodeBlendPerBone'Engine.Default__AnimNodeBlendPerBone'
}
