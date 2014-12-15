/**
 *	ParticleModuleUberRainSplashB
 *
 *	Uber-module replacing the following classes:
 *		LT  - Lifetime
 *		IS  - Initial Size
 *		COL - Color Over Life
 *		SBL	- Size By Life
 *		IRR	- Initial Rotation Rate
 *
 *	Intended for use in the Rain particle system.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
 
class ParticleModuleUberRainSplashB extends ParticleModuleUberBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

//*-----------------------------------------------------------------------------*/
/** Lifetime Module Members														*/
//*-----------------------------------------------------------------------------*/
var(Lifetime)	rawdistributionfloat		Lifetime;

//*-----------------------------------------------------------------------------*/
/** Size Module Members															*/
//*-----------------------------------------------------------------------------*/
var(Size)		rawdistributionvector		StartSize;

//*-----------------------------------------------------------------------------*/
/** ColorOverLife Module Members												*/
//*-----------------------------------------------------------------------------*/
var(Color)		rawdistributionvector		ColorOverLife;
var(Color)		rawdistributionfloat		AlphaOverLife;

//*-----------------------------------------------------------------------------*/
/** SizeByLife Module Members													*/
//*-----------------------------------------------------------------------------*/
var(Size)		rawdistributionvector		LifeMultiplier;
var(Size)		bool						MultiplyX;
var(Size)		bool						MultiplyY;
var(Size)		bool						MultiplyZ;

//*-----------------------------------------------------------------------------*/
/** Initial RotationRate Module Members											*/
//*-----------------------------------------------------------------------------*/
var(Rotation)	rawdistributionfloat		StartRotationRate;

//*-----------------------------------------------------------------------------*/
//*-----------------------------------------------------------------------------*/
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

//*-----------------------------------------------------------------------------*/
//*-----------------------------------------------------------------------------*/

defaultproperties
{
   Lifetime=(Distribution=DistributionLifetime,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   StartSize=(Distribution=DistributionStartSize,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   ColorOverLife=(Distribution=DistributionColorOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   AlphaOverLife=(Distribution=DistributionAlphaOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.899994,255.899994,255.899994,255.899994))
   LifeMultiplier=(Distribution=DistributionLifeMultiplier,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   MultiplyX=True
   MultiplyY=True
   MultiplyZ=True
   StartRotationRate=(Distribution=DistributionStartRotationRate,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.000000,0.000000,0.000000,0.000000))
   bSpawnModule=True
   bUpdateModule=True
   bSupported3DDrawMode=True
   Name="Default__ParticleModuleUberRainSplashB"
   ObjectArchetype=ParticleModuleUberBase'Engine.Default__ParticleModuleUberBase'
}
