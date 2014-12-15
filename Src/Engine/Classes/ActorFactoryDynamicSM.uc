/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryDynamicSM extends ActorFactory
	config(Editor)
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

var()	StaticMesh		StaticMesh;
var()	vector			DrawScale3D;
var()	bool			bNoEncroachCheck;
var()	bool			bNotifyRigidBodyCollision;
var()	ECollisionType		CollisionType;

/** Try and use physics hardware for this spawned object. */
var()	bool			bUseCompartment;

/** If false, primitive does not cast dynamic shadows. */
var()	bool			bCastDynamicShadow;

defaultproperties
{
   DrawScale3D=(X=1.000000,Y=1.000000,Z=1.000000)
   bCastDynamicShadow=True
   CollisionType=COLLIDE_NoCollision
   Name="Default__ActorFactoryDynamicSM"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
