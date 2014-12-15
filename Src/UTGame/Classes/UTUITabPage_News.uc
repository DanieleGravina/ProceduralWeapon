/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Tab page for downloaded news.
 */
class UTUITabPage_News extends UTTabPage
	placeable;

/**  Reference to the news label. */
var transient UILabel	NewsLabel;

/** Reference to the news interface. */
var transient OnlineNewsInterface NewsInterface;

/** Post initialization event - Setup widget delegates.*/
event PostInitialize()
{
	local OnlineSubsystem OnlineSub;

	Super.PostInitialize();

	// Set the button tab caption.
	SetDataStoreBinding("<Strings:UTGameUI.Community.News>");

	// Find a news label
	NewsLabel = UILabel(FindChild('lblNews', true));

	// Figure out if we have an online subsystem registered
	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		// Grab the news interface to verify the subsystem supports it
		NewsInterface = OnlineSub.NewsInterface;
		if (NewsInterface == None)
		{
			LogInternal("UTUITabPage_News::PostInitialize() - Couldn't find news interface!");
		}
	}

	// Start a news read
	ReadNews();
}

/** Starts reading the latest news. */
function ReadNews()
{
	LogInternal("UTUITabPage_News::ReadNews() - Reading news from the web...");

	// Set placeholder label
	NewsLabel.SetDataStoreBinding("<Strings:UTGameUI.Generic.Loading>");

	// Start news read
	NewsInterface.AddReadGameNewsCompletedDelegate(OnReadGameNewsCompleted);
	if(NewsInterface.ReadGameNews(GetPlayerOwner().ControllerId)==false)
	{
		OnReadGameNewsCompleted(false);
	}
}

/**
 * Delegate used in notifying the UI/game that the news read operation completed
 *
 * @param bWasSuccessful true if the read completed ok, false otherwise
 */
function OnReadGameNewsCompleted(bool bWasSuccessful)
{
	LogInternal("UTUITabPage_News::OnReadGameNewsCompleted() - bWasSuccessful: "$bWasSuccessful);

	NewsInterface.ClearReadGameNewsCompletedDelegate(OnReadGameNewsCompleted);

	if(bWasSuccessful)
	{
		NewsLabel.SetDataStoreBinding(NewsInterface.GetGameNews(GetPlayerOwner().ControllerId));
	}
	else
	{
		NewsLabel.SetDataStoreBinding("<Strings:UTGameUI.Errors.FailedToReadNews>");
	}
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTTabPage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTTabPage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_News"
   ObjectArchetype=UTTabPage'UTGame.Default__UTTabPage'
}
