/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTGib_ScorpionHatch extends UTGib_Vehicle;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   Begin Object Class=UTGibStaticMeshComponent Name=GibStaticMeshComp ObjName=GibStaticMeshComp Archetype=UTGibStaticMeshComponent'UTGame.Default__UTGibStaticMeshComponent'
      StaticMesh=StaticMesh'FX_VehicleExplosions.ScorpionParts.S_FX_ScorpionCanopy'
      CachedCullDistance=8000.000000
      Name="GibStaticMeshComp"
      ObjectArchetype=UTGibStaticMeshComponent'UTGame.Default__UTGibStaticMeshComponent'
   End Object
   GibMeshComp=GibStaticMeshComp
   Components(0)=GibLightEnvironmentComp
   Components(1)=GibStaticMeshComp
   CollisionComponent=GibStaticMeshComp
   Name="Default__UTGib_ScorpionHatch"
   ObjectArchetype=UTGib_Vehicle'UTGame.Default__UTGib_Vehicle'
}
