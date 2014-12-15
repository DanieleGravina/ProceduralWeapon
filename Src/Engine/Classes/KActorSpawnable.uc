/**
 * Version of KActor that can be dynamically spawned and destroyed during gameplay
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 **/
class KActorSpawnable extends KActor
	native(Physics)
	notplaceable;

simulated function Initialize()
{
	SetHidden(FALSE);
	StaticMeshComponent.SetHidden(FALSE);
	SetPhysics(PHYS_RigidBody);
	SetCollision(true, false);
}

simulated function Recycle()
{
	SetHidden(TRUE);
	StaticMeshComponent.SetHidden(TRUE);
	SetPhysics(PHYS_None);
	SetCollision(false, false);
	ClearTimer('Recycle');
}

/** Used when the actor is pulled from a cache for use. */
native function ResetComponents();

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__KActor:StaticMeshComponent0'
      ObjectArchetype=StaticMeshComponent'Engine.Default__KActor:StaticMeshComponent0'
   End Object
   StaticMeshComponent=StaticMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__KActor:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__KActor:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Components(0)=MyLightEnvironment
   Components(1)=StaticMeshComponent0
   bNoDelete=False
   CollisionComponent=StaticMeshComponent0
   Name="Default__KActorSpawnable"
   ObjectArchetype=KActor'Engine.Default__KActor'
}
