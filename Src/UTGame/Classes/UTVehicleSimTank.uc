/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleSimTank extends SVehicleSimTank
	native(Vehicle);

/** When driving into something, reduce friction on the wheels. */
var()	float		FrontalCollisionGripFactor;

/** When no steering - How quickly to get tracks to same speed. */
var()	float		EqualiseTrackSpeed;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   FrontalCollisionGripFactor=1.000000
   Name="Default__UTVehicleSimTank"
   ObjectArchetype=SVehicleSimTank'Engine.Default__SVehicleSimTank'
}
