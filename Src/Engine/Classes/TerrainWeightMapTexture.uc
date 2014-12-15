/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class TerrainWeightMapTexture extends Texture2D
	native(Terrain)
	hidecategories(Object);

// Structs that are mirrored properly in C++.
struct TerrainWeightedMaterial
{
	// UObject references.
};

var const Terrain						ParentTerrain;
var private native const array<pointer>	WeightedMaterials{struct FTerrainWeightedMaterial};


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
   Name="Default__TerrainWeightMapTexture"
   ObjectArchetype=Texture2D'Engine.Default__Texture2D'
}
