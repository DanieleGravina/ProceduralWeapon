/**
 *	ParticleModuleUberRainImpacts
 *
 *	Uber-module replacing the following classes:
 *		LT  - Lifetime
 *		IS  - Initial Size
 *		IMR - Initial Mesh Rotation
 *		SBL - Size By Life
 *		PC	- Primitive Cylinder
 *		COL - Color Over Life
 *
 *	Intended for use in the Rain particle system.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
 
class ParticleModuleUberRainImpacts extends ParticleModuleUberBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

//*-----------------------------------------------------------------------------*/
/** Lifetime Module Members														*/
//*-----------------------------------------------------------------------------*/
var(Lifetime)		rawdistributionfloat	Lifetime;

//*-----------------------------------------------------------------------------*/
/** Size Module Members															*/
//*-----------------------------------------------------------------------------*/
var(Size)			rawdistributionvector	StartSize;

//*-----------------------------------------------------------------------------*/
/** MeshRotation Module Members													*/
//*-----------------------------------------------------------------------------*/
var(Rotation)		rawdistributionvector	StartRotation;
var(Rotation)		bool					bInheritParent;

//*-----------------------------------------------------------------------------*/
/** SizeByLife Module Members													*/
//*-----------------------------------------------------------------------------*/
var(Size)			rawdistributionvector	LifeMultiplier;
var(Size)			bool					MultiplyX;
var(Size)			bool					MultiplyY;
var(Size)			bool					MultiplyZ;

//*-----------------------------------------------------------------------------*/
/** PrimitiveCylinder Module Members											*/
//*-----------------------------------------------------------------------------*/
var(Location) 		bool					bIsUsingCylinder;
var(Location) 		bool					bPositive_X;
var(Location) 		bool					bPositive_Y;
var(Location) 		bool					bPositive_Z;
var(Location) 		bool					bNegative_X;
var(Location) 		bool					bNegative_Y;
var(Location) 		bool					bNegative_Z;
var(Location) 		bool					bSurfaceOnly;
var(Location) 		bool					bVelocity;
var(Location) 		rawdistributionfloat	PC_VelocityScale;
var(Location) 		rawdistributionvector	PC_StartLocation;
var(Location) 		bool					bRadialVelocity;
var(Location) 		rawdistributionfloat	PC_StartRadius;
var(Location) 		rawdistributionfloat	PC_StartHeight;
var(Location)		CylinderHeightAxis		PC_HeightAxis;

//*-----------------------------------------------------------------------------*/
/** ColorOverLife Module Members												*/
//*-----------------------------------------------------------------------------*/
var(Color)			rawdistributionvector	ColorOverLife;
var(Color)			rawdistributionfloat	AlphaOverLife;

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
   StartRotation=(Distribution=DistributionStartRotation,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,360.000000,0.000000,0.000000,0.000000,360.000000,360.000000,360.000000,0.000000,0.000000,0.000000,360.000000,360.000000,360.000000))
   MultiplyX=True
   MultiplyY=True
   MultiplyZ=True
   bIsUsingCylinder=True
   bPositive_X=True
   bPositive_Y=True
   bPositive_Z=True
   bNegative_X=True
   bNegative_Y=True
   bNegative_Z=True
   bRadialVelocity=True
   LifeMultiplier=(Distribution=DistributionLifeMultiplier,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   PC_VelocityScale=(Distribution=DistributionPC_VelocityScale,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   PC_StartLocation=(Distribution=DistributionPC_StartLocation,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   PC_StartRadius=(Distribution=DistributionPC_StartRadius,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.000000,50.000000,50.000000,50.000000))
   PC_StartHeight=(Distribution=DistributionPC_StartHeight,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.000000,50.000000,50.000000,50.000000))
   PC_HeightAxis=PMLPC_HEIGHTAXIS_Z
   ColorOverLife=(Distribution=DistributionColorOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   AlphaOverLife=(Distribution=DistributionAlphaOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.899994,255.899994,255.899994,255.899994))
   bSpawnModule=True
   bUpdateModule=True
   bSupported3DDrawMode=True
   Name="Default__ParticleModuleUberRainImpacts"
   ObjectArchetype=ParticleModuleUberBase'Engine.Default__ParticleModuleUberBase'
}
