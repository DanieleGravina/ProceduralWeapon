/**
* GamePawn
*
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/

class GameWeapon extends Weapon
	config(Game)
	native
	abstract
	notplaceable;

defaultproperties
{
   Name="Default__GameWeapon"
   ObjectArchetype=Weapon'Engine.Default__Weapon'
}
