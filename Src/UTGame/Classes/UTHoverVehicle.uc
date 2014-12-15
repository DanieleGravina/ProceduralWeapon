/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTHoverVehicle extends UTVehicle
	native(Vehicle)
	abstract;

/** indicies into VehicleEffects array of ground effects that have their 'DistToGround' parameter set via C++ */
var array<int> GroundEffectIndices;
/** maximum distance vehicle must be from the ground for ground effects to be displayed */
var float MaxGroundEffectDist;
/** particle parameter for the ground effect, set to the ground distance divided by MaxGroundEffectDist (so 0.0 to 1.0) */
var name GroundEffectDistParameterName;
/** Effect to switch to when over water. */
var ParticleSystem	WaterGroundEffect;

/** scaling factor for this hover vehicle's gravity - used in GetGravityZ() */
var(Movement) float CustomGravityScaling;

/** scaling factor for this hover vehicle's gravity when above StallZ */
var(Movement) float StallZGravityScaling;

/** max speed */
var(Movement) float FullAirSpeed;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if (bNetDirty && Role == ROLE_Authority)
		CustomGravityScaling;
}

/**
 * Call this function to blow up the vehicle
 */
simulated function BlowupVehicle()
{
	Super.BlowupVehicle();
	CustomGravityScaling= 1.0;
	if ( UTVehicleSimHover(SimObj) != None )
	{
		UTVehicleSimHover(SimObj).bDisableWheelsWhenOff = true;
	}
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local class<UTDamageType> UTDT;
	
	if ( !bCanFly )
	{
	  UTDT = class<UTDamageType>(DamageType);
	  if ( UTDT != None )
	  {
		  if ( (class<UTDmgType_FlakShard>(UTDT) != None)
				  || (class<UTDmgType_Rocket>(UTDT) != None)
				  || (class<UTDmgType_ShockPrimary>(UTDT) != None) )
		  {
			  Damage *= 1.2;
		  }
	  }
	}
	super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}

defaultproperties
{
   MaxGroundEffectDist=256.000000
   GroundEffectDistParameterName="DistToGround"
   CustomGravityScaling=1.000000
   StallZGravityScaling=1.000000
   bNoZSmoothing=False
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   CollisionDamageMult=0.000800
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
   bCanBeBaseForPawns=False
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   CollisionComponent=SVehicleMesh
   Name="Default__UTHoverVehicle"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
