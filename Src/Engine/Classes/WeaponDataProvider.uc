/**
 * Provides data about a weapon inventory item.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class WeaponDataProvider extends InventoryDataProvider
	native(inherit);

defaultproperties
{
   DataClass=Class'Engine.Weapon'
   Name="Default__WeaponDataProvider"
   ObjectArchetype=InventoryDataProvider'Engine.Default__InventoryDataProvider'
}
