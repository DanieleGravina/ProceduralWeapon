/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAnimBlendByHoverboardTurn extends AnimNodeBlendBase
	native(Animation);


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	float TurnScale;
var()	float MaxBlendPerSec;
var		float CurrentAnimWeight;

defaultproperties
{
   MaxBlendPerSec=1.000000
   Children(0)=(Name="Straight",Weight=1.000000)
   Children(1)=(Name="TurnLeft")
   Children(2)=(Name="TurnRight")
   bFixNumChildren=True
   Name="Default__UTAnimBlendByHoverboardTurn"
   ObjectArchetype=AnimNodeBlendBase'Engine.Default__AnimNodeBlendBase'
}
