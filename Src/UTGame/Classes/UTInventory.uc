/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTInventory extends Inventory
	native
	abstract;

var bool bDropOnDisrupt;

/** adds weapon overlay material this item uses (if any) to the GRI in the correct spot
 *  @see UTPawn.WeaponOverlayFlags, UTWeapon::SetWeaponOverlayFlags
 */
simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI);

/** called on the owning client just before the pickup is dropped or destroyed */
reliable client function ClientLostItem()
{
	if (Role < ROLE_Authority)
	{
		// owner change might not get replicated to client so force it here
		SetOwner(None);
	}
}

simulated event Destroyed()
{
	local Pawn P;

	P = Pawn(Owner);
	if (P != None && (P.IsLocallyControlled() || (P.DrivenVehicle != None && P.DrivenVehicle.IsLocallyControlled())))
	{
		ClientLostItem();
	}

	Super.Destroyed();
}

function DropFrom(vector StartLocation, vector StartVelocity)
{
	ClientLostItem();

	Super.DropFrom(StartLocation, StartVelocity);
}

defaultproperties
{
   bDropOnDisrupt=True
   DroppedPickupClass=Class'UTGame.UTRotatingDroppedPickup'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Inventory:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Inventory:Sprite'
   End Object
   Components(0)=Sprite
   MessageClass=Class'UTGame.UTPickupMessage'
   Name="Default__UTInventory"
   ObjectArchetype=Inventory'Engine.Default__Inventory'
}
