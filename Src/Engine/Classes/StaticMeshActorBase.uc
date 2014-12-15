/**
 * Base class for static actors which contain StaticMeshComponents.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class StaticMeshActorBase extends Actor
	native
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bStatic=True
   bWorldGeometry=True
   bRouteBeginPlayEvenIfStatic=False
   bGameRelevant=True
   bMovable=False
   bCollideActors=True
   bBlockActors=True
   bEdShouldSnap=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__StaticMeshActorBase"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
