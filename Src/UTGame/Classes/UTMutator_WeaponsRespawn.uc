// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_WeaponsRespawn extends UTMutator;

simulated function PostBeginPlay()
{
	local UTWeaponPickupFactory WPF;

	Super.PostBeginPlay();

	// set bweaponstay on clients
	ForEach DynamicActors(class'UTWeaponPickupFactory', WPF)
	{
		WPF.bWeaponStay = false;
	}
}

function InitMutator(string Options, out string ErrorMessage)
{
	UTGame(WorldInfo.Game).bWeaponStay = false;
	super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
   GroupNames(0)="WEAPONRESPAWN"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   RemoteRole=ROLE_SimulatedProxy
   bAlwaysRelevant=True
   Name="Default__UTMutator_WeaponsRespawn"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
