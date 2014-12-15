/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTAnimBlendByDriving extends AnimNodeBlend
	native(Animation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Force an update of the driving state now. */
native function UpdateDrivingState();

defaultproperties
{
   Children(0)=(Name="Not-Driving")
   Children(1)=(Name="DRIVING")
   Name="Default__UTAnimBlendByDriving"
   ObjectArchetype=AnimNodeBlend'Engine.Default__AnimNodeBlend'
}
