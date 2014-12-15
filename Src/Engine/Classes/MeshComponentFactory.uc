/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class MeshComponentFactory extends PrimitiveComponentFactory
	native
	abstract;

var(Rendering) array<MaterialInterface>	Materials;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   CastShadow=True
   Name="Default__MeshComponentFactory"
   ObjectArchetype=PrimitiveComponentFactory'Engine.Default__PrimitiveComponentFactory'
}
