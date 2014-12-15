/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGameUISceneClient extends GameUISceneClient
	dependson(UTSeqObj_SPMission)
	dependson(UTUIScene_SaveProfile)
	dependson(UTUIScene_TutorialMessage)
	dependson(UTUIScene_TimedTutorialMessage)
	native(UI);

/** Debug values */

var(Debug)  bool bShowRenderTimes;
var float PreRenderTime;
var float RenderTime;
var float TickTime;
var float AnimTime;
var float AvgTime;
var float AvgRenderTime;
var float FrameCount;
var float StringRenderTime;

/** Holds a copy of the current mission info */
var transient EMissionData CurrentMissionData;

/** Holds the mission briefing */
var transient string MissionText;

var UTUIScene_SaveProfile SaveProfileTemplate;
var UTUIScene_TutorialMessage TutorialTemplate;
var UTUIScene_TimedTutorialMessage TimedTutorialTemplate;

/** Toast message to display. */
var transient string ToastMessage;

/** The time the toast message was displayed at. */
var transient float	ShowStartTime;

/** The priority of the currently displaying toast message */
var transient int CurrentPriority;

/**
 * This is true if the first frame of the toast message has been drawn.
 * We need to know this because sometimes toast messages are shown durring movies (meaning they aren't displayed)
 * and on the first frame we need to reset ShowStartTime so that the toast message is actually displayed.
 */
var transient bool bFirstFrame;

/** Whether or not the toast is visible. */
var transient bool bToastVisible;

/** The time the toast message started hiding itself. */
var transient float	HideStartTime;

/** Whether or not we are hiding the toast. */
var transient bool bHidingToast;

/** Amount of time to display the toast for. */
var transient float ToastDuration;

/** Amount of time toast takes to transition. */
var transient float	ToastTransitionTime;

/** Toast image information. */
var transient Font		ToastFont;
var transient Texture2D	ToastImage;
var transient float		ToastImageU;
var transient float		ToastImageV;
var transient float		ToastImageUL;
var transient float		ToastImageVL;

/** Scale of toast message background image and text */
var transient float		ToastScale;

/** Toast colors */
var transient LinearColor	ToastColor;
var transient LinearColor	ToastTextColor;

/** Whether or not to dim the entire screen, used for the network dialog on ps3. */
var transient bool bDimScreen;

var transient name LastModifierCardUsed;

/**
 * Indicates whether we've checked that the user's machine meets the min specs.
 */
var	globalconfig	bool	bPerformedMinSpecCheck;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * Returns the WorldInfo
 */
native static  function WorldInfo GetWorldInfo();

native function bool IsInSeamlessTravel();

function NotifyGameSessionEnded()
{
	Super.NotifyGameSessionEnded();
	ChangeActiveSkin(UISkin'UI_InGameHud.UTHUDSkin');
}


/**
 * Sets the current mission data
 */

function SetCurrentMission(EMissionData NewMissionData)
{
	CurrentMissionData = NewMissionData;
}

/** @return TRUE if there are any scenes currently accepting input, FALSE otherwise. */
native function bool IsUIAcceptingInput();


/**
 * Displays the Saving Profile scene
 *
 * @param PlayerOwner	Player to save profile info for.
 *
 * @return	Returns a ref to the scene if one was shown, otherwise, returns None.
 */
function UTUIScene_SaveProfile ShowSaveProfileScene(UTPlayerController PlayerOwner)
{
	local UIScene Result;
	local UIDataStore_OnlinePlayerData	PlayerDataStore;

	Result = None;

	if(PlayerOwner != None)
	{
		// Only show the scene on consoles.
		if ( class'UIRoot'.static.IsConsole() )
		{
			OpenScene(SaveProfileTemplate,LocalPlayer(PlayerOwner.Player),Result);
		}
		else
		{
			PlayerDataStore = UIDataStore_OnlinePlayerData(DataStoreManager.FindDataStore('OnlinePlayerData', LocalPlayer(PlayerOwner.Player)));

			if(PlayerDataStore != none)
			{
				PlayerDataStore.SaveProfileData();
			}
		}
	}

	return UTUIScene_SaveProfile(Result);
}

/**
 * Sets the current message for this scene.
 *
 * @param Message		Message to display
 * @param ToastTime		How long to display the message for.  A value of < 0 will make the message stay up forever until hidden manually, and any subsequent calls wont override the existing message.
 */
function SetToastMessage(string Message, optional float ToastTime=6.0f, optional int Priority=0)
{
	if(bToastVisible==false)
	{
		bToastVisible = true;
		bHidingToast = false;
		ToastDuration = ToastTime;
		ToastMessage = Message;
		ShowStartTime = GetWorldInfo().RealTimeSeconds;
		bFirstFrame = false;
        CurrentPriority = Priority;
	}
	else if(ToastDuration > 0.0f && Priority >= CurrentPriority)
	{
		ToastMessage = Message;
		ShowStartTime = GetWorldInfo().RealTimeSeconds + ToastTransitionTime;
		CurrentPriority = Priority;
	}
}

/** Called when the toast is complete and ready to be hidden. */
event FinishToast()
{
	HideStartTime = GetWorldInfo().RealTimeSeconds;
	bHidingToast = true;
	bFirstFrame = false;
	CurrentPriority = 0;
}

defaultproperties
{
   SaveProfileTemplate=UTUIScene_SaveProfile'UI_Scenes_Common.SaveProfile'
   TutorialTemplate=UTUIScene_TutorialMessage'UI_InGameHud.Menus.TutorialMessage'
   TimedTutorialTemplate=UTUIScene_TimedTutorialMessage'UI_InGameHud.Menus.TimedTutorialMessage'
   Name="Default__UTGameUISceneClient"
   ObjectArchetype=GameUISceneClient'Engine.Default__GameUISceneClient'
}
