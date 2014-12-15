/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Tab page for a user's vehicle weapon stats.
 */
class UTUITabPage_StatsVehicleWeapons extends UTUITabPage_StatsPage
	placeable;

/** Post initialization event - Setup widget delegates.*/
event PostInitialize()
{
	Super.PostInitialize();

	// Set the button tab caption.
	SetDataStoreBinding("<Strings:UTGameUI.Stats.VehicleWeapons>");
}

/** Starts the stats read for this page. */
function ReadStats()
{
	local OnlineSubsystem OnlineSub;
	local OnlineStatsRead ReadObj;

	// Get the read object we will use
	ReadObj = StatsDataStore.GetReadObjectFromType(UTSR_VehicleWeapons);

	if(ReadObj != None)
	{
		OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
		if ( OnlineSub != None )
		{
			OnlineSub.StatsInterface.AddReadOnlineStatsCompleteDelegate(OnStatsReadComplete);
		}

		RefreshingLabel.SetVisibility(true);
		StatsDataStore.AddToReadQueue(ReadObj);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUITabPage_StatsPage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUITabPage_StatsPage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_StatsVehicleWeapons"
   ObjectArchetype=UTUITabPage_StatsPage'UTGame.Default__UTUITabPage_StatsPage'
}
