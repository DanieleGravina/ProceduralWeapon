/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryVehicle extends ActorFactory
	config(Editor)
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() class<Vehicle>	VehicleClass;

defaultproperties
{
   VehicleClass=Class'Engine.Vehicle'
   bPlaceable=False
   Name="Default__ActorFactoryVehicle"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
