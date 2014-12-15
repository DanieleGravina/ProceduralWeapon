/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleTypeDataBeam2 extends ParticleModuleTypeDataBase
	native(Particle)
	editinlinenew
	dontcollapsecategories
	hidecategories(Object);

enum EBeam2Method
{
	PEB2M_Distance, 
    PEB2M_Target, 
	PEB2M_Branch
};

//*************************************************************************************************
// General Beam Variables
//*************************************************************************************************
/** The method with which to form the beam(s)												*/
var(Beam)									EBeam2Method				BeamMethod;

/** The number of times to tile the texture along each beam									*/
var(Beam)									int							TextureTile;

/** The distance per texture tile															*/
var(Beam)									float						TextureTileDistance;

/** The number of sheets to render															*/
var(Beam)									int							Sheets;

/** The number of live beams																*/
var(Beam)									int							MaxBeamCount;

/** The speed at which the beam should move from source to target when firing up.
 *	'0' indicates instantaneous
 */
var(Beam)									float						Speed;

/** 
 * Indicates whether the beam should be interpolated.
 *     <= 0 --> no
 *     >  0 --> yes (and is equal to the number of interpolation steps that should be taken.
 */
var(Beam)									int							InterpolationPoints;

/** If true, there will ALWAYS be a beam...													*/
var(Beam)									bool						bAlwaysOn;

//*************************************************************************************************
// Beam Branching Variables
//*************************************************************************************************
/** The name of the emitter to branch from (if mode is PEB2M_Branch)
 * MUST BE IN THE SAME PARTICLE SYSTEM!
 */
var(Branching)								name						BranchParentName;

//*************************************************************************************************
// Beam Distance Variables
//*************************************************************************************************
/** Distance is only used if BeamMethod is Distance											*/
var(Distance)								rawdistributionfloat			Distance;

//*************************************************************************************************
// Beam Multi-target Variables
//*************************************************************************************************
struct BeamTargetData
{
	/** Name of the target.																	*/
	var()	name		TargetName;
	/** Percentage chance the target will be selected (100 = always).						*/
	var()	float		TargetPercentage;
};

//*************************************************************************************************
// Beam Tapering Variables
//*************************************************************************************************
enum EBeamTaperMethod
{
	/** No tapering is applied																*/
	PEBTM_None, 
	/** Taper the beam relative to source-->target, regardless of current beam length		*/
	PEBTM_Full,
	/** Taper the beam relative to source-->location, 0=source,1=endpoint					*/
	PEBTM_Partial
};

/** Tapering mode																			*/
var(Taper)									EBeamTaperMethod			TaperMethod;

/** Tapering factor, 0 = source of beam, 1 = target											*/
var(Taper)									rawdistributionfloat		TaperFactor;

/**
 *  Tapering scaling
 *	This is intended to be either a constant, uniform or a ParticleParam.
 *	If a curve is used, 0/1 mapping of source/target... which could be integrated into
 *	the taper factor itself, and therefore makes no sense.
 */
var(Taper)									rawdistributionfloat		TaperScale;


//*************************************************************************************************
// Beam Rendering Variables
//*************************************************************************************************
var(Rendering)								bool						RenderGeometry;
var(Rendering)								bool						RenderDirectLine;
var(Rendering)								bool						RenderLines;
var(Rendering)								bool						RenderTessellation;

//*************************************************************************************************
// C++ Text
//*************************************************************************************************
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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

//*************************************************************************************************
// Default properties
//*************************************************************************************************

defaultproperties
{
   BeamMethod=PEB2M_Target
   TextureTile=1
   Sheets=1
   Speed=10.000000
   RenderGeometry=True
   Distance=(Distribution=DistributionDistance,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(25.000000,25.000000,25.000000,25.000000))
   TaperFactor=(Distribution=DistributionTaperFactor,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   TaperScale=(Distribution=DistributionTaperScale,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   Name="Default__ParticleModuleTypeDataBeam2"
   ObjectArchetype=ParticleModuleTypeDataBase'Engine.Default__ParticleModuleTypeDataBase'
}
