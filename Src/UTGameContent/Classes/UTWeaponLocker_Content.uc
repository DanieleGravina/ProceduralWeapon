/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeaponLocker_Content extends UTWeaponLocker;

defaultproperties
{
   Begin Object Class=UTParticleSystemComponent Name=ParticleSystem0 ObjName=ParticleSystem0 Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="ParticleSystem0"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   AmbientEffect=ParticleSystem0
   Begin Object Class=UTParticleSystemComponent Name=ParticleSystem1 ObjName=ParticleSystem1 Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'GP_Onslaught.Effects.P_Ons_WeaponLocker_Core_Active'
      CullDistance=1000.000000
      CachedCullDistance=1000.000000
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="ParticleSystem1"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ProximityEffect=ParticleSystem1
   InactiveEffectTemplate=ParticleSystem'GP_Onslaught.Effects.P_Ons_WeaponLocker_Core_Neutral'
   ActiveEffectTemplate=ParticleSystem'GP_Onslaught.Effects.P_Ons_WeaponLocker_Core_Equipped'
   WeaponSpawnEffectTemplate=ParticleSystem'GP_Onslaught.Effects.P_Ons_WeaponLocker_Weapon_Spawn'
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWeaponLocker:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWeaponLocker:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTWeaponLocker:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTWeaponLocker:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTWeaponLocker:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTWeaponLocker:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTWeaponLocker:BaseMeshComp'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Weapon_Locker'
      CullDistance=8000.000000
      CollideActors=True
      BlockNonZeroExtent=False
      RBChannel=RBCC_Nothing
      RBCollideWithChannels=(Default=True,GameplayPhysics=True,EffectPhysics=True)
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTWeaponLocker:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=ParticleSystem0
   Components(5)=ParticleSystem1
   CollisionComponent=CollisionCylinder
   Name="Default__UTWeaponLocker_Content"
   ObjectArchetype=UTWeaponLocker'UTGame.Default__UTWeaponLocker'
}
