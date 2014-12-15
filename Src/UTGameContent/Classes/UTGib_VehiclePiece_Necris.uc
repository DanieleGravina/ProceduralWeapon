/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_VehiclePiece_Necris extends UTGib_VehiclePiece;

defaultproperties
{
   LoopedSound=SoundCue'A_Vehicle_Generic.Fire.VehicleTechDerbisLoop_Cue'
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_VehiclePiece:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_VehiclePiece:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_VehiclePiece_Necris"
   ObjectArchetype=UTGib_VehiclePiece'UTGame.Default__UTGib_VehiclePiece'
}
