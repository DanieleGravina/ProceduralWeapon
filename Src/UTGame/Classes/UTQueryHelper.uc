/**
 * A central helper class for performing non-trivial server queries, such as those required by the 'Join IP' and
 * 'Add IP' buttons in the Join Game and Favourites tabs on the server browser.
 *
 * N.B. This extends Interaction to allow state code execution (Object subclasses don't normally support states)
 *
 * Copyright 2008 Epic Games, Inc. All Rights Reserved
 */
Class UTQueryHelper extends Interaction;










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

enum EQueryError
{
	QE_None,
	QE_Uninitialized,
	QE_QueryInProgress,
	QE_NotLoggedIn,
	QE_InvalidIP,
	QE_InvalidResult,
	QE_JoinFailed,
	QE_Custom
};


var bool bInitialized;
var UTUIScene SceneRef;

var string SearchIP;
var string SearchPort;
var int CurSearchResultIdx; // Cached search result index; not saved as an 'OnlineGameSearchResult', as that is unsafe

var UTDataStore_GameSearchFind SearchDataStore;
var OnlineGameInterface GameInterface;

var bool bDisplayQueryMessage;
var bool bQueryInProgress;

var string JoinPassword;
var bool bJoinSpectate;
var string DirectConnectURL;

var EQueryError LastError;


// Always use this function to get a reference to a query helper (inputting any valid UTUIScene)
static final function UTQueryHelper GetQueryHelper(UTUIScene InScene)
{
	local UTQueryHelper QH;

	QH = UTQueryHelper(FindObject("Transient.QueryHelper", Class'UTQueryHelper'));

	// If there is no existing instance of this object class, create one
	if (QH == none)
		QH = new(none, "QueryHelper") Class'UTQueryHelper';

	if (InScene != none)
		QH.SceneRef = InScene;

	if (!QH.bInitialized)
		QH.Initialize();

	return QH;
}


// ***** Main query functions

// Searches for a single server matching the specified address (set the 'OnFindServerByIPComplete' delegate before calling)
// Returns 'True' if the query began successfully, and 'bQueryMessageBox' determines whether messages will be displayed while querying
function bool FindServerByIP(string Address, optional bool bQueryMessageBox=true)
{
	local int i;
	local array<string> IPTest;

	LastError = QE_None;

	if (bQueryInProgress)
	{
		LastError = QE_QueryInProgress;
		return False;
	}

	if (SearchDataStore == none)
	{
		LastError = QE_Uninitialized;
		return False;
	}

	if (Class'UIInteraction'.static.GetLoginStatus(SceneRef.GetBestPlayerIndex()) != LS_LoggedIn)
	{
		LastError = QE_NotLoggedIn;
		return False;
	}


	i = InStr(Address, ":");

	if (i != INDEX_None)
	{
		SearchIP = Left(Address, i);
		SearchPort = Mid(Address, i+1);
	}
	else
	{
		SearchIP = Address;
		SearchPort = "7777";
	}

	if (int(SearchPort) == 0)
		SearchPort = "7777";


	// Test that the IP is valid
	ParseStringIntoarray(SearchIP, IPTest, ".", True);

	if (IPTest.Length != 4)
	{
		LastError = QE_InvalidIP;
		return False;
	}


	// Set the search data store values
	SearchDataStore.SearchIP = SearchIP;
	SearchDataStore.SearchPort = SearchPort;

	// Kick off the search
	bDisplayQueryMessage = bQueryMessageBox;
	GotoState('FindIPQuery');


	return True;
}

// The result of the search initiated by the above function
delegate OnFindServerByIPComplete(OnlineGameSearchResult Result);


// Searches for and joins the server matching the specified address (parameters are mostly the same as 'FindServerByIP')
// If the server can't be found by Gamespy, then the user is given an option to connect directly, based upon 'FallbackURL'
// NOTE: When this is called, the query handler will automatically release itself
function JoinServerByIP(string Address, optional bool bQueryMessageBox=true, optional bool bSpectate, optional string FallbackURL)
{
	OnFindServerByIPComplete = JoinServerBySearchResult;
	bJoinSpectate = bSpectate;
	DirectConnectURL = FallbackURL;
	LastError = QE_None;

	if (!FindServerByIP(Address, bQueryMessageBox) && bQueryMessageBox)
		DisplayFindIPError(True);
}

// Joins the server specified by the 'Result' parameter
// NOTE: When this is called, the query handler will automatically release itself
function JoinServerBySearchResult(OnlineGameSearchResult Result)
{
	OnFindServerByIPComplete = none;

	if (Result.GameSettings != none)
	{
		GotoState('JoinServerQuery');
		JoinServerBySearchResult(Result);
	}
	else
	{
		if (bDisplayQueryMessage)
			DisplayFindIPError(True);
		else
			Release();
	}
}


// ***** Query states

// State function stubs (implemented within states)
function bool OnSetupQueryFilters(OnlineGameSearch Search);	// Use this to initiate any master-server/clientside filters before searching
function OnFindOnlineGamesUpdate(bool bWasSuccessful);		// Use this to receive regular updates during the query
function OnFindOnlineGamesComplete(bool bWasSuccessful);	// Use this for notification of when the query has finished

function OnCancelFindOnlineGames(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex);
function OnCancelFindOnlineGamesComplete(bool bWasSuccessful);

function BeginJoin(OnlineGameSearchResult JoinTarget, optional string Password);	// Function for kicking off a join game query
function OnJoinGameComplete(bool bSuccessful);						// Internal join game handler

function OnPasswordDialogClosed(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex);


// Base query state, which handles the most generic query code
state QueryBase
{
	// Sets up filters/messages and kicks off the find server query
	function BeginState(name PreviousStateName)
	{
		local UTUIScene_MessageBox MessageBoxScene;

		// Reset error messages
		LastError = QE_None;

		GameInterface.AddFindOnlineGamesCompleteDelegate(OnFindOnlineGamesUpdate);
		SearchDataStore.OnSetupQueryFilters = OnSetupQueryFilters;

		if (bDisplayQueryMessage)
		{
			MessageBoxScene = SceneRef.GetMessageBoxScene();
			MessageBoxScene.DisplayCancelBox("<Strings:UTGameUI.MessageBox.QueryPending_Message>",, OnCancelFindOnlineGames);
		}

		bQueryInProgress = True;
		SearchDataStore.SubmitGameSearch(Class'UIInteraction'.static.GetPlayerControllerId(SceneRef.GetBestPlayerIndex()));
	}

	function OnFindOnlineGamesUpdate(bool bWasSuccessful)
	{
		local UTUIScene_MessageBox MessageBoxScene;

		if (!SearchDataStore.HasOutstandingQueries())
		{
			GameInterface.ClearFindOnlineGamesCompleteDelegate(OnFindOnlineGamesUpdate);

			// Close the 'querying' message box
			MessageBoxScene = SceneRef.GetMessageBoxScene();

			if (MessageBoxScene != none && MessageBoxScene.IsSceneActive(true))
				MessageBoxScene.Close();


			OnFindOnlineGamesComplete(bWasSuccessful);
		}
	}

	// Handles cancelling of the current search
	function OnCancelFindOnlineGames(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex)
	{
		bDisplayQueryMessage = False;

		if (SearchDataStore == none || SearchDataStore.HasOutstandingQueries())
		{
			GameInterface.AddCancelFindOnlineGamesCompleteDelegate(OnCancelFindOnlineGamesComplete);
			GameInterface.CancelFindOnlineGames();
		}
		else
		{
			OnCancelFindOnlineGamesComplete(True);
		}
	}

	function OnCancelFindOnlineGamesComplete(bool bWasSuccessful)
	{
		GameInterface.ClearCancelFindOnlineGamesCompleteDelegate(OnCancelFindOnlineGamesComplete);
		OnFindOnlineGamesComplete(False);
	}

	function EndState(name NextStateName)
	{
		bQueryInProgress = False;
	}
}


// Query for finding a server matching the specified IP and Port
state FindIPQuery extends QueryBase
{
	function bool OnSetupQueryFilters(OnlineGameSearch Search)
	{
		local RawOnlineGameSearchOrClause CurRawFilter;

		Search.bIsLANQuery = False;
		Search.bUsesArbitration = False;
		Search.ResetFilters();

		// Unfortunately, the IP can't be filtered by the master server; however, the port can, so use it to cut down on results
		CurRawFilter.OrParams.Length = 1;
		CurRawFilter.OrParams[0].EntryValue = "hostport";
		CurRawFilter.OrParams[0].ComparisonOperator = "=";
		CurRawFilter.OrParams[0].ComparedValue = "'"$SearchPort$"'";

		Search.RawFilterQueries.AddItem(CurRawFilter);


		return False;
	}

	function OnFindOnlineGamesComplete(bool bWasSuccessful)
	{
		local OnlineGameSearch GameSearch;
		local string Address;
		local int i;
		local OnlineGameSearchResult Result;

		// Iterate the results, looking for a server matching the specified port and IP
		GameSearch = SearchDataStore.GetCurrentGameSearch();
		Address = SearchIP$":"$SearchPort;

		for (i=0; i<GameSearch.Results.Length; ++i)
		{
			if (GameSearch.Results[i].GameSettings.ServerIP == Address)
			{
				Result = GameSearch.Results[i];
				CurSearchResultIdx = i;
				break;
			}
		}


		GotoState('');
		OnFindServerByIPComplete(Result);
	}
}

// State used to handle joining servers
state JoinServerQuery
{
	function JoinServerBySearchResult(OnlineGameSearchResult Result)
	{
		local int LockedValue;
		local UTUIScene_MessageBox MessageBoxScene;
		local UTUIScene_InputBox PasswordInputScene;

		// Reset any previous error messages
		LastError = QE_None;

		// If there is a message box scene fading out, force it to close immediately or it will take new message box scenes with it
		MessageBoxScene = SceneRef.GetMessageBoxScene();

		if (MessageBoxScene != none && MessageBoxScene.bHideOnNextTick)
			MessageBoxScene.OnHideComplete();


		// If the server is passworded, display the password message box; otherwise begin joining immediately
		if (Result.GameSettings.GetStringSettingValue(CONTEXT_LOCKEDSERVER, LockedValue) && LockedValue == CONTEXT_LOCKEDSERVER_YES)
		{
			PasswordInputScene = SceneRef.GetInputBoxScene();

			if (PasswordInputScene.bHideOnNextTick)
			{
				PasswordInputScene.OnHideComplete();
				PasswordInputScene = SceneRef.GetInputBoxScene();
			}

			PasswordInputScene.SetPasswordMode(True);
			PasswordInputScene.DisplayAcceptCancelBox("<Strings:UTGameUI.MessageBox.EnterServerPassword_Message>",
									"<Strings:UTGameUI.MessageBox.EnterServerPassword_Title>",
									OnPasswordDialogClosed);
		}
		else
		{
			BeginJoin(Result);
		}
	}

	// When the password box is closed, begin joining
	function OnPasswordDialogClosed(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex)
	{
		local UTUIScene_InputBox PasswordInputScene;
		local OnlineGameSearchResult CurResult;

		PasswordInputScene = UTUIScene_InputBox(MessageBox);

		if (PasswordInputScene != none && SelectedOption == 0)
		{
			// The current server result can't be safely stored in a non-local variable, so retrieve it based upon the stored index instead
			SearchDataStore.GetSearchResultFromIndex(CurSearchResultIdx, CurResult);

			BeginJoin(CurResult, Class'UTUIFrontEnd_HostGame'.static.StripInvalidPasswordCharacters(PasswordInputScene.GetValue()));

			// Instantly close the password input scene
			PasswordInputScene.OnHideComplete();
		}
		else
		{
			GotoState('');
		}
	}


	function BeginJoin(OnlineGameSearchResult JoinTarget, optional string Password)
	{
		if (JoinTarget.GameSettings == none)
		{
			LastError = QE_InvalidResult;
			DisplayFindIPError(True);

			return;
		}


		JoinPassword = Password;
		SceneRef.ConditionallyStartSplitscreen();

		GameInterface.AddJoinOnlineGameCompleteDelegate(OnJoinGameComplete);
		GameInterface.JoinOnlineGame(SceneRef.GetBestControllerId(), JoinTarget);
	}

	function OnJoinGameComplete(bool bSuccessful)
	{
		local string URL;
		local UTUIScene CurScene;

		GameInterface.ClearJoinOnlineGameCompleteDelegate(OnJoinGameComplete);

		if (bSuccessful)
		{
			GameInterface.GetResolvedConnectString(URL);


			URL = "Open"@URL;

			if (JoinPassword != "")
				URL $= "?Password="$JoinPassword;

			if (bJoinSpectate)
				URL $= "?SpectatorOnly=1";

			URL $= "?Name="$SceneRef.GetPlayerName();


			LogInternal("UTQueryHelper::OnJoinGameComplete: - Join Game Successful, travelling:"@URL);

			// Locally reference 'SceneRef' before it gets cleared in EndState
			CurScene = SceneRef;
			GotoState('');

			CurScene.ConsoleCommand(URL);
		}
		else
		{
			LastError = QE_JoinFailed;
			DisplayFindIPError(True);
		}
	}

	// Since it should be assumed that the QueryHandler will be disused when attempting to join a game, clean up here
	function EndState(name NextStateName)
	{
		Release();
	}
}


// ***** Misc functions

// Initializes default values
function Initialize()
{
	local DataStoreClient DSClient;
	local OnlineSubsystem OS;

	bInitialized = True;
	LastError = QE_None;


	DSClient = Class'UIInteraction'.static.GetDataStoreClient();

	if (DSClient != none)
		SearchDataStore = UTDataStore_GameSearchFind(DSClient.FindDataStore('UTGameFind'));

	OS = Class'GameEngine'.static.GetOnlineSubsystem();

	if (OS != none)
		GameInterface = OS.GameInterface;
}

// Clear volatile values (object references etc.)
singular function Release()
{
	GotoState('');

	if (SearchDataStore != none)
		SearchDataStore.ClearAllSearchResults();

	SceneRef = none;
	SearchDataStore = none;
	GameInterface = none;

	CurSearchResultIdx = INDEX_None;
	bQueryInProgress = False;
	bInitialized = False;
	LastError = QE_None;
}


// Function used to display a message when Gamespy can't find a server, with the option to ask if the client wants to connect directly
function DisplayFindIPError(optional bool bAskForDirectConnect, optional string InDirectConnectURL, optional EQueryError ErrorType=LastError,
	optional string CustomError)
{
	local UTUIScene_MessageBox CurMsg;
	local string ErrorMessage;

	// Reset the last error, so that it doesn't get incorrectly shown again
	LastError = QE_None;

	if (SceneRef != none)
	{
		CurMsg = SceneRef.GetMessageBoxScene();

		if (CurMsg != none)
		{
			// Construct the initial error message
			switch (ErrorType)
			{
			case QE_None:
				ErrorMessage = Localize("MessageBox", "FindServerIPFail_Message", "UTGameUI");
				break;

			case QE_Uninitialized:
				ErrorMessage = Localize("MessageBox", "FindServerIPUninitialized_Message", "UTGameUI");
				break;

			case QE_QueryInProgress:
				ErrorMessage = Localize("MessageBox", "FindServerIPInProgress_Message", "UTGameUI");
				break;

			case QE_NotLoggedIn:
				ErrorMessage = Localize("MessageBox", "FindServerIPNotLoggedIn_Message", "UTGameUI");
				break;

			case QE_InvalidIP:
				ErrorMessage = Localize("MessageBox", "FindServerIPInvalid_Message", "UTGameUI");
				break;

			case QE_InvalidResult:
				ErrorMessage = Localize("MessageBox", "FindServerIPInvalidResult_Message", "UTGameUI");
				break;

			case QE_JoinFailed:
				ErrorMessage = Localize("MessageBox", "FindServerIPJoinFailed_Message", "UTGameUI");
				break;

			case QE_Custom:
				ErrorMessage = CustomError;
				break;
			}


			// Setup the message box
			if (CurMsg.bHideOnNextTick)
			{
				CurMsg.OnHideComplete();
				CurMsg = SceneRef.GetMessageBoxScene();
			}

			if (InDirectConnectURL != "")
				DirectConnectURL = InDirectConnectURL;


			if (bAskForDirectConnect && DirectConnectURL != "" && ErrorType != QE_InvalidIP)
			{
				ErrorMessage @= Localize("MessageBox", "FindServerIPFailConnect_Message", "UTGameUI");
				CurMsg.DisplayAcceptCancelBox(ErrorMessage, "<Strings:UTGameUI.MessageBox.FindServerIPFail_Title>",
								OnFindIPErrorDialog_Closed);
			}
			else
			{
				CurMsg.DisplayAcceptCancelBox(ErrorMessage, "<Strings:UTGameUI.MessageBox.FindServerIPFail_Title>");
			}
		}
	}
}

// Called when the client requests to connect directly
function OnFindIPErrorDialog_Closed(UTUIScene_MessageBox MessageBox, int SelectedOption, int PlayerIndex)
{
	local UTUIScene CurScene;

	if (SelectedOption == 0)
	{
		CurScene = SceneRef;
		Release();

		LogInternal("Direct connect, URL"@DirectConnectURL);
		CurScene.ConsoleCommand("open"@DirectConnectURL);
	}
}

defaultproperties
{
   CurSearchResultIdx=-1
   Name="Default__UTQueryHelper"
   ObjectArchetype=Interaction'Engine.Default__Interaction'
}
