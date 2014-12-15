/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTFuryBeamLight extends UTDarkWalkerBeamLight;

defaultproperties
{
   Begin Object Class=PointLightComponent Name=LightComponentB ObjName=LightComponentB Archetype=PointLightComponent'UTGameContent.Default__UTDarkWalkerBeamLight:LightComponentB'
      LightColor=(B=16,G=160,R=255,A=128)
      ObjectArchetype=PointLightComponent'UTGameContent.Default__UTDarkWalkerBeamLight:LightComponentB'
   End Object
   BeamLight=LightComponentB
   Begin Object Class=AudioComponent Name=ImpactSound ObjName=ImpactSound Archetype=AudioComponent'UTGameContent.Default__UTDarkWalkerBeamLight:ImpactSound'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTDarkWalkerBeamLight:ImpactSound'
   End Object
   AmbientSound=ImpactSound
   Components(0)=LightComponentB
   Components(1)=ImpactSound
   Name="Default__UTFuryBeamLight"
   ObjectArchetype=UTDarkWalkerBeamLight'UTGameContent.Default__UTDarkWalkerBeamLight'
}
