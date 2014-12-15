/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryPhysicsAsset extends ActorFactory
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

var()	PhysicsAsset		PhysicsAsset;
var()	SkeletalMesh		SkeletalMesh;

var()	bool				bStartAwake;
var()	bool				bDamageAppliesImpulse;
var()	bool				bNotifyRigidBodyCollision;
var()	vector				InitialVelocity;
var()	vector				DrawScale3D;

/** Try and use physics hardware for this spawned object. */
var()	bool	bUseCompartment;

/** If false, primitive does not cast dynamic shadows. */
var()	bool	bCastDynamicShadow;

// (cpptext)
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
   bStartAwake=True
   bDamageAppliesImpulse=True
   bCastDynamicShadow=True
   DrawScale3D=(X=1.000000,Y=1.000000,Z=1.000000)
   GameplayActorClass=Class'Engine.KAssetSpawnable'
   MenuName="Add PhysicsAsset"
   NewActorClass=Class'Engine.KAsset'
   Name="Default__ActorFactoryPhysicsAsset"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
