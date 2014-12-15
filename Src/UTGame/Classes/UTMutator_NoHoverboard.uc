// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_NoHoverboard extends UTMutator;

function InitMutator(string Options, out string ErrorMessage)
{
	if ( UTGame(WorldInfo.Game) != None )
	{
		UTGame(WorldInfo.Game).bAllowHoverboard = false;
	}
	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
   bExportMenuData=False
   GroupNames(0)="HOVERBOARD"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_NoHoverboard"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
