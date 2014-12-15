/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAmmo_RocketLauncher extends UTAmmoPickupFactory;

defaultproperties
{
   AmmoAmount=6
   TargetWeapon=Class'UTGame.UTWeap_RocketLauncher'
   PickupSound=SoundCue'A_Pickups.Ammo.Cue.A_Pickup_Ammo_Rocket_Cue'
   PickupMessage="Pacchetto di missili"
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
      AmbientGlow=(R=1.000000,G=1.000000,B=1.000000,A=1.000000)
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   MaxDesireability=0.300000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTAmmoPickupFactory:CollisionCylinder'
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
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmo_RocketLauncher:PickupLightEnvironment'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Begin Object Class=StaticMeshComponent Name=AmmoMeshComp ObjName=AmmoMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:AmmoMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Ammo_Rockets.Mesh.S_Ammo_RocketLauncher'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmo_RocketLauncher:PickupLightEnvironment'
      Translation=(X=0.000000,Y=0.000000,Z=1.000000)
      Rotation=(Pitch=0,Yaw=0,Roll=16384)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:AmmoMeshComp'
   End Object
   Components(4)=AmmoMeshComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTAmmo_RocketLauncher"
   ObjectArchetype=UTAmmoPickupFactory'UTGame.Default__UTAmmoPickupFactory'
}
