/**
 *	ParticleModuleUberLTISIVCLIL
 *
 *	Uber-module replacing the following classes:
 *		LT - Lifetime
 *		IS - Initial Size
 *		IV - Initial Velocity
 *		CL - Color over Life
 *      IL - Initial Location
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
 
class ParticleModuleUberLTISIVCLIL extends ParticleModuleUberBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

//------------------------------------------------------------------------------------------------
// Members
//------------------------------------------------------------------------------------------------
/** Lifetime - Gives the lifetime of the particles												*/
var(Lifetime)	export noclear		rawdistributionfloat		Lifetime;

/** Size - Gives the size of the particles														*/
var(Size)		export noclear		rawdistributionvector		StartSize;

/** StartVelociy - Gives the start velocity of the particles									*/
var(Velocity)	export noclear		rawdistributionvector		StartVelocity;
/** StartRadialVelociy - Gives the start radial velocity of the particles						*/
var(Velocity)	export noclear		rawdistributionfloat		StartVelocityRadial;

/** ColorOverLife - Gives the color to apply to the particles									*/
var(Color)		export noclear		rawdistributionvector		ColorOverLife;
/** AlphaOverLife - Gives the alpha to apply to the particles									*/
var(Color)		export noclear		rawdistributionfloat		AlphaOverLife;

/** StartLocation - Gives the start location of particles										*/
var(Location)	export noclear		rawdistributionvector		StartLocation;

//------------------------------------------------------------------------------------------------
// C++ Text
//------------------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------------------
// Default Properties
//------------------------------------------------------------------------------------------------

defaultproperties
{
   Lifetime=(Distribution=DistributionLifetime,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   StartSize=(Distribution=DistributionStartSize,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   StartVelocity=(Distribution=DistributionStartVelocity,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,10.000000,0.000000,0.000000,0.000000,0.000000,0.000000,10.000000,0.000000,0.000000,0.000000,0.000000,0.000000,10.000000))
   StartVelocityRadial=(Distribution=DistributionStartVelocityRadial,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   ColorOverLife=(Distribution=DistributionColorOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   AlphaOverLife=(Distribution=DistributionAlphaOverLife,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.899994,255.899994,255.899994,255.899994))
   StartLocation=(Distribution=DistributionStartLocation,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   RequiredModules(0)="ParticleModuleLifetime"
   RequiredModules(1)="ParticleModuleSize"
   RequiredModules(2)="ParticleModuleVelocity"
   RequiredModules(3)="ParticleModuleColorOverLife"
   RequiredModules(4)="ParticleModuleLocation"
   bSpawnModule=True
   bUpdateModule=True
   Name="Default__ParticleModuleUberLTISIVCLIL"
   ObjectArchetype=ParticleModuleUberBase'Engine.Default__ParticleModuleUberBase'
}
