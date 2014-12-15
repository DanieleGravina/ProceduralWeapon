/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Tab page for a server browser.
 */

class UTUITabPage_ServerBrowser extends UTTabPage
	placeable;
























































































































 



#linenumber 10









const GS_USERNAME_MAXLENGTH					 = 15;
const GS_PASSWORD_MAXLENGTH					 = 30;
const GS_MESSAGE_MAXLENGTH					 = 255;
const GS_EMAIL_MAXLENGTH					 = 50;
const GS_CDKEY_PART_MAXLENGTH				 = 4;


const CONTEXT_PRESENCE_MENUPRESENCE              = 0;

const CONTEXT_GAME_MODE							 = 0x0000800B;


const CONTEXT_GAME_MODE_DM                       = 0;
const CONTEXT_GAME_MODE_CTF                      = 1;
const CONTEXT_GAME_MODE_WAR                      = 2;
const CONTEXT_GAME_MODE_VCTF					 = 3;
const CONTEXT_GAME_MODE_TDM                      = 4;
const CONTEXT_GAME_MODE_DUEL                     = 5;
const CONTEXT_GAME_MODE_CUSTOM                   = 6;
const CONTEXT_GAME_MODE_CAMPAIGN                 = 7;
const CONTEXT_GAME_MODE_GREED					 = 8;
const CONTEXT_GAME_MODE_BETRAYAL				 = 9;

const CONTEXT_BOTSKILL                           = 0;
const CONTEXT_MAPNAME                            = 1;
const CONTEXT_PURESERVER                         = 6;
const CONTEXT_LOCKEDSERVER                       = 7;
const CONTEXT_VSBOTS                             = 8;
const CONTEXT_CAMPAIGN                           = 9;
const CONTEXT_FORCERESPAWN                       = 10;
const CONTEXT_ALLOWKEYBOARD                      = 11;
const CONTEXT_FULLSERVER                         = 12;
const CONTEXT_EMPTYSERVER                        = 13;
const CONTEXT_DEDICATEDSERVER                    = 14;


const CONTEXT_BOTSKILL_AUTOADJUSTSKILL                     = 0;
const CONTEXT_BOTSKILL_NOVICE                              = 1;
const CONTEXT_BOTSKILL_AVERAGE                             = 2;
const CONTEXT_BOTSKILL_EXPERIENCED                         = 3;
const CONTEXT_BOTSKILL_SKILLED                             = 4;
const CONTEXT_BOTSKILL_ADEPT                               = 5;
const CONTEXT_BOTSKILL_MASTERFUL                           = 6;
const CONTEXT_BOTSKILL_INHUMAN                             = 7;
const CONTEXT_BOTSKILL_GODLIKE                             = 8;




const CONTEXT_MAPNAME_CUSTOM                     = 0;
const CONTEXT_MAPNAME_CORET                      = 1;
const CONTEXT_MAPNAME_HYDROSIS                   = 2;
const CONTEXT_MAPNAME_OMICRON_DAWN               = 3;
const CONTEXT_MAPNAME_REFLECTION                 = 4;
const CONTEXT_MAPNAME_STRIDENT                   = 5;
const CONTEXT_MAPNAME_VERTEBRAE                  = 6;
const CONTEXT_MAPNAME_ARSENAL                    = 7;
const CONTEXT_MAPNAME_BIOHAZARD                  = 8;
const CONTEXT_MAPNAME_CARBON_FIRE                = 9;
const CONTEXT_MAPNAME_DECK                       = 10;
const CONTEXT_MAPNAME_DEFIANCE                   = 11;
const CONTEXT_MAPNAME_DEIMOS                     = 12;
const CONTEXT_MAPNAME_DIESEL                     = 13;
const CONTEXT_MAPNAME_FEARLESS                   = 14;
const CONTEXT_MAPNAME_GATEWAY                    = 15;
const CONTEXT_MAPNAME_HEAT_RAY                   = 16;
const CONTEXT_MAPNAME_RISING_SUN                 = 17;
const CONTEXT_MAPNAME_SANCTUARY                  = 18;
const CONTEXT_MAPNAME_SENTINEL                   = 19;
const CONTEXT_MAPNAME_SHANGRILA                  = 20;
const CONTEXT_MAPNAME_CONTAINMENT                = 21;
const CONTEXT_MAPNAME_CONTAINMENTSP              = 22;
const CONTEXT_MAPNAME_CORRUPTION                 = 23;
const CONTEXT_MAPNAME_KARGO                      = 24;
const CONTEXT_MAPNAME_NECROPOLIS                 = 25;
const CONTEXT_MAPNAME_SANDSTORM                  = 26;
const CONTEXT_MAPNAME_SUSPENSE                   = 27;
const CONTEXT_MAPNAME_AVALANCHE                  = 28;
const CONTEXT_MAPNAME_DOWNTOWN                   = 29;
const CONTEXT_MAPNAME_DUSK                       = 30;
const CONTEXT_MAPNAME_FLOODGATE                  = 31;
const CONTEXT_MAPNAME_ISLANDER                   = 32;
const CONTEXT_MAPNAME_ISLANDERNECRIS             = 33;
const CONTEXT_MAPNAME_MARKET_DISTRICT            = 34;
const CONTEXT_MAPNAME_ONYX_COAST                 = 35;
const CONTEXT_MAPNAME_POWER_SURGE                = 36;
const CONTEXT_MAPNAME_SERENITY                   = 37;
const CONTEXT_MAPNAME_SERENITYNECRIS             = 38;
const CONTEXT_MAPNAME_SINKHOLE                   = 39;
const CONTEXT_MAPNAME_TANK_CROSSING              = 40;
const CONTEXT_MAPNAME_TORLAN                     = 41;
const CONTEXT_MAPNAME_TORLANLEVIATHAN            = 42;
const CONTEXT_MAPNAME_TORLANNECRIS               = 43;
const CONTEXT_MAPNAME_MISSION_SELECTION          = 44;
const CONTEXT_MAPNAME_KBARGE					 = 45;
const CONTEXT_MAPNAME_MORBIAS					 = 46;
const CONTEXT_MAPNAME_FACINGWORLDS				 = 47;
const CONTEXT_MAPNAME_SEARCHLIGHT				 = 48;
const CONTEXT_MAPNAME_RAILS						 = 49;
const CONTEXT_MAPNAME_SUSPENSE_NECRIS			 = 50;
const CONTEXT_MAPNAME_COLDHARBOR				 = 51;
const CONTEXT_MAPNAME_DOWNTOWNNECRIS			 = 52;

const CONTEXT_MAPNAME_LOSTCAUSE					 = 53;
const CONTEXT_MAPNAME_MORBID					 = 54;
const CONTEXT_MAPNAME_NANOBLACK					 = 55;
const CONTEXT_MAPNAME_SHAFT						 = 56;
const CONTEXT_MAPNAME_DARKMATCH					 = 57;
const CONTEXT_MAPNAME_OCEANRELIC				 = 58;
const CONTEXT_MAPNAME_EDENINC					 = 59;
const CONTEXT_MAPNAME_TURBINE					 = 60;
const CONTEXT_MAPNAME_STRANDED					 = 61;
const CONTEXT_MAPNAME_CONFRONTATION				 = 62;
const CONTEXT_MAPNAME_HOSTILE					 = 63;



const CONTEXT_GOALSCORE_5                        = 0;
const CONTEXT_GOALSCORE_10                       = 1;
const CONTEXT_GOALSCORE_15                       = 2;
const CONTEXT_GOALSCORE_20                       = 3;
const CONTEXT_GOALSCORE_30                       = 4;



const CONTEXT_NUMBOTS_0                          = 0;
const CONTEXT_NUMBOTS_1                          = 1;
const CONTEXT_NUMBOTS_2                          = 2;
const CONTEXT_NUMBOTS_3                          = 3;
const CONTEXT_NUMBOTS_4                          = 4;
const CONTEXT_NUMBOTS_5                          = 5;
const CONTEXT_NUMBOTS_6                          = 6;
const CONTEXT_NUMBOTS_7                          = 7;
const CONTEXT_NUMBOTS_8                          = 8;



const CONTEXT_TIMELIMIT_5                        = 0;
const CONTEXT_TIMELIMIT_10                       = 1;
const CONTEXT_TIMELIMIT_15                       = 2;
const CONTEXT_TIMELIMIT_20                       = 3;
const CONTEXT_TIMELIMIT_30                       = 4;



const CONTEXT_PURESERVER_NO                                = 0;
const CONTEXT_PURESERVER_YES                               = 1;
const CONTEXT_PURESERVER_ANY                               = 2;



const CONTEXT_LOCKEDSERVER_NO                              = 0;
const CONTEXT_LOCKEDSERVER_YES                             = 1;



const CONTEXT_CAMPAIGN_NO                                  = 0;
const CONTEXT_CAMPAIGN_YES                                 = 1;



const CONTEXT_FORCERESPAWN_NO                              = 0;
const CONTEXT_FORCERESPAWN_YES                             = 1;



const CONTEXT_ALLOWKEYBOARD_NO                             = 0;
const CONTEXT_ALLOWKEYBOARD_YES                            = 1;
const CONTEXT_ALLOWKEYBOARD_ANY                            = 2;


const CONTEXT_FULLSERVER_NO                                = 0;
const CONTEXT_FULLSERVER_YES                               = 1;


const CONTEXT_EMPTYSERVER_NO					= 0;
const CONTEXT_EMPTYSERVER_YES					= 1;


const CONTEXT_DEDICATEDSERVER_NO                = 0;
const CONTEXT_DEDICATEDSERVER_YES               = 1;



const  CONTEXT_VSBOTS_NONE                       = 0;
const  CONTEXT_VSBOTS_1_TO_2                     = 1;
const  CONTEXT_VSBOTS_1_TO_1                     = 2;
const  CONTEXT_VSBOTS_3_TO_2					 = 3;
const  CONTEXT_VSBOTS_2_TO_1                     = 4;
const  CONTEXT_VSBOTS_3_TO_1                     = 5;
const  CONTEXT_VSBOTS_4_TO_1                     = 6;

const PROPERTY_NUMBOTS							 = 0x100000F7;
const PROPERTY_GOALSCORE						 = 0x100000F8;
const PROPERTY_TIMELIMIT				         = 0x100000F9;
const PROPERTY_NUMBOTSIA				         = 0x100000FA;
const PROPERTY_LEADERBOARDRATING	             = 0x20000004;
const PROPERTY_EPICMUTATORS                      = 0x10000105;
const PROPERTY_STEAMID					         = 0x10000200;
const PROPERTY_STEAMVAC					         = 0x10000201;


const PROPERTY_CUSTOMMAPNAME                     = 0x40000001;
const PROPERTY_CUSTOMGAMEMODE                    = 0x40000002;
const PROPERTY_SERVERDESCRIPTION                 = 0x40000003;
const PROPERTY_CUSTOMMUTATORS                    = 0x40000004;
const PROPERTY_CUSTOMMUTCLASSES                  = 0x40000005;


const QUERY_DM									 = 0;
const QUERY_TDM									 = 1;
const QUERY_CTF									 = 2;
const QUERY_VCTF								 = 3;
const QUERY_WAR									 = 4;
const QUERY_DUEL								 = 5;
const QUERY_CAMPAIGN							 = 6;
const QUERY_GREED								 = 7;
const QUERY_BETRAYAL							 = 8;



const STATS_VIEW_DM_PLAYER_ALLTIME                         = 1;
const STATS_VIEW_DM_RANKED_ALLTIME                         = 2;
const STATS_VIEW_DM_WEAPONS_ALLTIME                        = 3;
const STATS_VIEW_DM_VEHICLES_ALLTIME                       = 4;
const STATS_VIEW_DM_VEHICLEWEAPONS_ALLTIME                 = 5;
const STATS_VIEW_DM_VEHICLES_RANKED_ALLTIME                = 6;
const STATS_VIEW_DM_VEHICLEWEAPONS_RANKED_ALLTIME          = 7;
const STATS_VIEW_DM_WEAPONS_RANKED_ALLTIME                 = 8;

#linenumber 11


const SERVERBROWSER_SERVERTYPE_LAN		= 0;
const SERVERBROWSER_SERVERTYPE_UNRANKED	= 1;	//	for platforms which do not support ranked matches, represents a normal internet match.
const SERVERBROWSER_SERVERTYPE_RANKED	= 2;	// only valid on platforms which support ranked matches

/** Reference to the list of servers */
var transient UIList						ServerList;
/** Reference to the list of rules for the selected server */
var transient UIList						DetailsList;
/** reference to the list of mutators for the selected server */
var transient UIList						MutatorList;
/** reference to the list of players for the selected server */
var transient UIList						PlayerList;

/** Reference to a label to display when refreshing. */
var transient UIObject						RefreshingLabel;

/** Reference to the label which displays the number of servers currently loaded in the list */
var	transient UILabel						ServerCountLabel;

/** Reference to the combobox containing the gametypes */
var	transient UTUIComboBox					GameTypeCombo;

/** Reference to the search datastore. */
var transient UTDataStore_GameSearchBase	SearchDataStore;

/** Reference to the string list datastore. */
var transient UTUIDataStore_StringList		StringListDataStore;

/** Reference to the menu item datastore. */
var transient UTUIDataStore_MenuItems		MenuItemDataStore;

/** Cached online subsystem pointer */
var transient OnlineSubsystem				OnlineSub;

/** Cached game interface pointer */
var transient OnlineGameInterface			GameInterface;

/** Indices for the button bar buttons */
var	transient int							BackButtonIdx, JoinButtonIdx, RefreshButtonIdx, CancelButtonIdx, SpectateButtonIdx, DetailsButtonIdx, PlayerMutDetailsIdx, AddFavoriteIdx;

/** Indicates that the current gametype was changed externally - submit a new query when possible */
var	private transient bool					bGametypeOutdated, bSpectate;

var	protected	transient	const	name	SearchDSName;

/**
 * Different actions to take when a query completes.
 */
var private transient enum EQueryCompletionAction
{
	/** no query action set */
	QUERYACTION_None,

	/** do nothing when the query completes; default behavior */
	QUERYACTION_Default,

	/**
	 * This is set when the user wants to close the scene but we still have active queries.  When the queries are completed
	 * (either through being cancelled or receiving all results), close the scene.
	 */
	QUERYACTION_CloseScene,

	/**
	 * This is set when the user has chosen a server from the list.  When the queries are completed or cancelled, join the currently selected server.
	 */
	QUERYACTION_JoinServer,

	/**
	 * This is set when the user switches from LAN to Internet or vice versa.  When the queries are completed of cancelled, clear all results and reissue the
	 * current query.
	 */
	QUERYACTION_RefreshAll,

} QueryCompletionAction;

/** stores the password entered by the user when attempting to connect to a server with a password */
var private transient string		ServerPassword;

/** Tooltip which displays the legend for the SB icons */
var	private	transient UIToolTip		ServerBrowserToolTip;

/** called when the user moves a server from the history page to the favorites page */
delegate transient OnAddToFavorite();

/** Go back delegate for this page. */
delegate transient OnBack();

/** Called when the user changes the game type using the combo box */
delegate transient OnSwitchedGameType();

/**
 * Called when we're about the submit a server query.  Usual thing to do is make sure the GameSearch object is up to date
 */
delegate transient OnPrepareToSubmitQuery( UTUITabPage_ServerBrowser Sender );

/** PostInitialize event - Sets delegates for the page. */
event PostInitialize( )
{
	local DataStoreClient DSClient;
	local UTUIList UTComboList;

	Super.PostInitialize();

	// Find the server list.
	ServerList = UIList(FindChild('lstServers', true));
	if(ServerList != none)
	{
		ServerList.OnSubmitSelection = OnServerList_SubmitSelection;
		ServerList.OnValueChanged = OnServerList_ValueChanged;
		ServerList.OnQueryToolTip = None;//QueryServerBrowserToolTip;
		ServerList.OnListElementsSorted = ServerListResorted;

		// the server list's initial sort column
		if ( ServerList.SortComponent != None )
		{
			ServerList.SortComponent.bReversePrimarySorting = true;
		}
	}

	DetailsList = UIList(FindChild('lstDetails', true));
	MutatorList = UIList(FindChild('lstMutators', true));
	PlayerList = UIList(FindChild('lstPlayers', true));

	// Get reference to the refreshing/searching label.
	RefreshingLabel = FindChild('lblRefreshing', true);
	if ( RefreshingLabel != None )
	{
		RefreshingLabel.SetVisibility(false);
	}

	// get a reference to the server count label
	ServerCountLabel = UILabel(FindChild('lblServerCount', true));

	// get a reference to the combo holding the list of gametypes.
	GameTypeCombo = UTUIComboBox(FindChild('cmbGameType', true));
	if ( GameTypeCombo != None )
	{
		UTComboList = UTUIList(GameTypeCombo.ComboList);

		// UTUIComboBox sets this flag on its internal list for some reason - unset it so that the combobox works like
		// it's supposed to.
		if ( UTComboList != None )
		{
			UTComboList.bAllowSaving = true;
		}
	}

	// Get a reference to the datastore we are working with.
	// @todo: This should probably come from the list.
	DSClient = class'UIInteraction'.static.GetDataStoreClient();
	if ( DSClient != None )
	{
		SearchDataStore = UTDataStore_GameSearchBase(DSClient.FindDataStore(SearchDSName));
		StringListDataStore = UTUIDataStore_StringList(DSClient.FindDataStore('UTStringList'));
		MenuItemDataStore = UTUIDataStore_MenuItems(DSClient.FindDataStore('UTMenuItems'));
	}

	// Store a reference to the game interface
	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		GameInterface = OnlineSub.GameInterface;
	}

	// Set the button tab caption.
	SetDataStoreBinding("<Strings:UTGameUI.JoinGame.Servers>");

	AdjustLayout();

	UpdateServerCount();
}

/**
 * Causes this page to become (or no longer be) the tab control's currently active page.
 *
 * @param	PlayerIndex	the index [into the Engine.GamePlayers array] for the player that wishes to activate this page.
 * @param	bActivate	TRUE if this page should become the tab control's active page; FALSE if it is losing the active status.
 * @param	bTakeFocus	specify TRUE to give this panel focus once it's active (only relevant if bActivate = true)
 *
 * @return	TRUE if this page successfully changed its active state; FALSE otherwise.
 */
event bool ActivatePage( int PlayerIndex, bool bActivate, optional bool bTakeFocus=true )
{
	local bool bResult;

	bResult = Super.ActivatePage(PlayerIndex, bActivate, bTakeFocus);

	if ( bResult && bActivate )
	{
		if ( GameTypeCombo != None )
		{
			GameTypeCombo.OnValueChanged = OnGameTypeChanged;
		}

		if ( bGametypeOutdated )
		{
			NotifyGameTypeChanged();
			bGametypeOutdated = false;
		}
	}

	return bResult;
}

/**
 * Called when the owning scene is being closed - provides a hook for the tab page to ensure it's cleaned up all external
 * references (i.e. delegates, etc.)
 */
function Cleanup()
{
	Assert(QueryCompletionAction == QUERYACTION_None);

	if ( GameInterface != None )
	{
		GameInterface.ClearJoinOnlineGameCompleteDelegate(OnJoinGameComplete);
		GameInterface.ClearFindOnlineGamesCompleteDelegate(OnFindOnlineGamesCompleteDelegate);
	}

	// if we're leaving the server browser area - clear all stored server query searches
	if ( SearchDataStore != None )
	{
		SearchDataStore.ClearAllSearchResults();
	}
}

/**
 * Adjusts the layout of the scene based on the current platform
 */
function AdjustLayout()
{
	local UTUIScene UTOwnerScene;
	local UIObject DetailsContainer, BackgroundContainer;

	UTOwnerScene = UTUIScene(GetScene());
	if ( UTOwnerScene != None
	&&	IsConsole() )
	{
		// if we're on a console, a few things need to change in the scene

		// we need to hide the gametype combo
		if ( GameTypeCombo != None )
		{
			GameTypeCombo.SetVisibility(false);
		}

		// hide the details panels
		DetailsContainer = FindChild('pnlDetailsContainer',true);
		if ( DetailsContainer != None )
		{
			DetailsContainer.SetVisibility(false);
		}

		// redock the server count label to the bottom of the background panel
		BackgroundContainer = FindChild('pnlBackgroundContainer', true);
		if ( BackgroundContainer != None )
		{
			ServerCountLabel.SetDockTarget(UIFACE_Bottom, BackgroundContainer, UIFACE_Bottom);
		}
	}
}

/**
 * Wrapper for grabbing a reference to a button bar button.
 */
final function UTUIButtonBarButton GetButtonBarButton( int ButtonIndex )
{
	local UTUIButtonBar ButtonBar;
	local UTUIButtonBarButton Result;

	ButtonBar = GetButtonBar();
	if ( ButtonBar != None )
	{
		if ( ButtonIndex >= 0 && ButtonIndex < ArrayCount(ButtonBar.Buttons) )
		{
			Result = ButtonBar.Buttons[ButtonIndex];
		}
	}

	return Result;
}

/** Sets buttons for the scene. */
function SetupButtonBar(UTUIButtonBar ButtonBar)
{
	ButtonBar.Clear();

	if ( SearchDataStore != None && SearchDataStore.HasOutstandingQueries() )
	{
		BackButtonIdx = INDEX_NONE;
		CancelButtonIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.CancelSearch>", OnButtonBar_CancelQuery);
	}
	else
	{
		CancelButtonIdx = INDEX_NONE;
		BackButtonIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back);
	}

	JoinButtonIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.JoinServer>", OnButtonBar_JoinServer);
	SpectateButtonIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.SpectateServer>", OnButtonBar_SpectateServer);
	RefreshButtonIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Refresh>", OnButtonBar_Refresh);

	if ( IsConsole() )
	{
		DetailsButtonIdx = ButtonBar.AppendButton( "<Strings:UTGameUI.ButtonCallouts.ServerDetails>", OnButtonBar_ServerDetails );
	}
	else {
		if (MutatorList != none && PlayerList != none)
		{
			PlayerMutDetailsIdx = ButtonBar.AppendButton( "<Strings:UTGameUI.JoinGame.Players>", OnButtonBar_PlayerDetails );
			PlayerList.SetVisibility(false);
			MutatorList.SetVisibility(true);
		}
	}

	SetupExtraButtons(ButtonBar);

	UpdateButtonStates();
}

/**
 * Provides an easy way for child classes to add additional buttons before the ButtonBar's button states are updated
 */
function SetupExtraButtons( UTUIButtonBar ButtonBar )
{
	if ( ButtonBar != None )
	{
		AddFavoriteIdx = ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.AddToFavorite>", OnButtonBar_AddFavorite);
	}
}

/**
 * Updates the enabled state of certain button bar buttons depending on whether a server is selected or not.
 */
function UpdateButtonStates()
{
	local UTUIFrontEnd UTOwnerScene;
	local UTUIButtonBar ButtonBar;
	local UITabControl TabControlOwner;
	local OnlineGameSearchResult SelectedGame;
	local bool bValidServerSelected, bHasPendingSearches, bIsLANMatch, bIsCampaignMode;
	local bool bPlayerMutButEnabled, bGameComboEnabled;
	local int PlayerIndex, CurrentGameMode;
	local string OutVal;

	TabControlOwner = GetOwnerTabControl();
	if ( TabControlOwner != None )
	{
		if ( TabControlOwner.ActivePage == Self )
		{
			UTOwnerScene = UTUIFrontEnd(GetScene());
			ButtonBar = GetButtonBar();
			if ( ButtonBar != None )
			{
				PlayerIndex = UTOwnerScene.GetPlayerIndex();
				bHasPendingSearches = SearchDataStore.HasOutstandingQueries();
				bValidServerSelected = ServerList != None && ServerList.GetCurrentItem() != INDEX_NONE;

				//Get the currently selected server information
				if (bValidServerSelected)
				{
					SearchDataStore.GetSearchResultFromIndex(ServerList.GetCurrentItem(), SelectedGame);
					if (SelectedGame.GameSettings != None)
					{
						bIsLANMatch = SelectedGame.GameSettings.bIsLanMatch;
					}
				}

				if ( CancelButtonIdx != INDEX_NONE )
				{
					if ( bHasPendingSearches )
					{
						ButtonBar.Buttons[CancelButtonIdx].SetEnabled(QueryCompletionAction==QUERYACTION_None, PlayerIndex);
					}
					else
					{
						ButtonBar.SetButton(CancelButtonIdx, "<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back);
						BackButtonIdx = CancelButtonIdx;
						CancelButtonIdx = INDEX_NONE;
					}
				}
				else if ( BackButtonIdx != INDEX_NONE )
				{
					if ( bHasPendingSearches )
					{
						ButtonBar.SetButton(BackButtonIdx, "<Strings:UTGameUI.ButtonCallouts.CancelSearch>", OnButtonBar_CancelQuery);
						CancelButtonIdx = BackButtonIdx;
						BackButtonIdx = INDEX_NONE;

						ButtonBar.Buttons[CancelButtonIdx].SetEnabled(QueryCompletionAction==QUERYACTION_None, PlayerIndex);
					}
					else
					{
						ButtonBar.Buttons[BackButtonIdx].SetEnabled(true, PlayerIndex);
					}
				}

				// we must have a valid server selected in order to activate the Join Server button
				if ( JoinButtonIdx != INDEX_NONE )
				{
					ButtonBar.Buttons[JoinButtonIdx].SetEnabled(bValidServerSelected, PlayerIndex);
				}

				// Don't allow spectating a campaign game
				if ( SpectateButtonIdx != INDEX_NONE )
				{
					if (SelectedGame.GameSettings != None)
					{
						if (SelectedGame.GameSettings.GetStringSettingValue(CONTEXT_GAME_MODE, CurrentGameMode))
						{
							bIsCampaignMode = (CurrentGameMode == CONTEXT_GAME_MODE_CAMPAIGN);
						}
					}

					ButtonBar.Buttons[SpectateButtonIdx].SetEnabled(bValidServerSelected && !bIsCampaignMode, PlayerIndex);
				}

				// Can't add LAN games as favorites
				if ( AddFavoriteIdx != INDEX_NONE )
				{								   
					ButtonBar.Buttons[AddFavoriteIdx].SetEnabled(!bHasPendingSearches && bValidServerSelected && !bIsLANMatch && !HasSelectedServerInFavorites(GetBestControllerId()));
				}

				// Can't see player lists in LAN games (force mutator uilist)
				if (PlayerMutDetailsIdx != INDEX_NONE )
				{								   
					bPlayerMutButEnabled = !bHasPendingSearches && bValidServerSelected && !bIsLANMatch;
					
					//If we are about to disable the button force the mutators list
					if (ButtonBar.Buttons[PlayerMutDetailsIdx].IsEnabled() && !bPlayerMutButEnabled)
					{
                        //Every time a server update refresh happens, we don't want to switch back to mutators
						if (bIsLANMatch)
						{
							OnButtonBar_MutatorDetails(GetButtonBarButton(PlayerMutDetailsIdx), PlayerIndex);
						}
					}
					
					ButtonBar.Buttons[PlayerMutDetailsIdx].SetEnabled(bPlayerMutButEnabled);
				}

				// the refresh button and gametype combo can only be enabled if there are no searches currently working
				if ( RefreshButtonIdx != INDEX_NONE && UTOwnerScene.ButtonBar.Buttons[RefreshButtonIdx] != None )
				{
					ButtonBar.Buttons[RefreshButtonIdx].SetEnabled(!bHasPendingSearches, PlayerIndex);
				}

				if ( GameTypeCombo != None )
				{
					GetDataStoreStringValue("<Registry:ListAllGameModes>", OutVal);
					bGameComboEnabled = !bool(OutVal) && (GetDesiredMatchType() != SERVERBROWSER_SERVERTYPE_LAN);

					GameTypeCombo.SetEnabled(!bHasPendingSearches && bGameComboEnabled, PlayerIndex);
				}

				// we must have a valid server selected in order to activate the Server Details button.
				if (IsConsole()
				&&	DetailsButtonIdx != INDEX_NONE
				&&	ButtonBar.Buttons[DetailsButtonIdx] != None)
				{
					ButtonBar.Buttons[DetailsButtonIdx].SetEnabled(bValidServerSelected, PlayerIndex);
				}
			}
		}
		else if ( UTUITabPage_ServerBrowser(TabControlOwner.ActivePage) != None )
		{
			UTUITabPage_ServerBrowser(TabControlOwner.ActivePage).UpdateButtonStates();
		}
	}
}

/**
 * Determines if the currently selected server is password protected.
 *
 * @return	TRUE if a valid server is selected and it is password protected; FALSE otherwise.
 */
function bool ServerIsPrivate()
{
	local bool bResult;
	local string LockedServerValueString;

	if ( GetDataStoreStringValue("<" $ SearchDSName $ ":CurrentServerDetails.LockedServer>", LockedServerValueString, GetScene(), GetPlayerOwner()) )
	{
		bResult = bool(LockedServerValueString);
	}

	return bResult;
}

/**
 * Displays a dialog to the user which allows him to enter the password for the currently selected server.
 */
private final function PromptForServerPassword()
{
	local UTUIScene UTSceneOwner;
	local UTUIScene_InputBox PasswordInputScene;

	ServerPassword = "";
	UTSceneOwner = UTUIScene(GetScene());
	if ( UTSceneOwner != None )
	{
		PasswordInputScene = UTSceneOwner.GetInputBoxScene();
		if ( PasswordInputScene != None )
		{
			PasswordInputScene.SetPasswordMode(true);
			PasswordInputScene.DisplayAcceptCancelBox(
				"<Strings:UTGameUI.MessageBox.EnterServerPassword_Message>",
				"<Strings:UTGameUI.MessageBox.EnterServerPassword_Title>",
				OnPasswordDialog_Closed
				);
		}
		else
		{
			LogInternal("Failed to open the input box scene (" $ UTSceneOwner.InputBoxScene $ ")");
		}
	}
}

/**
 * The user has made a selection of the choices available to them.
 */
private final function OnPasswordDialog_Closed(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex)
{
	local UTUIScene_InputBox PasswordInputScene;

	PasswordInputScene = UTUIScene_InputBox(MessageBox);
	if ( PasswordInputScene != None && SelectedOption == 0 )
	{
		// strip out all
		ServerPassword = class'UTUIFrontEnd_HostGame'.static.StripInvalidPasswordCharacters(PasswordInputScene.GetValue());
		ProcessJoin();
	}
	else
	{
		ServerPassword = "";
	}
}

/** Joins the currently selected server. */
function JoinServer()
{
	local UTUIScene UTScene;
	local int CurrentSelection;

	if ( AllowJoinServer() )
	{
		UTScene = UTUIScene(GetScene());
		if(UTScene != None)
		{
			CurrentSelection = ServerList.GetCurrentItem();
			if ( CurrentSelection >= 0 )
			{
				if ( ServerIsPrivate() && ServerPassword == "" )
				{
					PromptForServerPassword();
				}
				else
				{
					ProcessJoin();
				}
			}
		}
	}
}

private function ProcessJoin()
{
	local UTUIScene UTScene;
	local OnlineGameSearchResult GameToJoin;
	local int ControllerId, CurrentSelection;
	local UTQueryHelper QH;

	UTScene = UTUIScene(GetScene());
	if(UTScene.ConditionallyCheckNumControllers())	// Check to make sure that the player has 2 controllers connected if they are trying to join as splitscreen.
	{
		if ( GameInterface != None )
		{
			CurrentSelection = ServerList.GetCurrentItem();
			if(SearchDataStore.GetSearchResultFromIndex(CurrentSelection, GameToJoin))
			{
				LogInternal(Name$"::"$GetFuncName()@"- Joining Search Result " $ CurrentSelection);

				// Play the startgame sound
				PlayUISound('StartGame');

				// Check for split screen
				UTUIScene(GetScene()).ConditionallyStartSplitscreen();

				if (GameToJoin.GameSettings != None)
				{
					// Set the delegate for notification
					GameInterface.AddJoinOnlineGameCompleteDelegate(OnJoinGameComplete);

					// Start the async task
					ControllerId = GetBestControllerId();
					if (!GameInterface.JoinOnlineGame(ControllerId,GameToJoin) && GameToJoin.GameSettings.ServerIP != "")
					{
						// Joining through Gamespy failed; ask if the client wants to connect directly
						QH = Class'UTQueryHelper'.static.GetQueryHelper(UTScene);

						// We don't want the URL parameter to contain 'Open ', so strip the first 5 characters from BuildJoinURL
						QH.DisplayFindIPError(True, Mid(BuildJoinURL(GameToJoin.GameSettings.ServerIP), 5));
					}
				}
				else
				{
					LogInternal(Name$"::"$GetFuncName()@"- Failed to join game because of a NULL GameSettings object in the search result.");
					OnJoinGameComplete(false);
				}
			}
			else
			{
				bSpectate = false;
				ServerPassword = "";
				LogInternal(Name$"::"$GetFuncName()@"- Unable to get search result for index "$CurrentSelection);
			}
		}
		else
		{
			bSpectate = false;
			ServerPassword = "";
			LogInternal(Name$"::"$GetFuncName()@"- Unable to join game, GameInterface is NULL!");
		}
	}
	else
	{
		bSpectate = false;
		ServerPassword = "";
	}
}

/** Callback for when the join completes. */
function OnJoinGameComplete(bool bSuccessful)
{
	local string URL;
	local UTUIScene UTOwnerScene;

	LogInternal(Name$"::"$GetFuncName()@"bSuccessful:'"$bSuccessful$"'");

	// Figure out if we have an online subsystem registered
	if (GameInterface != None)
	{
		if (bSuccessful)
		{
			// Get the platform specific information
			if (GameInterface.GetResolvedConnectString(URL))
			{
				UTOwnerScene = UTUIScene(GetScene());

				// Call the game specific function to appending/changing the URL
				URL = BuildJoinURL(URL);

				// @TODO: This is only temporary
				URL $= "?name=" $ UTOwnerScene.GetPlayerName();

				LogInternal(Name$"::"$GetFuncName()@"- Join Game Successful, Traveling: "$URL$"");

				// Get the resolved URL and build the part to start it
				UTOwnerScene.ConsoleCommand(URL);
			}
		}
		else
		{
			// display error message
		}

		// Remove the delegate from the list
		GameInterface.ClearJoinOnlineGameCompleteDelegate(OnJoinGameComplete);
	}

	bSpectate = false;
	ServerPassword = "";
}

/**
 * Builds the string needed to join a game from the resolved connection:
 *		"open 172.168.0.1"
 *
 * NOTE: Overload this method to modify the URL before exec-ing it
 *
 * @param ResolvedConnectionURL the platform specific URL information
 *
 * @return the final URL to use to open the map
 */
function string BuildJoinURL(string ResolvedConnectionURL)
{
	local string ConnectURL;

	ConnectURL = "open " $ ResolvedConnectionURL;
	if ( ServerPassword != "" )
	{
		ConnectURL $= "?Password=" $ ServerPassword;
	}

	if ( bSpectate )
	{
		ConnectURL $= "?SpectatorOnly=1";
	}

	return ConnectURL;
}

/**
 * Refreshes the server list by submitting a new query if certain conditions are met.
 */
function ConditionalRefreshServerList( int PlayerIndex )
{
	local bool bHasExistingResults, bHasOutstandingQueries;

	bHasExistingResults = SearchDataStore.HasExistingSearchResults();
	bHasOutstandingQueries = SearchDataStore.HasOutstandingQueries();

	// if we don't have any results for this gametype yet (either this is our first time switching to it or
	// we didn't find any servers last time) and we don't have an existing search pending, start a search using the new gametype.
	if ( !bHasExistingResults && !bHasOutstandingQueries )
	{
		// fire the query!
		RefreshServerList(PlayerIndex);
	}
	else
	{
		if ( bHasExistingResults )
		{
			// refresh the list with the items from the currently selected gametype's cached query
			ServerList.RefreshSubscriberValue();
		}

		// update the server count label with the number of servers received so far for this gametype
		UpdateServerCount();
	}
}

function int GetDesiredMatchType()
{
	local int Result;

	// Get the match type based on the platform.
	if( IsConsole(CONSOLE_XBox360) )
	{
		Result = StringListDataStore.GetCurrentValueIndex('MatchType360');
	}
	else
	{
		Result = StringListDataStore.GetCurrentValueIndex('MatchType');
	}
	return Result;
}

/** called when the list is resorted (can be triggered by manual resort from user input or automatic resort from new elements added */
function ServerListResorted( UIList Sender )
{
	RefreshDetailsList();
}

/** Refreshes the server list. */
function RefreshServerList(int InPlayerIndex, optional int MaxResults=1000)
{
	local OnlineGameSearch GameSearch;
	local int ValueIndex;

	if ( !SearchDataStore.HasOutstandingQueries() )
	{
		// Play the refresh sound
		PlayUISound('RefreshServers');

		// Get current filter from the string list datastore
		GameSearch = SearchDataStore.GetCurrentGameSearch();

		// Set max results
		GameSearch.MaxSearchResults = MaxResults;

		// Get the match type based on the platform.
		ValueIndex = GetDesiredMatchType();
		switch(ValueIndex)
		{
		case SERVERBROWSER_SERVERTYPE_LAN:
			LogInternal(Name$"::"$GetFuncName()@ "- Searching for a LAN match.",'DevOnline');
			GameSearch.bIsLanQuery=TRUE;
			GameSearch.bUsesArbitration=FALSE;
			break;

		case SERVERBROWSER_SERVERTYPE_RANKED:
			if ( IsConsole(CONSOLE_XBox360) )
			{
				LogInternal(Name$"::"$GetFuncName()@ "- Searching for a ranked match.",'DevOnline');
				GameSearch.bIsLanQuery=FALSE;
				GameSearch.bUsesArbitration=TRUE;
				break;
			}

			// falls through - platform doesn't support ranked matches.

		case SERVERBROWSER_SERVERTYPE_UNRANKED:
			LogInternal(Name$"::"$GetFuncName()@ "- Searching for an unranked match.",'DevOnline');
			GameSearch.bIsLanQuery=FALSE;
			GameSearch.bUsesArbitration=FALSE;
			break;
		}

		SubmitServerListQuery(InPlayerIndex);
	}
}

/**
 * Submits a query for the list of servers which match the current configuration.
 */
function SubmitServerListQuery( int PlayerIndex )
{
	LogInternal(Name$"::"$GetFuncName()@"QueryActive:'"$SearchDataStore.HasOutstandingQueries()$"'"@"ExistingResults:'"$SearchDataStore.HasExistingSearchResults()$"'",'DevOnline');

	OnPrepareToSubmitQuery( Self );

	// show the "refreshing" label
	if(RefreshingLabel != None)
	{
		RefreshingLabel.SetVisibility(true);
	}

	// Add a delegate for when the search completes.  We will use this callback to do any post searching work.
	GameInterface.AddFindOnlineGamesCompleteDelegate(OnFindOnlineGamesCompleteDelegate);

	// Start a search
	if ( !SearchDataStore.SubmitGameSearch(class'UIInteraction'.static.GetPlayerControllerId(PlayerIndex), false) )
	{
		RefreshingLabel.SetVisibility(false);
	}

	// update the server count label and button states while we're waiting for the query results
	UpdateServerCount();
	UpdateButtonStates();
}

/**
 * Delegate fired each time a new server is received, or when the action completes (if there was an error)
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
function OnFindOnlineGamesCompleteDelegate(bool bWasSuccessful)
{
	local bool bSearchCompleted;

	bSearchCompleted = !SearchDataStore.HasOutstandingQueries();
	LogInternal(Name$"::"$GetFuncName()@ "bWasSuccessful:'"$bWasSuccessful$"'" @ "bSearchCompleted:'"$bSearchCompleted$"'",'DevOnline');

	// Hide refreshing label.
	if ( RefreshingLabel != None )
	{
		RefreshingLabel.SetVisibility(false);
	}

	// update the server count label
	UpdateServerCount();

	if ( bSearchCompleted )
	{
		// Clear delegate
		GameInterface.ClearFindOnlineGamesCompleteDelegate(OnFindOnlineGamesCompleteDelegate);

		OnFindOnlineGamesComplete(bWasSuccessful);
	}

	// update the enabled state of the button bar buttons
	UpdateButtonStates();
}

/**
 * Delegate fired when the search for an online game has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
function OnFindOnlineGamesComplete(bool bWasSuccessful)
{
	local UTUIScene UTOwnerScene;
	local UTUIScene_MessageBox MessageBoxScene;

	UTOwnerScene = UTUIScene(GetScene());
	if ( QueryCompletionAction != QUERYACTION_None )
	{
		MessageBoxScene = UTUIScene_MessageBox(UTOwnerScene.MessageBoxScene);

		if ( MessageBoxScene != None && MessageBoxScene.IsSceneActive(true) )
		{
			MessageBoxScene.OnClosed = MessageBoxClosed;
			MessageBoxScene.Close();
		}
		else
		{
			OnCancelSearchComplete(true);
		}
	}
	else
	{
		//Update the details of the server we have currently selected
		OnServerList_ValueChanged(self, GetBestPlayerIndex());
	}
}

/**
 * Handler for the message box scene's OnClose delegate when we're displaying a modal dialog while waiting for the active
 * query to complete.
 */
function MessageBoxClosed()
{
	// simulate the cancel succeeding - this function does everything we need to do
	OnCancelSearchComplete(true);
}

/**
 * Determine if we're in the right state to join a server (cancels any pending queries, etc.)
 *
 * @return	TRUE if joining a server should be allowed; FALSE if there a query is still active - will join the server
 *			when it's safe to do so.
 */
function bool AllowJoinServer()
{
	local bool bResult;

	bResult = true;
	if ( GameInterface != None )
	{
		// see if we still have searches pending
		if ( SearchDataStore != None && SearchDataStore.HasOutstandingQueries() )
		{
			// don't allow the scene to close
			bResult = false;

			// we will join the selected server when the query is complete
			CancelQuery(QUERYACTION_JoinServer);
		}
	}

	return bResult;
}

/**
 * Determine if we're in the right state to close the "Join Game" scene (cancels any pending queries, etc.)
 *
 * @return	TRUE if closing the scene should be allowed; FALSE if there a query is still active - will close the scene
 *			when it's safe to do so.
 */
function bool AllowCloseScene()
{
	local bool bResult;

	bResult = true;
	if ( GameInterface != None )
	{
		// see if we still have searches pending
		if ( SearchDataStore != None && SearchDataStore.HasOutstandingQueries() )
		{
			// don't allow the scene to close
			bResult = false;

			// we will close the scene when the query is complete
			CancelQuery(QUERYACTION_CloseScene);
		}
	}

	return bResult;
}

/**
 * Fires an asynchronous task to cancels all active queries.
 *
 * @param	DesiredCancelAction		specifies what should happen when the asynchronous task completes.
 */
function CancelQuery( optional EQueryCompletionAction DesiredCancelAction=QUERYACTION_Default )
{
	if ( QueryCompletionAction == QUERYACTION_None )
	{
		QueryCompletionAction = DesiredCancelAction;
		if ( SearchDataStore == None || SearchDataStore.HasOutstandingQueries() )
		{
			// we don't check for none so that we get warning in the log if GameInterface is none (this would be bad)
			GameInterface.AddCancelFindOnlineGamesCompleteDelegate(OnCancelSearchComplete);
			GameInterface.CancelFindOnlineGames();
		}
		else if ( SearchDataStore.HasExistingSearchResults() )
		{
			OnCancelSearchComplete(true);
		}
	}
	else
	{
		LogInternal("Could not cancel query because query cancel already in progress:" @ GetEnum(enum'EQueryCompletionAction', QueryCompletionAction));
	}
}

/**
 * Handler for the 'cancel query' asynchronous task completion.  Performs the actions dictated by the current QueryCompletionAction, as
 * set when CancelQuery was called.
 */
function OnCancelSearchComplete( bool bWasSuccessful )
{
	local EQueryCompletionAction CurrentAction;
	local UTUIScene UTOwnerScene;
	local UTUIScene_MessageBox MessageBoxScene;

	if (RefreshingLabel != None)
	{
		RefreshingLabel.SetVisibility(false);
	}
	
	if ( bWasSuccessful )
	{
		CurrentAction = QueryCompletionAction;
		QueryCompletionAction = QUERYACTION_None;

		switch ( CurrentAction )
		{
		case QUERYACTION_CloseScene:
			UTOwnerScene = UTUIScene(GetScene());
			UTOwnerScene.CloseScene(UTOwnerScene);
			break;

		case QUERYACTION_JoinServer:
			JoinServer();
			break;

		case QUERYACTION_RefreshAll:
			// if we're leaving the server browser area - clear all stored server query searches
			if ( SearchDataStore != None )
			{
				SearchDataStore.ClearAllSearchResults();
			}
			break;

		default:
			// don't do anything - just update the enabled state of the button bar buttons
			UpdateButtonStates();
			break;
		}
	}
	else if ( QueryCompletionAction != QUERYACTION_None )
	{
		// looks like we'll have to wait until the query completes on its own; since we're going to take some action
		// when the query completes, we'll need to display a dialog to the user so that they know what the holdup is
		UTOwnerScene = UTUIScene(GetScene());
		MessageBoxScene = UTOwnerScene.GetMessageBoxScene();

		// show the messagebox scene - when we receive the call to OnFindOnlineGamesCompleteDelegate with HasOutstandingQueries() == false,
		// the message box will be closed and this method will be called again.
		MessageBoxScene.DisplayModalBox("<Strings:UTGameUI.MessageBox.QueryPending_Message>");
	}
}

/**
 * Updates the server count label with the number of servers received so far for the currently selected gametype.
 */
function UpdateServerCount()
{
	local int ServerCount;
	local OnlineGameSearch CurrentSearch;

	if ( ServerCountLabel != None && SearchDataStore != None )
	{
		CurrentSearch = SearchDataStore.GetCurrentGameSearch();
		if ( CurrentSearch != None )
		{
			ServerCount = CurrentSearch.Results.Length;
		}
	}

	SetDataStoreStringValue("<SceneData:NumServersReceived>", string(ServerCount), GetScene(), GetPlayerOwner(GetBestPlayerIndex()));
	if ( ServerCountLabel != None )
	{
		ServerCountLabel.RefreshSubscriberValue();
	}
}

/** Refreshes the game details list using the currently selected item in the server list. */
function RefreshDetailsList()
{
	if ( SearchDataStore != None )
	{
		SearchDataStore.ServerDetailsProvider.SearchResultsRow = ServerList.GetCurrentItem();
	}

	if (DetailsList != None)
	{
		DetailsList.RefreshSubscriberValue();
	}

	if (MutatorList != None)
	{
	   MutatorList.RefreshSubscriberValue();
	}
	
	if (PlayerList != None)
	{
	   PlayerList.RefreshSubscriberValue();
	}
}

/**
 * Opens a custom UIScene which displays more verbose details about the server currently selected in the server browser.
 * Console only.
 */
function ShowServerDetails()
{
	local int ServerIndex;

	if ( SearchDataStore != None )
	{
		ServerIndex = SearchDataStore.ServerDetailsProvider.SearchResultsRow;
		if ( ServerIndex != INDEX_NONE )
		{
			UTUIScene(GetScene()).OpenSceneByName("UI_Scenes_FrontEnd.Popups.ServerDetails");
		}
		else
		{
			//@todo - play error sound?  this shouldn't happen because we disable the button in this case.
		}
	}
}

/**
 * Provides a hook for unrealscript to respond to input using actual input key names (i.e. Left, Tab, etc.)
 *
 * Called when an input key event is received which this widget responds to and is in the correct state to process.  The
 * keys and states widgets receive input for is managed through the UI editor's key binding dialog (F8).
 *
 * This delegate is called BEFORE kismet is given a chance to process the input.
 *
 * @param	EventParms	information about the input event.
 *
 * @return	TRUE to indicate that this input key was processed; no further processing will occur on this input key event.
 */
function bool HandleInputKey( const out InputEventParameters EventParms )
{
	local bool bResult;

	bResult=false;

	if(EventParms.EventType==IE_Released)
	{
		if ( EventParms.InputKeyName=='XboxTypeS_X' )
		{
			OnButtonBar_Refresh(GetButtonBarButton(RefreshButtonIdx), EventParms.PlayerIndex);
			bResult=true;
		}
		else if( EventParms.InputKeyName=='XboxTypeS_B' || EventParms.InputKeyName=='Escape' )
		{
			if ( BackButtonIdx != INDEX_NONE )
			{
				OnButtonBar_Back(GetButtonBarButton(BackButtonIdx), EventParms.PlayerIndex);
			}
			else if ( CancelButtonIdx != INDEX_NONE )
			{
				OnButtonBar_CancelQuery(GetButtonBarButton(CancelButtonIdx), EventParms.PlayerIndex);
			}
			bResult=true;
		}
		else if ( EventParms.InputKeyName == 'XboxTypeS_Y' && IsConsole() )
		{
			OnButtonBar_ServerDetails(GetButtonBarButton(DetailsButtonIdx), EventParms.PlayerIndex);
			bResult = true;
		}
		else if ( EventParms.InputKeyName == 'XboxTypeS_LeftTrigger' )
		{
			OnButtonBar_SpectateServer(GetButtonBarButton(SpectateButtonIdx), EventParms.PlayerIndex);
			bResult = true;
		}

		//@todo ronp - cancel search on console?
		//else
	}

	return bResult;
}

/** ButtonBar - JoinServer */
function bool OnButtonBar_JoinServer(UIScreenObject InButton, int InPlayerIndex)
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		// we must have a valid server selected in order to activate the Join Server button
		JoinServer();
	}
	return true;
}

function bool OnButtonBar_SpectateServer(UIScreenObject InButton, int InPlayerIndex)
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		bSpectate = true;

		// we must have a valid server selected in order to activate the Spectate Server button
		JoinServer();
	}
	return true;
}

/** ButtonBar - Back */
function bool OnButtonBar_Back(UIScreenObject InButton, int InPlayerIndex)
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		OnBack();
	}
	return true;
}

/** ButtonBar - Refresh */
function bool OnButtonBar_Refresh(UIScreenObject InButton, int InPlayerIndex)
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		RefreshServerList(InPlayerIndex);
		if (ServerList.CanAcceptFocus())
		{
			ServerList.SetFocus(none);
		}
	}
	return true;
}

function bool OnButtonBar_CancelQuery( UIScreenObject InButton, int inPlayerIndex )
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		CancelQuery();
		if (ServerList.CanAcceptFocus())
		{
			ServerList.SetFocus(none);
		}
	}
	return true;
}

/** ButtonBar - ServerDetails (console only) */
function bool OnButtonBar_ServerDetails( UIScreenObject InButton, int InPlayerIndex )
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		ShowServerDetails();
	}
	return true;
}

function bool OnButtonBar_PlayerDetails( UIScreenObject InButton, int InPlayerIndex )
{
	local UTUIButtonBar ButtonBar;
	ButtonBar = GetButtonBar();
	if ( ButtonBar != None && InButton != None && InButton.IsEnabled(InPlayerIndex) && MutatorList != None && PlayerList != None )
	{
		MutatorList.SetVisibility(false);
		PlayerList.SetVisibility(true);
		ButtonBar.SetButton(PlayerMutDetailsIdx, "<Strings:UTGameUI.Frontend.TabCaption_Mutators>", OnButtonBar_MutatorDetails);
		if (ServerList.CanAcceptFocus())
		{
		   ServerList.SetFocus(none);
		}
	}
	return true;
}

function bool OnButtonBar_MutatorDetails( UIScreenObject InButton, int InPlayerIndex )
{
	local UTUIButtonBar ButtonBar;
	ButtonBar = GetButtonBar();
	if ( ButtonBar != None && InButton != None && InButton.IsEnabled(InPlayerIndex) && MutatorList != None && PlayerList != None  )
	{
		PlayerList.SetVisibility(false);
		MutatorList.SetVisibility(true);
		ButtonBar.SetButton(PlayerMutDetailsIdx, "<Strings:UTGameUI.Campaign.PlayerLabel>", OnButtonBar_PlayerDetails);
		if (ServerList.CanAcceptFocus())
		{
			ServerList.SetFocus(none);
		}
	}
	return true;
}

/** Server List - Submit Selection. */
function OnServerList_SubmitSelection( UIList Sender, int PlayerIndex )
{
	OnButtonBar_JoinServer(GetButtonBarButton(JoinButtonIdx), PlayerIndex);
}

/** Server List - Value Changed. */
function OnServerList_ValueChanged( UIObject Sender, int PlayerIndex )
{
	local int CurrentSelection;
	local OnlineGameSearchResult SelectedGame;

	RefreshDetailsList();
	if ( IsVisible() )
	{
		if (!SearchDataStore.HasOutstandingQueries())
		{
			//Fire off a query to get extended data
			CurrentSelection = ServerList.GetCurrentItem();
			if ( SearchDataStore.GetSearchResultFromIndex(CurrentSelection, SelectedGame) && SelectedGame.GameSettings.bIsLanMatch == false )
			{
				// Add a delegate for when the search completes.  We will use this callback to do any post searching work.
				GameInterface.AddFindOnlineGamesCompleteDelegate(OnUpdateServerComplete);
				if (GameInterface.QueryAuxServerInfo(PlayerIndex, SearchDataStore.GetCurrentGameSearch(), SelectedGame) == false)
				{
					OnUpdateServerComplete(false);
				}
			}
		}

		UpdateButtonStates();
	}
	else
	{
		bGametypeOutdated = true;
	}
}

//Called after the individual server updates are complete (player names/etc)
function OnUpdateServerComplete(bool bWasSuccessful)
{
	if (bWasSuccessful)
	{	   
		RefreshDetailsList();
		if ( IsVisible() )
		{
			UpdateButtonStates();
		}
	}

	//Don't clear the delegate if we have other outstanding queries
	if ( !SearchDataStore.HasOutstandingQueries() )
	{
		GameInterface.ClearFindOnlineGamesCompleteDelegate(OnUpdateServerComplete);
	}
}

/** ButtonBar - Add to favorite */
function bool OnButtonBar_AddFavorite(UIScreenObject InButton, int InPlayerIndex)
{
	if ( InButton != None && InButton.IsEnabled(InPlayerIndex) )
	{
		AddToFavorites(InPlayerIndex);
		if (ServerList.CanAcceptFocus())
		{
			ServerList.SetFocus(none);
		}
	}
	return true;
}

/**
* Adds the selected server to the list of favorites
*/
function AddToFavorites( int inPlayerIndex )
{
	local int CurrentSelection, ControllerId;
	local OnlineGameSearchResult SelectedGame;
	local UTDataStore_GameSearchFavorites FavsDataStore;
	local UITabControl TabControlOwner;

	CurrentSelection = ServerList.GetCurrentItem();

	if ( SearchDataStore.GetSearchResultFromIndex(CurrentSelection, SelectedGame) )
	{
		ControllerId = GetBestControllerId();
		FavsDataStore = GetFavoritesDataStore();

		// if this server isn't already in the list of favorites
		if ( FavsDataStore != None && !HasServerInFavorites(ControllerId, SelectedGame.GameSettings.OwningPlayerId) )
		{
			// add it
			if (FavsDataStore.AddServerPlusIP(ControllerId, SelectedGame.GameSettings.OwningPlayerId, SelectedGame.GameSettings.OwningPlayerName,
								SelectedGame.GameSettings.ServerIP))
			{
				TabControlOwner = GetOwnerTabControl();
				if ( TabControlOwner != None && TabControlOwner.ActivePage == Self )
				{
					OnAddToFavorite();
				}

				UpdateButtonStates();
			}
		}
	}
}

/**
 * Retrieve the index in the game search data store's list of search results for the specified gametype class
 *
 * @param	GameClassName	the path name of the gametype to find; if not specified, uses the currently selected gametype
 *
 * @return	the index into the UIDataStore_OnlineGameSearch's GameSearchCfgList array for the gametype specified.
 */
function int GetGameTypeSearchProviderIndex( optional string GameClassName )
{
	local int ProviderIdx;
	local string SearchTag;

	ProviderIdx = INDEX_NONE;
	if ( GameClassName == "" )
	{
		// if no gametype was specified, use the currently selected gametype
		GetDataStoreStringValue("<UTGameSettings:CustomGameMode>", GameClassName);
	}

	if ( GameClassName != "" && MenuItemDataStore != None && SearchDataStore != None )
	{
		// in order to find the search datastore index for the gametype, we need to get its search tag.  This comes from
		// the menu items data store (for some reason)
		// first, find the location of this gametype in the UTMenuItems data store's list of gametypes
		ProviderIdx = MenuItemDataStore.FindValueInProviderSet('GameModeFilter', 'GameMode', GameClassName);

		// now that we know the index into the UTMenuItems data store, we can retrieve the tag that is used to identify the corresponding
		// game search configuration in the Game Search data store.
		if (ProviderIdx != INDEX_NONE
		&&	MenuItemDataStore.GetValueFromProviderSet('GameModeFilter', 'GameSearchClass', ProviderIdx, SearchTag)
		&&	SearchTag != "")
		{
			ProviderIdx = SearchDataStore.FindSearchConfigurationIndex(name(SearchTag));
		}
		else
		{
			// If the gametype has no search class set, default to the custom search object (which will filter for the actual gameclass)
			ProviderIdx = SearchDataStore.FindSearchConfigurationIndex('UTGameSearchCustom');
		}
	}

	return ProviderIdx;
}

/**
 * Called when the user changes the currently selected gametype via the gametype combo.
 *
 * @param	Sender			the UIObject whose value changed
 * @param	PlayerIndex		the index of the player that generated the call to this method; used as the PlayerIndex when activating
 *							UIEvents; if not specified, the value of GetBestPlayerIndex() is used instead.
 */
function OnGameTypeChanged( UIObject Sender, int PlayerIndex )
{
	local int ProviderIdx;
	local array<UIDataStore> BoundDataStores;
	local string GameTypeClassName, OptStr;

	GetDataStoreStringValue("<Registry:ListAllGameModes>", OptStr);

	if (!bool(OptStr) && !IsConsole() && IsVisible()
	&&	GameTypeCombo != None && GameTypeCombo.ComboList != None

	// calling SaveSubscriberValue on the combobox list will set the currently selected gametype as the value for the UTMenuItems:GameModeFilter field
	&&	GameTypeCombo.ComboList.SaveSubscriberValue(BoundDataStores)

	// so now we just retrieve this field
	&&	GetDataStoreStringValue("<UTMenuItems:GameModeFilterClass>", GameTypeClassName))
	{
		// make sure to update the GameSettings value - this is used to build the join URL
		SetDataStoreStringValue("<UTGameSettings:CustomGameMode>", GameTypeClassName);

		// find the index into the GameSearch data store for the gametype with the specified class name
		// *THIS IS NOT THE SAME AS THE MENU ITEM DATASTORE INDEX*
		ProviderIdx = GetGameTypeSearchProviderIndex(GameTypeClassName);
		LogInternal(Name$"::"$GetFuncName()@"- Game mode filter class set to" @ GameTypeClassName @ "(" $ ProviderIdx $ ")");

		if ( ProviderIdx != INDEX_NONE )
		{
			// update the online game search data store's current gametype
			UTDataStore_GameSearchDM(SearchDataStore).CustomGameTypeClass = GameTypeClassName;
			SearchDataStore.SetCurrentByIndex(ProviderIdx, false);
			OnSwitchedGameType();

			ConditionalRefreshServerList(PlayerIndex);
		}
	}
}

/**
 * Notification that the currently selected gametype was changed externally.  Update this tab page to reflect the new
 * gametype.
 */
function NotifyGameTypeChanged()
{
	local string OptStr;

	if ( IsVisible() )
	{
		if (GameTypeCombo != None && !IsConsole())
		{
			GetDataStoreStringValue("<Registry:ListAllGameModes>", OptStr);

			// update the gametype combo to reflect the currently selected gametype.  This will cause OnGameTypeChanged
			// to be called
			if (!bool(OptStr))
				GameTypeCombo.ComboList.RefreshSubscriberValue();
		}
		else
		{
			ConditionalRefreshServerList(GetBestPlayerIndex());
		}
	}
	else
	{
		// set a bool to indicate that a new query should be submitted when this tab page is shown
		bGametypeOutdated = true;
	}
}

/**
 * Called when this widget (or one of its children) becomes the ActiveControl.  Provides a way for child classes or
 * containers to easily override or short-circuit the standard tooltip that is normally shown.  If this delegate is
 * not assigned to any function, the default tool-tip will be displayed if this widget has a data store binding property
 * named "ToolTipBinding" which is bound to a valid data store.
 *
 * @param	Sender			the widget that will be displaying the tooltip
 * @param	CustomToolTip	to provide a custom tooltip implementation, fill in in this value and return TRUE.  The custom
 *							tool tip object will then be activated by native code.
 *
 * @return	return FALSE to prevent any tool-tips from being shown, including parents.
 */
function bool QueryServerBrowserTooltip( UIObject Sender, out UIToolTip CustomToolTip )
{
	local bool bResult;

	if ( ServerBrowserToolTip == None )
	{
		// create our own tooltip to use in the server browser, since we need to alter some of the settings.
		ServerBrowserToolTip = UIToolTip(CreateWidget(ServerList, GetScene().DefaultToolTipClass, None, 'SBLegend'));

		ServerBrowserToolTip.InitializePlayerTracking();
		ServerBrowserToolTip.Initialize(GetScene(), ServerList);
		ServerBrowserToolTip.PostInitialize();

		// sb tooltip will be wrapped
		//<Strings:UTGameUI.JoinGame.IconLegend>
		//<Fonts:UI_Fonts_Final.Menus.UI_Fonts_Icons>0<Fonts:/> <Fonts:UI_Fonts_Final.Menus.Fonts_Positec>Pure Server<Fonts:/>\n<Fonts:UI_Fonts_Final.Menus.UI_Fonts_Icons>7<Fonts:/> <Fonts:UI_Fonts_Final.Menus.Fonts_Positec>Private Server<Fonts:/>\n<Fonts:UI_Fonts_Final.Menus.UI_Fonts_Icons>6<Fonts:/> <Fonts:UI_Fonts_Final.Menus.Fonts_Positec>Allows Keyboard & Mouse<Fonts:/>
		ServerBrowserToolTip.StringRenderComponent.SetWrapMode(CLIP_Wrap);
		ServerBrowserToolTip.StringRenderComponent.SetAutoSizeExtent(UIORIENT_Horizontal, 0.3, 0.0, UIEXTENTEVAL_PercentScene, UIEXTENTEVAL_PercentScene);
		ServerBrowserToolTip.CanShowToolTip = CheckToolTipPosition;
	}

	if ( ServerBrowserToolTip != None )
	{
		CustomToolTip = ServerBrowserToolTip;
		bResult = true;
	}

	return bResult;
}

/**
 * Handler for the tooltip's CanShowToolTip delegate.  Prevents the tooltip timer from being activated if the cursor is not
 * over the correct [first] column.
 *
 * @param	ToolTip		the tooltip, duh
 *
 * @return	TRUE to allow the tooltip to be made visible; FALSE to keep it hidden.
 */
function bool CheckToolTipPosition( UIToolTip Sender )
{
	local bool bResult;
	local CellHitDetectionInfo CellUnderMouse;

	ServerList.GetResizeColumn(CellUnderMouse);
	if ( CellUnderMouse.HitColumn == 0 )
	{
		bResult = true;
	}

	return bResult;

}

/**
 * Wrapper for getting a reference to the favorites data store.  Stub for child classes.
 */
function UTDataStore_GameSearchFavorites GetFavoritesDataStore()
{
	local UTDataStore_GameSearchDM GameSearchDataStore;
	local UTDataStore_GameSearchHistory HistorySearchDataStore;

	GameSearchDataStore = UTDataStore_GameSearchDM(SearchDataStore);
	if (GameSearchDataStore != None)
	{
		HistorySearchDataStore = GameSearchDataStore.HistoryGameSearchDataStore;
		if (HistorySearchDataStore != None)
		{
			return HistorySearchDataStore.FavoritesGameSearchDataStore;
		}
	}

	return None;
}

/**
 * Determines whether the server with the specified Id is in the list of favorites.
 *
 * @param	ControllerId	the index of the controller associated with the logged in player.
 * @param	IdToFind		the UniqueNetId for the server to find
 *
 * @return	TRUE if the specified server is in the list of server favorites.
 */
function bool HasServerInFavorites( int ControllerId, const out UniqueNetId IdToFind )
{
	local bool bResult;
	local UTDataStore_GameSearchFavorites FavsDataStore;

	FavsDataStore = GetFavoritesDataStore();
	if ( FavsDataStore != None && ServerList != None )
	{
		bResult = FavsDataStore.FindServerIndexById(ControllerId, IdToFind) != INDEX_NONE;
	}

	return bResult;
}

/**
 * Wrapper for HasServerInFavorites which encapsulates finding the UniqueNetId for the currently selected server.
 *
 * @param	ControllerId	the index of the controller associated with the logged in player.
 *
 * @return	TRUE if the currently selected server is in the list of server favorites.
 */
function bool HasSelectedServerInFavorites( int ControllerId )
{
	local OnlineGameSearchResult SelectedGame;
	local int CurrentSelection;
	local bool bResult;

	if ( SearchDataStore != None && ServerList != None )
	{
		CurrentSelection = ServerList.GetCurrentItem();
		if ( SearchDataStore.GetSearchResultFromIndex(CurrentSelection, SelectedGame) )
		{
			bResult = HasServerInFavorites(ControllerId, SelectedGame.GameSettings.OwningPlayerId);
		}
	}

	return bResult;
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTTabPage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTTabPage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_ServerBrowser"
   ObjectArchetype=UTTabPage'UTGame.Default__UTTabPage'
}
