/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleSimHover extends UTVehicleSimChopper
	native(Vehicle);

var		bool	bDisableWheelsWhenOff;
var		bool	bRepulsorCollisionEnabled;
var		bool	bCanClimbSlopes;
var		bool	bUnPoweredDriving;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bDisableWheelsWhenOff=True
   bRepulsorCollisionEnabled=True
   Name="Default__UTVehicleSimHover"
   ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicleSimChopper'
}
