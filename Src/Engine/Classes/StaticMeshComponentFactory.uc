/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class StaticMeshComponentFactory extends MeshComponentFactory
	native
	hidecategories(Object)
	collapsecategories
	editinlinenew;

var() StaticMesh	StaticMesh;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   CollideActors=True
   BlockActors=True
   BlockZeroExtent=True
   BlockNonZeroExtent=True
   BlockRigidBody=True
   Name="Default__StaticMeshComponentFactory"
   ObjectArchetype=MeshComponentFactory'Engine.Default__MeshComponentFactory'
}
