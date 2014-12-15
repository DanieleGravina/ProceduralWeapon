/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTAnimBlendBySpeed extends AnimNodeBlend
	native(Animation);

/** minimum speed; at this or below the "Slow" anim is used completely */
var() float MinSpeed;
/** maximum speed; at this or above the "Fast" anim is used completely */
var() float MaxSpeed;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   MinSpeed=100.000000
   MaxSpeed=1000.000000
   Children(0)=(Name="Slow")
   Children(1)=(Name="Fast")
   Name="Default__UTAnimBlendBySpeed"
   ObjectArchetype=AnimNodeBlend'Engine.Default__AnimNodeBlend'
}
