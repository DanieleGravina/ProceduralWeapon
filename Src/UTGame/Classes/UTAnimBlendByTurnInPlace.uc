/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAnimBlendByTurnInPlace extends UTAnimBlendBase
	native(Animation);

var() float	RootYawSpeedThresh;
var() float TurnInPlaceBlendSpeed;
var const transient UTPawn OwnerUTP;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Children(0)=(Name="Idle",Weight=1.000000)
   Children(1)=(Name="TurnInPlace")
   bFixNumChildren=True
   Name="Default__UTAnimBlendByTurnInPlace"
   ObjectArchetype=UTAnimBlendBase'UTGame.Default__UTAnimBlendBase'
}
