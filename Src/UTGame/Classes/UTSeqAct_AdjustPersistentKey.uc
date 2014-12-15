/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_AdjustPersistentKey extends SequenceAction;

var() ESinglePlayerPersistentKeys TargetKey;
var() bool bRemoveKey;

event Activated()
{
	local PlayerController PC;
	local UTPlayerController UTPC;

	foreach GetWorldInfo().AllControllers(class'PlayerController', PC)
	{
		UTPC = UTPlayerController(PC);
		if (UTPC != none)
		{
			break;
		}
	}

	if ( UTPC != none )
	{
		UTPC.AdjustPersistentKey(self);
	}
}

defaultproperties
{
   ObjName="AdjustPersistentKey"
   ObjCategory="Story"
   Name="Default__UTSeqAct_AdjustPersistentKey"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
