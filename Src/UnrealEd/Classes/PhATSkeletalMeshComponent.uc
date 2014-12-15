/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PhATSkeletalMeshComponent extends SkeletalMeshComponent
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var transient native const pointer	PhATPtr;

/** Mesh-space matrices showing state of just animation (ie before physics) - useful for debugging! */
var transient native const array<matrix>	AnimationSpaceBases;

defaultproperties
{
   Begin Object Class=AnimNodeSequence Name=AnimNodeSeq0 ObjName=AnimNodeSeq0 Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      bLooping=True
      Name="AnimNodeSeq0"
      ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
   End Object
   Animations=AnimNodeSequence'UnrealEd.Default__PhATSkeletalMeshComponent:AnimNodeSeq0'
   PhysicsWeight=1.000000
   ForcedLodModel=1
   bHasPhysicsAssetInstance=True
   bUpdateJointsFromAnimation=True
   RBCollideWithChannels=(Default=True)
   Name="Default__PhATSkeletalMeshComponent"
   ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
}
