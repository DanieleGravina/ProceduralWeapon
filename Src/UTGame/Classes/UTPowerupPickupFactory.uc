/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTPowerupPickupFactory extends UTPickupFactory
	abstract
	native;

/** extra spinning component (rotated in C++ when visible) */
var PrimitiveComponent Spinner;

/** extra spinning particles (rotated in C++ when visible) */
var UTParticleSystemComponent ParticleEffects;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** adds weapon overlay material this powerup uses (if any) to the GRI in the correct spot
 *  @see UTPawn.WeaponOverlayFlags, UTWeapon::SetWeaponOverlayFlags
 */
simulated function AddWeaponOverlay(UTGameReplicationInfo GRI)
{
	local class<UTInventory> UTInvClass;

	UTInvClass = class<UTInventory>(InventoryType);
	if (UTInvClass != None)
	{
		UTInvClass.static.AddWeaponOverlay(GRI);
	}
}

simulated function SetPickupVisible()
{
	if (ParticleEffects != None)
	{
		ParticleEffects.SetActive(true);
	}

	Super.SetPickupVisible();
}

simulated function SetPickupHidden()
{
	if (ParticleEffects != None)
	{
		ParticleEffects.DeactivateSystem();
	}

	super.SetPickupHidden();
}

function SpawnCopyFor( Pawn Recipient )
{
	if ( UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo) != None )
	{
		UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo).IncrementPickupStat(GetPickupStatName());
	}
	Recipient.MakeNoise(0.5);

	super.SpawnCopyFor(Recipient);
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Base_Powerup.Mesh.S_Pickups_Base_Powerup01_Disc'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
      CullDistance=7000.000000
      CachedCullDistance=7000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True)
      CollideActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-40.000000)
      Name="StaticMeshComponent1"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Spinner=StaticMeshComponent1
   bRotatingPickup=True
   bTrackPickup=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   bIsSuperItem=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPickupFactory:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTPickupFactory:BaseMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Base_Powerup.Mesh.S_Pickups_Base_Powerup01'
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=StaticMeshComponent1
   bMovable=True
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTPowerupPickupFactory"
   ObjectArchetype=UTPickupFactory'UTGame.Default__UTPickupFactory'
}
