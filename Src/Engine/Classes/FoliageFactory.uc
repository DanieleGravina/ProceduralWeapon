/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FoliageFactory extends Volume
	native(Foliage)
	placeable;

struct native FoliageMesh
{
	var() StaticMesh InstanceStaticMesh;
	var() MaterialInterface Material;
	
	var() float MaxDrawRadius;
	var() float MinTransitionRadius;

	var() vector MinScale;
	var() vector MaxScale;

	var() float SwayScale;

	var() int Seed;

	var() float SurfaceAreaPerInstance;

	var() bool bCreateInstancesOnBSP;
	var() bool bCreateInstancesOnStaticMeshes;
	var() bool bCreateInstancesOnTerrain;

	var FoliageComponent Component;

	structdefaultproperties
	{
		MaxDrawRadius=2000

		MinScale=(X=1,Y=1,Z=1)
		MaxScale=(X=1,Y=1,Z=1)

		SwayScale=1.0

		SurfaceAreaPerInstance=1000

		bCreateInstancesOnBSP=TRUE
		bCreateInstancesOnStaticMeshes=TRUE
		bCreateInstancesOnTerrain=TRUE
	}
};

var(Foliage) const array<FoliageMesh> Meshes;

/** The radius inside/outside the volume that the foliage density falls off over. */
var(Foliage) const float VolumeFalloffRadius;

/** The exponent of the density falloff. */
var(Foliage) const float VolumeFalloffExponent;

/** The density of foliage instances on upward facing surfaces. */
var(Foliage) const float SurfaceDensityUpFacing;

/** The density of foliage instances on downward facing surfaces. */
var(Foliage) const float SurfaceDensityDownFacing;

/** The density of foliage instances on sideways facing surfaces. */
var(Foliage) const float SurfaceDensitySideFacing;

/** The falloff exponent for facing dependent density. */
var(Foliage) const float FacingFalloffExponent;

/** The maximum number of foliage instances to create from this factory. */
var(Foliage) const int MaxInstanceCount;

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

defaultproperties
{
   VolumeFalloffExponent=1.000000
   SurfaceDensityUpFacing=1.000000
   SurfaceDensityDownFacing=1.000000
   SurfaceDensitySideFacing=1.000000
   FacingFalloffExponent=2.000000
   MaxInstanceCount=10000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
      CollideActors=False
      BlockNonZeroExtent=False
      ObjectArchetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bHidden=False
   bMovable=False
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__FoliageFactory"
   ObjectArchetype=Volume'Engine.Default__Volume'
}
