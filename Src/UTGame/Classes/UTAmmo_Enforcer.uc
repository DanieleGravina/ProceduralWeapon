/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAmmo_Enforcer extends UTAmmoPickupFactory;

defaultproperties
{
   AmmoAmount=16
   TargetWeapon=Class'UTGame.UTWeap_Enforcer'
   PickupSound=SoundCue'A_Pickups.Ammo.Cue.A_Pickup_Ammo_Enforcer_Cue'
   PickupMessage="Caricatore Enforcer"
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTAmmoPickupFactory:CollisionCylinder'
      CollisionHeight=14.400000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTAmmoPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTAmmoPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTAmmoPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:BaseMeshComp'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Begin Object Class=StaticMeshComponent Name=AmmoMeshComp ObjName=AmmoMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:AmmoMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Ammo_Enforcer.Mesh.S_Ammo_Enforcer'
      Translation=(X=0.000000,Y=0.000000,Z=-15.000000)
      Scale=1.250000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:AmmoMeshComp'
   End Object
   Components(4)=AmmoMeshComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTAmmo_Enforcer"
   ObjectArchetype=UTAmmoPickupFactory'UTGame.Default__UTAmmoPickupFactory'
}