/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSpaceVolume extends UTWaterVolume;

simulated event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	super(PhysicsVolume).Touch(Other, OtherComp, HitLocation, HitNormal);
}

simulated function PlayEntrySplash(Actor Other)
{
}

defaultproperties
{
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'UTGame.Default__UTWaterVolume:BrushComponent0'
      ObjectArchetype=BrushComponent'UTGame.Default__UTWaterVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   CollisionComponent=BrushComponent0
   Name="Default__UTSpaceVolume"
   ObjectArchetype=UTWaterVolume'UTGame.Default__UTWaterVolume'
}
