/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTArmorPickup_ShieldBelt extends UTArmorPickupFactory;

var class<UTDroppedItemPickup> DroppedPickupClass;

/**
* CanUseShield() returns how many shield units P could use
*
* @Returns returns how many shield units P could use
*/
function int CanUseShield(UTPawn P)
{
	return Max(0,ShieldAmount - P.ShieldBeltArmor);
}

/**
* AddShieldStrength() add shield to appropriate P armor type.
*
* @Param	P 	The UTPawn to give shields to
*/
function AddShieldStrength(UTPawn P)
{
	local MaterialInterface ShieldMat;

	// Get the proper shield material
	ShieldMat = P.GetShieldMaterialInstance(WorldInfo.Game.bTeamGame);

	// Assign it
	P.ShieldBeltArmor = Max(ShieldAmount, P.ShieldBeltArmor);
	P.ShieldBeltPickupClass = DroppedPickupClass;
	if (P.GetOverlayMaterial() == None)
	{
		P.SetOverlayMaterial(ShieldMat);
	}
}

defaultproperties
{
   DroppedPickupClass=Class'UTGameContent.UTDroppedShieldBelt'
   ShieldAmount=100
   Begin Object Class=UTParticleSystemComponent Name=ArmorParticles ObjName=ArmorParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTArmorPickupFactory:ArmorParticles'
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTArmorPickupFactory:ArmorParticles'
   End Object
   ParticleEffects=ArmorParticles
   PickupSound=SoundCue'A_Pickups.ShieldBelt.Cue.A_Pickups_Shieldbelt_Activate_Cue'
   PickupMessage="Elettrocintura"
   RespawnTime=60.000000
   bHasLocationSpeech=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTArmorPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTArmorPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PickupStatName="PICKUPS_SHIELDBELT"
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheShieldBelt'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheShieldBelt'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheShieldBelt'
   bIsSuperItem=True
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
      StaticMesh=StaticMesh'PICKUPS.Armor_ShieldBelt.Mesh.S_UN_Pickups_Shield_Belt'
      Scale3D=(X=1.500000,Y=1.500000,Z=1.500000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTArmorPickupFactory:ArmorPickUpComp'
   End Object
   Components(5)=ArmorPickUpComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTArmorPickup_ShieldBelt"
   ObjectArchetype=UTArmorPickupFactory'UTGame.Default__UTArmorPickupFactory'
}
