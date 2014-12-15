/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleDeathPiece extends UTGib_Vehicle
	notplaceable;


var ParticleSystemComponent PSC;

/** We need to skip the UTGib_Vehicle PreBeginPlay because UTGib_Vehicle tries to ChooseGib which we don't want to do **/
simulated event PreBeginPlay()
{
	Super(Actor).PreBeginPlay();
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=Particles ObjName=Particles Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SpecialCase_1_Attach'
      Name="Particles"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   PSC=Particles
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Vehicle:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   Begin Object Class=UTGibStaticMeshComponent Name=VehicleGibStaticMeshComp ObjName=VehicleGibStaticMeshComp Archetype=UTGibStaticMeshComponent'UTGame.Default__UTGibStaticMeshComponent'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicleDeathPiece:GibLightEnvironmentComp'
      CachedCullDistance=8000.000000
      ScriptRigidBodyCollisionThreshold=1.000000
      Name="VehicleGibStaticMeshComp"
      ObjectArchetype=UTGibStaticMeshComponent'UTGame.Default__UTGibStaticMeshComponent'
   End Object
   GibMeshComp=VehicleGibStaticMeshComp
   Components(0)=GibLightEnvironmentComp
   Components(1)=VehicleGibStaticMeshComp
   Components(2)=Particles
   CollisionComponent=VehicleGibStaticMeshComp
   Name="Default__UTVehicleDeathPiece"
   ObjectArchetype=UTGib_Vehicle'UTGame.Default__UTGib_Vehicle'
}
