/**
 *	ParticleModuleTrailTaper
 *	Trail taper module
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleTrailTaper extends ParticleModuleTrailBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

//*************************************************************************************************
// Trail Tapering Variables
//*************************************************************************************************
enum ETrailTaperMethod
{
	/** No tapering is applied																*/
	PETTM_None, 
	/** Taper the trail relative to source-->target, regardless of current beam length		*/
	PETTM_Full,
	/** Taper the trail relative to source-->location, 0=source,1=endpoint					*/
	PETTM_Partial
};

/** Tapering mode																			*/
var(Taper)									ETrailTaperMethod			TaperMethod;

/** Tapering factor, 0 = source of beam, 1 = target											*/
var(Taper)									rawdistributionfloat			TaperFactor;

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

//*************************************************************************************************
// Default properties
//*************************************************************************************************

defaultproperties
{
   TaperFactor=(Distribution=DistributionTaperFactor,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   Name="Default__ParticleModuleTrailTaper"
   ObjectArchetype=ParticleModuleTrailBase'Engine.Default__ParticleModuleTrailBase'
}
