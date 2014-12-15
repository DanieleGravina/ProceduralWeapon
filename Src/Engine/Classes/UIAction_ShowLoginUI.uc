/**
 * This action tells the online subsystem to show the login ui
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_ShowLoginUI extends UIAction
	native(inherit);

/** Whether the async call is done or not */
var bool bIsDone;

/** Whether to show the online only enabled profiles or not */
var() bool bShowOnlineOnly;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Triggers the async call. */
event ShowUI()
{
	local OnlineSubsystem OnlineSub;
	local OnlinePlayerInterface PlayerInt;

	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		PlayerInt = OnlineSub.PlayerInterface;
		if(PlayerInt != none)
		{
			// Set login delegates
			PlayerInt.AddLoginChangeDelegate(OnLoginChanged);
			PlayerInt.AddLoginCancelledDelegate(OnLoginCancelled);
			// Now display the UI
			if (PlayerInt.ShowLoginUI(bShowOnlineOnly) == false)
			{
				// Clear delegate
				PlayerInt.ClearLoginChangeDelegate(OnLoginChanged);
				PlayerInt.ClearLoginCancelledDelegate(OnLoginCancelled);
				// Exit out early if we couldnt show the UI.
				bIsDone = true;
				LogInternal("Failed to show the login UI");
			}
		}
		else
		{
			bIsDone = true;
		}
	}
	else
	{
		// Exit out early if there is no OnlineSub.
		bIsDone = true;
	}
}

/**
 * Sets the bIsDone flag to true so we unblock kismet.
 */
function OnLoginChanged()
{
	local OnlineSubsystem OnlineSub;
	local OnlinePlayerInterface PlayerInt;

	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		PlayerInt = OnlineSub.PlayerInterface;
		if (PlayerInt != None)
		{
			// Unregister our callbacks
			PlayerInt.ClearLoginChangeDelegate(OnLoginChanged);
			PlayerInt.ClearLoginCancelledDelegate(OnLoginCancelled);
		}
	}
	bIsDone = true;
}

/**
 * Login was cancelled. Sets the bIsDone flag to true so we unblock kismet.
 * @todo amitt do error handling due to canceling
 */
function OnLoginCancelled()
{
	local OnlineSubsystem OnlineSub;
	local OnlinePlayerInterface PlayerInt;

	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		PlayerInt = OnlineSub.PlayerInterface;
		if (PlayerInt != None)
		{
			// Unregister our callbacks
			PlayerInt.ClearLoginChangeDelegate(OnLoginChanged);
			PlayerInt.ClearLoginCancelledDelegate(OnLoginCancelled);
		}
	}
	bIsDone = true;
}

defaultproperties
{
   bAutoTargetOwner=True
   bLatentExecution=True
   ObjName="Show Login UI"
   ObjCategory="Online"
   Name="Default__UIAction_ShowLoginUI"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
