/*=============================================================================
	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
=============================================================================*/
 
class SpeedTree extends Object
	native(SpeedTree);
	
/** Helper object to allow SpeedTree to be script exposed.										*/
var duplicatetransient native const pointer	SRH{class FSpeedTreeResourceHelper};

// Editor-accesible variables

/** Random seed for tree creation.																*/
var() int							RandomSeed;						
/** Sink the tree partially underground.														*/
var() float							Sink;

/** The probability of a shadow ray being blocked by the leaf material. */
var(Lighting) float LeafStaticShadowOpacity;

/** Branch material.																			*/
var(Material) MaterialInterface		BranchMaterial;
/** Frond material.																				*/
var(Material) MaterialInterface		FrondMaterial;
/** Leaf material.																				*/
var(Material) MaterialInterface		LeafMaterial;
/** Billboard material.																			*/
var(Material) MaterialInterface		BillboardMaterial;

// SpeedWind variables (explained in the SpeedTreeCAD documentation)
var(Wind) float						MaxBendAngle;
var(Wind) float						BranchExponent;
var(Wind) float						LeafExponent;
var(Wind) float						Response;
var(Wind) float						ResponseLimiter;
var(Wind) float						Gusting_MinStrength;
var(Wind) float						Gusting_MaxStrength;
var(Wind) float						Gusting_Frequency;
var(Wind) float						Gusting_MinDuration;
var(Wind) float						Gusting_MaxDuration;
var(Wind) float						BranchHorizontal_LowWindAngle;
var(Wind) float						BranchHorizontal_LowWindSpeed;
var(Wind) float						BranchHorizontal_HighWindAngle;
var(Wind) float						BranchHorizontal_HighWindSpeed;
var(Wind) float						BranchVertical_LowWindAngle;
var(Wind) float						BranchVertical_LowWindSpeed;
var(Wind) float						BranchVertical_HighWindAngle;
var(Wind) float						BranchVertical_HighWindSpeed;
var(Wind) float						LeafRocking_LowWindAngle;
var(Wind) float						LeafRocking_LowWindSpeed;
var(Wind) float						LeafRocking_HighWindAngle;
var(Wind) float						LeafRocking_HighWindSpeed;
var(Wind) float						LeafRustling_LowWindAngle;
var(Wind) float						LeafRustling_LowWindSpeed;
var(Wind) float						LeafRustling_HighWindAngle;
var(Wind) float						LeafRustling_HighWindSpeed;

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
   RandomSeed=1
   LeafStaticShadowOpacity=0.500000
   MaxBendAngle=35.000000
   BranchExponent=1.000000
   LeafExponent=1.000000
   Response=0.100000
   ResponseLimiter=0.010000
   Gusting_MinStrength=0.250000
   Gusting_MaxStrength=1.250000
   Gusting_Frequency=0.400000
   Gusting_MinDuration=2.000000
   Gusting_MaxDuration=15.000000
   BranchHorizontal_LowWindAngle=3.000000
   BranchHorizontal_LowWindSpeed=1.500000
   BranchHorizontal_HighWindAngle=3.000000
   BranchHorizontal_HighWindSpeed=1.500000
   BranchVertical_LowWindAngle=4.000000
   BranchVertical_LowWindSpeed=2.000000
   BranchVertical_HighWindAngle=4.000000
   BranchVertical_HighWindSpeed=2.000000
   LeafRocking_LowWindAngle=5.000000
   LeafRocking_LowWindSpeed=1.000000
   LeafRocking_HighWindAngle=5.000000
   LeafRocking_HighWindSpeed=3.000000
   LeafRustling_LowWindAngle=7.000000
   LeafRustling_LowWindSpeed=0.100000
   LeafRustling_HighWindAngle=5.000000
   LeafRustling_HighWindSpeed=15.000000
   Name="Default__SpeedTree"
   ObjectArchetype=Object'Core.Default__Object'
}
