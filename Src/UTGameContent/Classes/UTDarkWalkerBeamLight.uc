/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTDarkWalkerBeamLight extends Actor;

var() PointLightComponent BeamLight;
var() AudioComponent AmbientSound;

defaultproperties
{
   Begin Object Class=PointLightComponent Name=LightComponentB ObjName=LightComponentB Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=300.000000
      Brightness=10.000000
      LightColor=(B=64,G=128,R=255,A=255)
      CastShadows=False
      Name="LightComponentB"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   BeamLight=LightComponentB
   Begin Object Class=AudioComponent Name=ImpactSound ObjName=ImpactSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FireBeamRipEarthCue'
      Name="ImpactSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AmbientSound=ImpactSound
   Components(0)=LightComponentB
   Components(1)=ImpactSound
   bGameRelevant=True
   Name="Default__UTDarkWalkerBeamLight"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
