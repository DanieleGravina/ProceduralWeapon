/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactorySkeletalMesh extends ActorFactory
	config(Editor)
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	SkeletalMesh	SkeletalMesh;
var()	AnimSet			AnimSet;
var()	name			AnimSequenceName;

defaultproperties
{
   GameplayActorClass=Class'Engine.SkeletalMeshActorSpawnable'
   MenuName="Add SkeletalMesh"
   NewActorClass=Class'Engine.SkeletalMeshActor'
   Name="Default__ActorFactorySkeletalMesh"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
