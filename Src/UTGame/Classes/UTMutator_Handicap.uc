// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_Handicap extends UTMutator;

var array< class<Inventory> > HandicapInventory;

/* called by GameInfo.RestartPlayer()
	change the players jumpz, etc. here
*/
function ModifyPlayer(Pawn P)
{
	local int i, HandicapNeed;
	local UTPawn PlayerPawn;
	local UTWeap_Enforcer Enforcer;

	PlayerPawn = UTPawn(P);
	if ( PlayerPawn == None )
	{
		return;
	}

	HandicapNeed = UTGame(WorldInfo.Game).GetHandicapNeed(PlayerPawn);

	if ( HandicapNeed > HandicapInventory.Length-1 )
	{
		// give a shieldbelt as well
		PlayerPawn.ShieldBeltArmor = Max(100, PlayerPawn.ShieldBeltArmor);
		HandicapNeed = HandicapInventory.Length - 1;
	}

	if ( HandicapNeed >= 1 )
	{
		PlayerPawn.VestArmor = Max(50, PlayerPawn.VestArmor);
	}
	if ( HandicapNeed >= 2 )
	{
		// always give an extra enforcer
		Enforcer = UTWeap_Enforcer(PlayerPawn.FindInventoryType(HandicapInventory[1]));
		if ( Enforcer != None )
		{
			Enforcer.DelayedBecomeDual();

		}
	}
	for ( i=2; i<HandicapNeed; i++ )
	{
		// Ensure we don't give duplicate items
		if (PlayerPawn.FindInventoryType( HandicapInventory[i] ) == None)
		{
			PlayerPawn.CreateInventory(HandicapInventory[i]);
		}
	}
	Super.ModifyPlayer(PlayerPawn);
}

defaultproperties
{
   HandicapInventory(0)=None
   HandicapInventory(1)=Class'UTGame.UTWeap_Enforcer'
   HandicapInventory(2)=Class'UTGame.UTWeap_RocketLauncher'
   GroupNames(0)="HANDICAP"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_Handicap"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
