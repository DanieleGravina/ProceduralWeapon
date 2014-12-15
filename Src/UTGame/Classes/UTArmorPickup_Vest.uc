/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTArmorPickup_Vest extends UTArmorPickupFactory;

/** CanUseShield()
returns how many shield units P could use
*/
function int CanUseShield(UTPawn P)
{
	return Max(0,ShieldAmount - P.VestArmor);
}

/** AddShieldStrength()
add shield to appropriate P armor type.
*/
function AddShieldStrength(UTPawn P)
{
	P.VestArmor = Max(ShieldAmount, P.VestArmor);
}

defaultproperties
{
   ShieldAmount=50
   Begin Object Class=UTParticleSystemComponent Name=ArmorParticles ObjName=ArmorParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTArmorPickupFactory:ArmorParticles'
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTArmorPickupFactory:ArmorParticles'
   End Object
   ParticleEffects=ArmorParticles
   PickupSound=SoundCue'A_Pickups.Armor.Cue.A_Pickups_Armor_Chest_Cue'
   PickupMessage="Armatura Completa"
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTArmorPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTArmorPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   MaxDesireability=1.000000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTArmorPickupFactory:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTArmorPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTArmorPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTArmorPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTArmorPickupFactory:BaseMeshComp'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTArmorPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=ArmorParticles
   Begin Object Class=StaticMeshComponent Name=ArmorPickUpComp ObjName=ArmorPickUpComp Archetype=StaticMeshComponent'UTGame.Default__UTArmorPickupFactory:ArmorPickUpComp'
      StaticMesh=StaticMesh'PICKUPS.Armor.Mesh.S_Pickups_Armor'
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTArmorPickupFactory:ArmorPickUpComp'
   End Object
   Components(5)=ArmorPickUpComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTArmorPickup_Vest"
   ObjectArchetype=UTArmorPickupFactory'UTGame.Default__UTArmorPickupFactory'
}
