/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTMutator_Arena extends UTMutator
	config(Game);

/** full path to class of weapon to use */
var config string ArenaWeaponClassPath;

function PostBeginPlay()
{
	local UTGame Game;

	Super.PostBeginPlay();

	Game = UTGame(WorldInfo.Game);
	if (Game != None)
	{
		Game.DefaultInventory.Length = 1;
		Game.DefaultInventory[0] = class<Weapon>(DynamicLoadObject(ArenaWeaponClassPath, class'Class'));
		if (Game.DefaultInventory[0] == None)
		{
			WarnInternal("Failed to load arena weapon, falling back to rocket launcher");
			Game.DefaultInventory[0] = class'UTWeap_RocketLauncher';
		}
	}
}

function bool CheckReplacement(Actor Other)
{
	return (!Other.IsA('UTWeaponPickupFactory') && !Other.IsA('UTAmmoPickupFactory') && !Other.IsA('UTWeaponLocker'));
}

function ModifyPlayer(Pawn Other)
{
	local UTInventoryManager UTInvManager;

	UTInvManager = UTInventoryManager(Other.InvManager);
	if (UTInvManager != None)
	{
		UTInvManager.bInfiniteAmmo = true;
	}

	Super.ModifyPlayer(Other);
}

defaultproperties
{
   ArenaWeaponClassPath="UTGame.UTWeap_ShockRifle"
   GroupNames(0)="WEAPONMOD"
   GroupNames(1)="WEAPONRESPAWN"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_Arena"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
