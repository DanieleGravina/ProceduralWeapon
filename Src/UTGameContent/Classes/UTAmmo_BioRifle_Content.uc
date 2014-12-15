/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTAmmo_BioRifle_Content extends UTAmmoPickupFactory;

defaultproperties
{
   AmmoAmount=20
   TargetWeapon=Class'UTGameContent.UTWeap_BioRifle_Content'
   PickupSound=SoundCue'A_Pickups.Ammo.Cue.A_Pickup_Ammo_CGBio_Cue'
   PickupMessage="Munizioni Bio-Fucile"
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAmmoPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   MaxDesireability=0.320000
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
      StaticMesh=StaticMesh'PICKUPS.Ammo_Bio.Mesh.S_Pickups_Ammo_Bio'
      Scale=1.875000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTAmmoPickupFactory:AmmoMeshComp'
   End Object
   Components(4)=AmmoMeshComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTAmmo_BioRifle_Content"
   ObjectArchetype=UTAmmoPickupFactory'UTGame.Default__UTAmmoPickupFactory'
}
