// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_BigHead extends UTMutator;

/* called by GameInfo.RestartPlayer()
	change the players jumpz, etc. here
*/
function ModifyPlayer(Pawn P)
{
	if ( UTPawn(P) != None )
	{
		UTPawn(P).SetBigHead();
	}
	Super.ModifyPlayer(P);
}

defaultproperties
{
   GroupNames(0)="BIGHEAD"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_BigHead"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
