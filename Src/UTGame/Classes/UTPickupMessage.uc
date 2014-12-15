/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//
// OptionalObject is an Pickup class
//
class UTPickupMessage extends UTLocalMessage;

static simulated function ClientReceive( 
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	local UTHUD HUD;

	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	HUD = UTHUD(P.MyHUD);
	if ( HUD != None )
	{
		if ( class<UTPickupFactory>(OptionalObject) != None )
		{
			class<UTPickupFactory>(OptionalObject).static.UpdateHUD(HUD);
		}
		else if ( class<UTWeapon>(OptionalObject) != None )
		{
			HUD.LastWeaponBarDrawnTime = HUD.WorldInfo.TimeSeconds + 2.0;
			HUD.LastPickupTime = HUD.WorldInfo.TimeSeconds;
		}
		else
		{
			HUD.LastPickupTime = HUD.WorldInfo.TimeSeconds;
		}
	}		
}

defaultproperties
{
   MessageArea=5
   bIsUnique=True
   bCountInstances=True
   DrawColor=(B=128,G=255,R=255,A=255)
   FontSize=1
   Name="Default__UTPickupMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
