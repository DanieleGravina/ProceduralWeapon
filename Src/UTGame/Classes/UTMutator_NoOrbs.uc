// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_NoOrbs extends UTMutator;

function InitMutator(string Options, out string ErrorMessage)
{
	local UTOnslaughtFlagBase F;

	ForEach AllActors(class'UTOnslaughtFlagBase', F)
	{
		F.DisableOrbs();
	}
	super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
   GroupNames(0)="WARFARE"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_NoOrbs"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
