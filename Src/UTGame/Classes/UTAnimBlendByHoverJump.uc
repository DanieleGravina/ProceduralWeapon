/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAnimBlendByHoverJump extends UTAnimBlendByFall
	Native(Animation);

var const transient Pawn	OwnerP;
var const transient UTHoverVehicle OwnerHV;
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bIgnoreDoubleJumps=True
   Name="Default__UTAnimBlendByHoverJump"
   ObjectArchetype=UTAnimBlendByFall'UTGame.Default__UTAnimBlendByFall'
}
