/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGib_VehiclePiece extends UTGib_Vehicle
	notplaceable;


simulated event PreBeginPlay()
{
	// we skip UTGib as UTGib will do ChooseGib().  For the VehiclePieces we know they are only StaticMeshes 
	// and that StaticMesh is stored in the SkelControl_Damage so when we spawn one of these we call SetGibStaticMesh( Mesh )
	Super(Actor).PreBeginPlay();
}

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_VehiclePiece"
   ObjectArchetype=UTGib_Vehicle'UTGame.Default__UTGib_Vehicle'
}
