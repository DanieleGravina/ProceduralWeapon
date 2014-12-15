/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTCinematicPlayerController extends UTEntryPlayerController;

function QuitToMainMenu()
{
	LogInternal("UTCinematicPlayerController::QuitToMainMenu() - Quitting to main menu from a cinematic.");

	Super(UTPlayerController).QuitToMainMenu();
}

defaultproperties
{
   EntryPostProcessChain=None
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTEntryPlayerController:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTEntryPlayerController:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTEntryPlayerController:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTEntryPlayerController:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTCinematicPlayerController"
   ObjectArchetype=UTEntryPlayerController'UTGame.Default__UTEntryPlayerController'
}
