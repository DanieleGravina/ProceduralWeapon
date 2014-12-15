/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_AddModifierCard extends SequenceAction;

var() name CardType;

event Activated()
{
	local PlayerController PC;
	local UTPlayerController UTPC;

	foreach GetWorldInfo().LocalPlayerControllers(class'PlayerController', PC)
	{
		UTPC = UTPlayerController(PC);
		if (UTPC != none)
		{
			break;
		}
	}

	if ( UTPC != none )
	{
		UTPC.AddModifierCard(CardType);
	}
}

defaultproperties
{
   ObjName="Add Modifier Card"
   ObjCategory="Story"
   Name="Default__UTSeqAct_AddModifierCard"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
