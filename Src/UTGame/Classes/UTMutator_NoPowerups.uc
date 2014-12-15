// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_NoPowerups extends UTMutator;

function bool CheckReplacement(Actor Other)
{
	local UTPickupFactory F;

	F = UTPickupFactory(Other);
	return (F == None || (!F.bIsSuperItem && !F.IsA('UTPickupFactory_JumpBoots')));
}

defaultproperties
{
   GroupNames(0)="POWERUPS"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_NoPowerups"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
