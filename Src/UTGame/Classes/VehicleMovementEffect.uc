//=============================================================================
// VehicleMovementEffect
//  Is the visual effect that is spawned by someone on a vehicle
//  
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class VehicleMovementEffect extends Actor
	native(Vehicle);

/** The static mesh that can be used as a speed effect*/
var staticmeshcomponent AirEffect;
/** slower than this will disable the effect*/
var float MinVelocityForAirEffect;
/** At this speed the air effect is at full level */
var float MaxVelocityForAirEffect;
/** the param in the material(0) of the AirEffect to scale from 0-1*/
var name AirEffectScalar;


var float AirMaxDelta;
var float AirCurrentLevel;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=AerialMesh ObjName=AerialMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'Envy_Effects.Mesh.S_Air_Wind_Ball'
      CullDistance=7500.000000
      CachedCullDistance=7500.000000
      bOnlyOwnerSee=True
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-100.000000)
      Scale3D=(X=80.000000,Y=60.000000,Z=60.000000)
      AbsoluteRotation=True
      Name="AerialMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   AirEffect=AerialMesh
   MinVelocityForAirEffect=15000.000000
   MaxVelocityForAirEffect=850000.000000
   AirEffectScalar="Wind_Opacity"
   AirMaxDelta=0.050000
   Components(0)=AerialMesh
   CollisionType=COLLIDE_CustomDefault
   Name="Default__VehicleMovementEffect"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
