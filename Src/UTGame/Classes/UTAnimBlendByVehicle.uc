/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTAnimBlendByVehicle extends UTAnimBlendBase
	native(Animation);

var bool	  	bLastPawnDriving;
var Vehicle 	LastVehicle;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Force an update of the vehicle state now. */
native function UpdateVehicleState();

defaultproperties
{
   Children(0)=(Name="Default",Weight=1.000000)
   Children(1)=(Name="UTVehicle_Hoverboard")
   bFixNumChildren=True
   Name="Default__UTAnimBlendByVehicle"
   ObjectArchetype=UTAnimBlendBase'UTGame.Default__UTAnimBlendBase'
}
