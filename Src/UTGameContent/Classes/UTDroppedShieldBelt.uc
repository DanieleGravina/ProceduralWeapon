/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDroppedShieldBelt extends UTDroppedItemPickup;

var int ShieldAmount;

function DroppedFrom(Pawn P)
{
	local UTPawn UTP;

	UTP = UTPawn(P);
	if (UTP != None)
	{
		ShieldAmount = UTP.ShieldBeltArmor;
		UTP.ShieldBeltArmor = 0;
		UTP.SetOverlayMaterial(None);
	}
}

function GiveTo(Pawn P)
{
	local UTPawn UTP;

	UTP = UTPawn(P);
	UTP.ShieldBeltArmor = Max(ShieldAmount, UTP.ShieldBeltArmor);
	UTP.ShieldBeltPickupClass = Class;
	if (UTP.GetOverlayMaterial() == None)
	{
		UTP.SetOverlayMaterial(UTP.GetShieldMaterialInstance(WorldInfo.Game.bTeamGame));
	}

	PickedUpBy(P);
}

function int CanUseShield(UTPawn P)
{
	return Max(0, ShieldAmount - P.ShieldBeltArmor);
}

function float BotDesireability(Pawn Bot, Controller C)
{
	if ( UTPawn(Bot) == None )
		return 0;

	return (0.013 * MaxDesireability * CanUseShield(UTPawn(Bot)));
}

auto state Pickup
{
	/*
	 Validate touch (if valid return true to let other pick me up and trigger event).
	*/
	function bool ValidTouch(Pawn Other)
	{
		return (UTPawn(Other) != None && CanUseShield(UTPawn(Other)) > 0 && Super.ValidTouch(Other));
	}
}

defaultproperties
{
   ShieldAmount=100
   MaxDesireability=1.500000
   PickupSound=SoundCue'A_Pickups.ShieldBelt.Cue.A_Pickups_Shieldbelt_Activate_Cue'
   Begin Object Class=StaticMeshComponent Name=ArmorPickUpComp ObjName=ArmorPickUpComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Armor_ShieldBelt.Mesh.S_UN_Pickups_Shield_Belt'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTDroppedShieldBelt:DroppedPickupLightEnvironment'
      CullDistance=7000.000000
      CachedCullDistance=7000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True)
      CollideActors=False
      Scale3D=(X=1.500000,Y=1.500000,Z=1.500000)
      Name="ArmorPickUpComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   PickupMesh=ArmorPickUpComp
   Begin Object Class=DynamicLightEnvironmentComponent Name=DroppedPickupLightEnvironment ObjName=DroppedPickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDroppedItemPickup:DroppedPickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDroppedItemPickup:DroppedPickupLightEnvironment'
   End Object
   MyLightEnvironment=DroppedPickupLightEnvironment
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTDroppedItemPickup:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTDroppedItemPickup:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTDroppedItemPickup:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTDroppedItemPickup:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Components(2)=DroppedPickupLightEnvironment
   Components(3)=ArmorPickUpComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTDroppedShieldBelt"
   ObjectArchetype=UTDroppedItemPickup'UTGame.Default__UTDroppedItemPickup'
}
