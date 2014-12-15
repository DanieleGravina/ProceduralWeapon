/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class OnlineSubsystemGameSpy extends OnlineSubsystemCommonImpl
	native
	implements(OnlinePlayerInterface,OnlineVoiceInterface,OnlineStatsInterface,OnlineSystemInterface,OnlineAccountInterface,OnlineNewsInterface,OnlinePlayerInterfaceEx)
	config(Engine);

/** Pointer to the object that handles the game interface */
var const OnlineGameInterfaceGameSpy CachedGameInt;

/** The name to use for local profiles */
var const localized string LocalProfileName;

/** The name of the player that is logged in */
var const string LoggedInPlayerName;

/** The unique id of the logged in player */
var const UniqueNetId LoggedInPlayerId;

/** Whether a login is in progress or not */
var const bool bIsLoginInProcess;

/**
 * Store the password temporarily during the login attempt for the login certificate request
 * Clear it as soon as it is used
 */
var const string LoggedInPlayerPassword;

/** The number of the player that called the login function */
var const int LoggedInPlayerNum;

/** The current login status for the player */
var const ELoginStatus LoggedInStatus;

/** The auth token (when doing remote auth) */
var const string RemoteAuthToken;

/** The partner challenge (when doing remote auth) */
var const string RemoteAuthPartnerChallenge;

/**
 * This is the array of pending async tasks. Each tick these tasks are checked
 * for completion. If complete, the delegate associated with them is called
 */
var native const array<pointer> AsyncTasks{FOnlineAsyncTaskGameSpy};

/** The directory profile data should be stored in */
var const string ProfileDataDirectory;

/** The file extension to use when saving profile data */
var const string ProfileDataExtension;

/** The file extension to use when saving message data */
var const string ProfileMessageDataExtension;

struct native PerUserProfileDelegates
{
	/** The array of delegates that notify read completion of profile data */
	var array<delegate<OnReadProfileSettingsComplete> > Delegates;
};

/** Holds callbacks for up to 4 splitscreen players */
var PerUserProfileDelegates PerUserReadProfileSettings[4];

/** The array of delegates that notify write completion of profile data */
var array<delegate<OnWriteProfileSettingsComplete> > WriteProfileSettingsDelegates;

/** Since the static array of dynamic array syntax appears to be broken */
struct native PerUserDelegateLists
{
	/** The array of delegates for notifying when an achievement write has completed */
	var array<delegate<OnUnlockAchievementComplete> > AchievementDelegates;
};

/** Per user array of array of delegates */
var PerUserDelegateLists PerUserDelegates[4];

/** The cached profile for the player */
var OnlineProfileSettings CachedProfile;

/** List of callbacks to notify when speech recognition is complete */
var array<delegate<OnRecognitionComplete> > SpeechRecognitionCompleteDelegates;

/** The array of delegates that notify read completion of the friends list data */
var array<delegate<OnReadFriendsComplete> > ReadFriendsDelegates;

/** The array of delegates that notify that the friends list has changed */
var array<delegate<OnFriendsChange> > FriendsChangeDelegates;

/** The array of delegates that notify that the mute list has changed */
var array<delegate<OnMutingChange> > MutingChangeDelegates;

/** This is the list of requested delegates to fire when a login fails to process */
var array<delegate<OnLoginChange> > LoginChangeDelegates;

/** This is the list of requested delegates to fire when a login fails to process */
var array<delegate<OnLoginFailed> > LoginFailedDelegates;

/** This is the list of requested delegates to fire when a logout completes */
var array<delegate<OnLogoutCompleted> > LogoutCompletedDelegates;

/** This is the list of requested delegates to fire when an account create completes */
var array<delegate<OnCreateOnlineAccountCompleted> > AccountCreateDelegates;

/** This list is used to notify the game when a player is talking */
var array<delegate<OnPlayerTalking> > PlayerTalkingDelegates;

/** This is the list of delegates requesting notification when a stats read finishes */
var array<delegate<OnReadOnlineStatsComplete> > ReadOnlineStatsCompleteDelegates;

/** The list of delegates to notify when the stats flush is complete */
var array<delegate<OnFlushOnlineStatsComplete> > FlushOnlineStatsDelegates;

/** The list of delegates to notify when the content announcement read is complete */
var array<delegate<OnReadContentAnnouncementsCompleted> > ReadContentAnnouncementsDelegates;

/** The list of delegates to notify when the news read is complete */
var array<delegate<OnReadGameNewsCompleted> > ReadGameNewsDelegates;

/** This is the list of delegates requesting notification GameSpy's connection state changes */
var array<delegate<OnConnectionStatusChange> > ConnectionStatusChangeDelegates;

/** This is the list of delegates requesting notification of controller status changes */
var array<delegate<OnControllerChange> > ControllerChangeDelegates;

/** This is the list of delegates requesting notification of network link status changes */
var array<delegate<OnLinkStatusChange> > LinkStatusDelegates;

/** The types of global muting we support */
enum EMuteType
{
	MUTE_None,
	MUTE_AllButFriends,
	MUTE_All
};

/** Adds to the local talker definition so we can support muting */
struct native LocalTalkerGS extends LocalTalker
{
	var EMuteType MuteType;
};

/** Holds the local talker information for the single signed in player */
var LocalTalkerGS CurrentLocalTalker;

/** This is the list of remote talkers */
var array<RemoteTalker> RemoteTalkers;

/** Stores a handle to the GP instance */
var native const transient private pointer GPHandle{void};

/** Stores a handle to the Sake instance */
var native const transient private pointer SakeHandle{struct SAKEInternal};

/** Stores a handle to the SC (stats & competition) SDK */
var native const transient private pointer SCHandle{void};

/** Stores a login certificate */
var native const transient private pointer LoginCertificate{GSLoginCertificate};

/** Stores the login private data */
var native const transient private pointer LoginPrivateData{GSLoginPrivateData};

/** Stores the Sake recordid associated with the player's profile */
var const int SakeProfileRecordID;

/** Identifies the GameSpy game*/
var const int GameID;

/** Identifies the GameSpy product */
var const int ProductID;

/** Identifies the login namespace */
var const int NamespaceID;

/** Identifies the login partner */
var const int PartnerID;

/** The currently outstanding stats read request */
var const OnlineStatsRead CurrentStatsRead;

/** This should match the version configured through the GameSpy stats admin site */
var const int StatsVersion;

/** The stats key id for the nickname */
var const int NickStatsKeyId;

/** The stats key id for the player's place in the match */
var const int PlaceStatsKeyId;

/** The stats key id for the UT duel game type *HACK* */
var const int DuelStatsKeyId;

/** Where to read the daily news from */
var const localized string NewsUrl;

/** Where to read the content announcements from */
var const localized string ContentAnnouncementsUrl;

/** The cached news string (todo make multilogin work) */
var const string CachedNews;

/** The cached news string (todo make multilogin work) */
var const string CachedContentAnnouncements;

/**
 * Maps a view and property to a gamespy stats key
 * If only PropertyId is 0, then this is the KeyId for the View itself
 */
struct native ViewPropertyToKeyId
{
	/** The id of the view */
	var int ViewId;
	/** The id of the property */
	var int PropertyId;
	/** The id of the gamespy stats key */
	var int KeyId;
};

/** Mappings of views and properties to gamespy stats keys */
var const array<ViewPropertyToKeyId> StatsKeyMappings;

/** This holds a single stat waiting to be written out */
struct native PlayerStat
{
	/** The GameSpy key for this stat */
	var int KeyId;
	/** The stat's value */
	var const SettingsData Data;
};

/** This stores the stats for a single player before being written out to the backend */
struct native PendingPlayerStats
{
	/** The player for which stats are being written */
	var const UniqueNetId Player;
	/** The name of the player to report with */
	var const string PlayerName;
	/** This is a per-player guid that needs to be passed to the backend */
	var const string StatGuid;
	/** The stats for this player */
	var const array<PlayerStat> Stats;
	/** The score for this player */
	var const OnlinePlayerScore Score;
	/** This player's place when sorted against the other players.  Calculated at reporting time */
	var const string Place;
};

/** Stats are stored in this array while waiting for FlushOnlineStats() */
var const array<PendingPlayerStats> PendingStats;

/** Holds the results of async keyboard input */
var const string KeyboardResultsString;

/** Whether the user canceled keyboard input or not */
var const byte bWasKeyboardInputCanceled;

/** Whether the keyboard needs to be ticked */
var const bool bNeedsKeyboardTicking;

/** This is the list of requested delegates to fire when keyboard UI has completed */
var array<delegate<OnKeyboardInputComplete> > KeyboardInputDelegates;

/** This is the list of requested delegates to fire when a friend invite is received */
var array<delegate<OnFriendInviteReceived> > FriendInviteReceivedDelegates;

/** This is the list of requested delegates to fire when a friend message is received */
var array<delegate<OnFriendMessageReceived> > FriendMessageReceivedDelegates;

/** This is the list of requested delegates to fire when a friend by name invite has completed*/
var array<delegate<OnAddFriendByNameComplete> > AddFriendByNameCompleteDelegates;

/** Used by the async add friend by name function */
var const string CachedFriendMessage;

/**
 * The list of location strings that are ok to accept invites for. Used mostly
 * the different platform skus use different location strings.
 */
var const array<string> LocationUrlsForInvites;

/** The URL to send as the location string */
var const string LocationUrl;

/** The list of subscribers for game invite events */
var array<delegate<OnReceivedGameInvite> > ReceivedGameInviteDelegates;

/** Holds the list of delegates that are interested in receiving join friend completions */
var array<delegate<OnJoinFriendGameComplete> > JoinFriendGameCompleteDelegates;

/** This is the list of requested delegates to fire when a host registration is complete */
var array<delegate<OnRegisterHostStatGuidComplete> > RegisterHostStatGuidCompleteDelegates;

/** The list of friend messages received while the game was running */
var array<OnlineFriendMessage> CachedFriendMessages;

/** Holds the items used to map an online status string to its format string */
struct native OnlineStatusMapping
{
	/** The id of the status string */
	var int StatusId;
	/** The format string to use to apply the passed in properties/strings */
	var localized string StatusString;
};

/** Holds the set of status strings for the specified game */
var const config array<OnlineStatusMapping> StatusMappings;

/** This is the default online status to use in status updates */
var const localized string DefaultStatus;

/** The message to use for game invites */
var const localized string GameInviteMessage;

/** Pointer to the PS3 specific data needed by GameSpy for single sign on */
var const native transient pointer NpData{FNpData};

/** Struct to hold current and previous frame's game state */
struct native ControllerConnectionState
{
	/** Whether the controller is connected or not */
	var const int bIsControllerConnected;
	/** Last frame's version of the above */
	var const int bLastIsControllerConnected;
};

/** Upto 4 player split screen support */
var ControllerConnectionState ControllerStates[4];

/** Whether the last frame has connection status or not */
var bool bLastHasConnection;

/** The amount of time to elapse before checking for connection status change */
var float ConnectionPresenceTimeInterval;

/** Used to check when to verify connection status */
var float ConnectionPresenceElapsedTime;

/** Whether the stats session is ok to add stats to etc */
var bool bIsStatsSessionOk;

/** Holds the product key in its encrypted form */
var private const config string EncryptedProductKey;

/** Whether the user has created a GameSpy account or not */
var private const config bool bHasGameSpyAccount;

/** An ever incrementing number assigned to auth requests */
var const transient int NextAuthId;

/** Holds the server auth challenge */
var const string ServerChallenge;

/** Holds the server auth response */
var const string ServerResponse;

/** Holds the server auth local id */
var const int ServerLocalId;

/** Holds the set of people that are muted by the currently logged in player */
var const array<UniqueNetId> MuteList;

/** The IP address of the STUN server to talk to */
var const config array<string> StunServerAddress;

/** The STUN object to query for NAT information */
var const native transient pointer StunClient{FSTUNClient};

/** Whether the STUN lookup has completed or not */
var const bool bIsStunDone;

/**
 * Called from engine start up code to allow the subsystem to initialize
 *
 * @return TRUE if the initialization was successful, FALSE otherwise
 */
native event bool Init();

/**
 * Delegate used in login notifications
 */
delegate OnLoginChange();

/**
 * Delegate used to notify when a login request was cancelled by the user
 */
delegate OnLoginCancelled();

/**
 * Delegate used in mute list change notifications
 */
delegate OnMutingChange();

/**
 * Delegate used in friends list change notifications
 */
delegate OnFriendsChange();

/**
 * Displays the UI that prompts the user for their login credentials. Each
 * platform handles the authentication of the user's data.
 *
 * @param bShowOnlineOnly whether to only display online enabled profiles or not
 *
 * @return TRUE if it was able to show the UI, FALSE if it failed
 */
native function bool ShowLoginUI(optional bool bShowOnlineOnly = false);

/**
 * Logs the player into the online service. If this fails, it generates a
 * OnLoginFailed notification
 *
 * @param LocalUserNum the controller number of the associated user
 * @param LoginName the unique identifier for the player
 * @param Password the password for this account
 * @param bWantsLocalOnly whether the player wants to sign in locally only or not
 *
 * @return true if the async call started ok, false otherwise
 */
native function bool Login(byte LocalUserNum,string LoginName,string Password,optional bool bWantsLocalOnly);

/**
 * Logs the player into the online service using parameters passed on the
 * command line. Expects -Login=<UserName> -Password=<password>. If either
 * are missing, the function returns false and doesn't start the login
 * process
 *
 * @return true if the async call started ok, false otherwise
 */
native function bool AutoLogin();

/**
 * Delegate used in notifying the UI/game that the manual login failed
 *
 * @param LocalUserNum the controller number of the associated user
 * @param ErrorCode the async error code that occurred
 */
delegate OnLoginFailed(byte LocalUserNum,EOnlineServerConnectionStatus ErrorCode);

/**
 * Sets the delegate used to notify the gameplay code that a login failed
 *
 * @param LocalUserNum the controller number of the associated user
 * @param LoginDelegate the delegate to use for notifications
 */
function AddLoginFailedDelegate(byte LocalUserNum,delegate<OnLoginFailed> LoginFailedDelegate)
{
	// Add this delegate to the array if not already present
	if (LoginFailedDelegates.Find(LoginFailedDelegate) == INDEX_NONE)
	{
		LoginFailedDelegates[LoginFailedDelegates.Length] = LoginFailedDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param LocalUserNum the controller number of the associated user
 * @param LoginDelegate the delegate to use for notifications
 */
function ClearLoginFailedDelegate(byte LocalUserNum,delegate<OnLoginFailed> LoginFailedDelegate)
{
	local int RemoveIndex;

	// Remove this delegate from the array if found
	RemoveIndex = LoginFailedDelegates.Find(LoginFailedDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		LoginFailedDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Signs the player out of the online service
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool Logout(byte LocalUserNum);

/**
 * Delegate used in notifying the UI/game that the manual logout completed
 *
 * @param bWasSuccessful whether the async call completed properly or not
 */
delegate OnLogoutCompleted(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that a logout completed
 *
 * @param LocalUserNum the controller number of the associated user
 * @param LogoutDelegate the delegate to use for notifications
 */
function AddLogoutCompletedDelegate(byte LocalUserNum,delegate<OnLogoutCompleted> LogoutDelegate)
{
	// Add this delegate to the array if not already present
	if (LogoutCompletedDelegates.Find(LogoutDelegate) == INDEX_NONE)
	{
		LogoutCompletedDelegates[LogoutCompletedDelegates.Length] = LogoutDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param LocalUserNum the controller number of the associated user
 * @param LogoutDelegate the delegate to use for notifications
 */
function ClearLogoutCompletedDelegate(byte LocalUserNum,delegate<OnLogoutCompleted> LogoutDelegate)
{
	local int RemoveIndex;

	// Remove this delegate from the array if found
	RemoveIndex = LogoutCompletedDelegates.Find(LogoutDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		LogoutCompletedDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Fetches the login status for a given player
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the enum value of their status
 */
native function ELoginStatus GetLoginStatus(byte LocalUserNum);

/**
 * Gets the platform specific unique id for the specified player
 *
 * @param LocalUserNum the controller number of the associated user
 * @param PlayerId the byte array that will receive the id
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
function bool GetUniquePlayerId(byte LocalUserNum,out UniqueNetId PlayerId)
{
	PlayerId = LoggedInPlayerId;
	return true;
}

/**
 * Reads the player's nick name from the online service
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return a string containing the players nick name
 */
function string GetPlayerNickname(byte LocalUserNum)
{
	return LoggedInPlayerName;
}

/**
 * Determines whether the player is allowed to play online
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
native function EFeaturePrivilegeLevel CanPlayOnline(byte LocalUserNum);

/**
 * Determines whether the player is allowed to use voice or text chat online
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
native function EFeaturePrivilegeLevel CanCommunicate(byte LocalUserNum);

/**
 * Determines whether the player is allowed to download user created content
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
function EFeaturePrivilegeLevel CanDownloadUserContent(byte LocalUserNum)
{
	return FPL_Enabled;
}

/**
 * Determines whether the player is allowed to buy content online
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
function EFeaturePrivilegeLevel CanPurchaseContent(byte LocalUserNum)
{
	return FPL_Enabled;
}

/**
 * Determines whether the player is allowed to view other people's player profile
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
function EFeaturePrivilegeLevel CanViewPlayerProfiles(byte LocalUserNum)
{
	return FPL_Enabled;
}

/**
 * Determines whether the player is allowed to have their online presence
 * information shown to remote clients
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return the Privilege level that is enabled
 */
function EFeaturePrivilegeLevel CanShowPresenceInformation(byte LocalUserNum)
{
	return FPL_Enabled;
}

/**
 * Checks that a unique player id is part of the specified user's friends list
 *
 * @param LocalUserNum the controller number of the associated user
 * @param PlayerId the id of the player being checked
 *
 * @return TRUE if a member of their friends list, FALSE otherwise
 */
native function bool IsFriend(byte LocalUserNum,UniqueNetId PlayerId);

/**
 * Checks that whether a group of player ids are among the specified player's
 * friends
 *
 * @param LocalUserNum the controller number of the associated user
 * @param Query an array of players to check for being included on the friends list
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool AreAnyFriends(byte LocalUserNum,out array<FriendsQuery> Query);

/**
 * Checks that a unique player id is on the specified user's mute list
 *
 * @param LocalUserNum the controller number of the associated user
 * @param PlayerId the id of the player being checked
 *
 * @return TRUE if the player should be muted, FALSE otherwise
 */
function bool IsMuted(byte LocalUserNum,UniqueNetId PlayerId);

/**
 * Displays the UI that shows a user's list of friends
 *
 * @param LocalUserNum the controller number of the associated user
 *
 * @return TRUE if it was able to show the UI, FALSE if it failed
 */
function bool ShowFriendsUI(byte LocalUserNum);

/**
 * Sets the delegate used to notify the gameplay code that a login changed
 *
 * @param LoginDelegate the delegate to use for notifications
 * @param LocalUserNum whether to watch for changes on a specific slot or all slots
 */
function AddLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate,optional byte LocalUserNum = 255)
{
	// Add this delegate to the array if not already present
	if (LoginChangeDelegates.Find(LoginDelegate) == INDEX_NONE)
	{
		LoginChangeDelegates[LoginChangeDelegates.Length] = LoginDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param LoginDelegate the delegate to use for notifications
 * @param LocalUserNum whether to watch for changes on a specific slot or all slots
 */
function ClearLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate,optional byte LocalUserNum = 255)
{
	local int RemoveIndex;

	// Remove this delegate from the array if found
	RemoveIndex = LoginChangeDelegates.Find(LoginDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		LoginChangeDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Adds a delegate to the list of delegates that are fired when a login is cancelled
 *
 * @param CancelledDelegate the delegate to add to the list
 */
function AddLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate);

/**
 * Removes the specified delegate from the notification list
 *
 * @param CancelledDelegate the delegate to remove fromt he list
 */
function ClearLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate);

/**
 * Sets the delegate used to notify the gameplay code that a muting list changed
 *
 * @param MutingDelegate the delegate to use for notifications
 */
function AddMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate)
{
	// Add this delegate to the array if not already present
	if (MutingChangeDelegates.Find(MutingDelegate) == INDEX_NONE)
	{
		MutingChangeDelegates[MutingChangeDelegates.Length] = MutingDelegate;
	}
}

/**
 * Searches the existing set of delegates for the one specified and removes it
 * from the list
 *
 * @param FriendsDelegate the delegate to use for notifications
 */
function ClearMutingChangeDelegate(delegate<OnFriendsChange> MutingDelegate)
{
	local int RemoveIndex;

	RemoveIndex = MutingChangeDelegates.Find(MutingDelegate);
	// Remove this delegate from the array if found
	if (RemoveIndex != INDEX_NONE)
	{
		MutingChangeDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Sets the delegate used to notify the gameplay code that a friends list changed
 *
 * @param LocalUserNum the user to read the friends list of
 * @param FriendsDelegate the delegate to use for notifications
 */
function AddFriendsChangeDelegate(byte LocalUserNum,delegate<OnFriendsChange> FriendsDelegate)
{
	if (LocalUserNum == 0)
	{
		// Add this delegate to the array if not already present
		if (FriendsChangeDelegates.Find(FriendsDelegate) == INDEX_NONE)
		{
			FriendsChangeDelegates[FriendsChangeDelegates.Length] = FriendsDelegate;
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for ClearFriendsChangeDelegate()");
	}
}

/**
 * Searches the existing set of delegates for the one specified and removes it
 * from the list
 *
 * @param LocalUserNum the user to read the friends list of
 * @param FriendsDelegate the delegate to use for notifications
 */
function ClearFriendsChangeDelegate(byte LocalUserNum,delegate<OnFriendsChange> FriendsDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == 0)
	{
		RemoveIndex = FriendsChangeDelegates.Find(FriendsDelegate);
		// Remove this delegate from the array if found
		if (RemoveIndex != INDEX_NONE)
		{
			FriendsChangeDelegates.Remove(RemoveIndex,1);
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for ClearFriendsChangeDelegate()");
	}
}

/**
 * Reads the online profile settings for a given user
 *
 * @param LocalUserNum the user that we are reading the data for
 * @param ProfileSettings the object to copy the results to and contains the list of items to read
 *
 * @return true if the call succeeds, false otherwise
 */
native function bool ReadProfileSettings(byte LocalUserNum,OnlineProfileSettings ProfileSettings);

/**
 * Delegate used when the last read profile settings request has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnReadProfileSettingsComplete(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that the last read request has completed
 *
 * @param LocalUserNum which user to watch for read complete notifications
 * @param ReadProfileSettingsCompleteDelegate the delegate to use for notifications
 */
function AddReadProfileSettingsCompleteDelegate(byte LocalUserNum,delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
	if (LocalUserNum >= 0 && LocalUserNum < 4)
	{
		// Add this delegate to the array if not already present
		if (PerUserReadProfileSettings[LocalUserNum].Delegates.Find(ReadProfileSettingsCompleteDelegate) == INDEX_NONE)
		{
			PerUserReadProfileSettings[LocalUserNum].Delegates[PerUserReadProfileSettings[LocalUserNum].Delegates.Length] = ReadProfileSettingsCompleteDelegate;
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for AddReadProfileSettingsCompleteDelegate()");
	}
}

/**
 * Searches the existing set of delegates for the one specified and removes it
 * from the list
 *
 * @param LocalUserNum which user to watch for read complete notifications
 * @param ReadProfileSettingsCompleteDelegate the delegate to find and clear
 */
function ClearReadProfileSettingsCompleteDelegate(byte LocalUserNum,delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum >= 0 && LocalUserNum < 4)
	{
		RemoveIndex = PerUserReadProfileSettings[LocalUserNum].Delegates.Find(ReadProfileSettingsCompleteDelegate);
		// Remove this delegate from the array if found
		if (RemoveIndex != INDEX_NONE)
		{
			PerUserReadProfileSettings[LocalUserNum].Delegates.Remove(RemoveIndex,1);
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for ClearReadProfileSettingsCompleteDelegate()");
	}
}

/**
 * Returns the online profile settings for a given user
 *
 * @param LocalUserNum the user that we are reading the data for
 *
 * @return the profile settings object
 */
function OnlineProfileSettings GetProfileSettings(byte LocalUserNum)
{
	if (LocalUserNum == 0)
	{
		return CachedProfile;
	}
	return None;
}

/**
 * Writes the online profile settings for a given user to the online data store
 *
 * @param LocalUserNum the user that we are writing the data for
 * @param ProfileSettings the list of settings to write out
 *
 * @return true if the call succeeds, false otherwise
 */
native function bool WriteProfileSettings(byte LocalUserNum,OnlineProfileSettings ProfileSettings);

/**
 * Delegate used when the last write profile settings request has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnWriteProfileSettingsComplete(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that the last read request has completed
 *
 * @param LocalUserNum which user to watch for read complete notifications
 * @param ReadProfileSettingsCompleteDelegate the delegate to use for notifications
 */
function AddWriteProfileSettingsCompleteDelegate(byte LocalUserNum,delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate)
{
	if (LocalUserNum == 0)
	{
		// Add this delegate to the array if not already present
		if (WriteProfileSettingsDelegates.Find(WriteProfileSettingsCompleteDelegate) == INDEX_NONE)
		{
			WriteProfileSettingsDelegates[WriteProfileSettingsDelegates.Length] = WriteProfileSettingsCompleteDelegate;
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for AddWriteProfileSettingsCompleteDelegate()");
	}
}

/**
 * Searches the existing set of delegates for the one specified and removes it
 * from the list
 *
 * @param LocalUserNum which user to watch for read complete notifications
 * @param ReadProfileSettingsCompleteDelegate the delegate to find and clear
 */
function ClearWriteProfileSettingsCompleteDelegate(byte LocalUserNum,delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == 0)
	{
		RemoveIndex = WriteProfileSettingsDelegates.Find(WriteProfileSettingsCompleteDelegate);
		// Remove this delegate from the array if found
		if (RemoveIndex != INDEX_NONE)
		{
			WriteProfileSettingsDelegates.Remove(RemoveIndex,1);
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for ClearWriteProfileSettingsCompleteDelegate()");
	}
}

/**
* Starts an blocking task that writes the array of friend messages out to disk
*
* @param LocalUserNum the user to write the messages for
*
* @return true if the write request was successful, false otherwise
*/
native function bool WriteFriendMessages(byte LocalUserNum);

/**
* Starts an blocking task that reads in the array of friend messages from disk
*
* @param LocalUserNum the user to read the messages for
*
* @return true if the read request was successful, false otherwise
*/
native function bool ReadFriendMessages(byte LocalUserNum, out array<OnlineFriendMessage> Messages);

/**
 * Starts an async task that retrieves the list of friends for the player from the
 * online service. The list can be retrieved in whole or in part.
 *
 * @param LocalUserNum the user to read the friends list of
 * @param Count the number of friends to read or zero for all
 * @param StartingAt the index of the friends list to start at (for pulling partial lists)
 *
 * @return true if the read request was issued successfully, false otherwise
 */
native function bool ReadFriendsList(byte LocalUserNum,optional int Count,optional int StartingAt);

/**
 * Delegate used when the friends read request has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnReadFriendsComplete(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that the friends read request has completed
 *
 * @param LocalUserNum the user to read the friends list of
 * @param ReadFriendsCompleteDelegate the delegate to use for notifications
 */
function AddReadFriendsCompleteDelegate(byte LocalUserNum,delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate)
{
	if (LocalUserNum == 0)
	{
		// Add this delegate to the array if not already present
		if (ReadFriendsDelegates.Find(ReadFriendsCompleteDelegate) == INDEX_NONE)
		{
			ReadFriendsDelegates[ReadFriendsDelegates.Length] = ReadFriendsCompleteDelegate;
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for AddReadFriendsCompleteDelegate()");
	}
}

/**
 * Searches the existing set of delegates for the one specified and removes it
 * from the list
 *
 * @param LocalUserNum which user to watch for read complete notifications
 * @param ReadFriendsCompleteDelegate the delegate to find and clear
 */
function ClearReadFriendsCompleteDelegate(byte LocalUserNum,delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == 0)
	{
		RemoveIndex = ReadFriendsDelegates.Find(ReadFriendsCompleteDelegate);
		// Remove this delegate from the array if found
		if (RemoveIndex != INDEX_NONE)
		{
			ReadFriendsDelegates.Remove(RemoveIndex,1);
		}
	}
	else
	{
		WarnInternal("Invalid user index ("$LocalUserNum$") specified for ClearReadFriendsCompleteDelegate()");
	}
}

/**
 * Copies the list of friends for the player previously retrieved from the online
 * service. The list can be retrieved in whole or in part.
 *
 * @param LocalUserNum the user to read the friends list of
 * @param Friends the out array that receives the copied data
 * @param Count the number of friends to read or zero for all
 * @param StartingAt the index of the friends list to start at (for pulling partial lists)
 *
 * @return OERS_Done if the read has completed, otherwise one of the other states
 */
native function EOnlineEnumerationReadState GetFriendsList(byte LocalUserNum,out array<OnlineFriend> Friends,optional int Count,optional int StartingAt);

/**
 * Registers the user as a talker
 *
 * @param LocalUserNum the local player index that is a talker
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool RegisterLocalTalker(byte LocalUserNum);

/**
 * Unregisters the user as a talker
 *
 * @param LocalUserNum the local player index to be removed
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool UnregisterLocalTalker(byte LocalUserNum);

/**
 * Registers a remote player as a talker
 *
 * @param PlayerId the unique id of the remote player that is a talker
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool RegisterRemoteTalker(UniqueNetId PlayerId);

/**
 * Unregisters a remote player as a talker
 *
 * @param PlayerId the unique id of the remote player to be removed
 *
 * @return TRUE if the call succeeded, FALSE otherwise
 */
native function bool UnregisterRemoteTalker(UniqueNetId PlayerId);

/**
 * Determines if the specified player is actively talking into the mic
 *
 * @param LocalUserNum the local player index being queried
 *
 * @return TRUE if the player is talking, FALSE otherwise
 */
native function bool IsLocalPlayerTalking(byte LocalUserNum);

/**
 * Determines if the specified remote player is actively talking into the mic
 * NOTE: Network latencies will make this not 100% accurate
 *
 * @param PlayerId the unique id of the remote player being queried
 *
 * @return TRUE if the player is talking, FALSE otherwise
 */
native function bool IsRemotePlayerTalking(UniqueNetId PlayerId);

/**
 * Determines if the specified player has a headset connected
 *
 * @param LocalUserNum the local player index being queried
 *
 * @return TRUE if the player has a headset plugged in, FALSE otherwise
 */
native function bool IsHeadsetPresent(byte LocalUserNum);

/**
 * Sets the relative priority for a remote talker. 0 is highest
 *
 * @param LocalUserNum the user that controls the relative priority
 * @param PlayerId the remote talker that is having their priority changed for
 * @param Priority the relative priority to use (0 highest, < 0 is muted)
 *
 * @return TRUE if the function succeeds, FALSE otherwise
 */
native function bool SetRemoteTalkerPriority(byte LocalUserNum,UniqueNetId PlayerId,int Priority);

/**
 * Mutes a remote talker for the specified local player. NOTE: This is separate
 * from the user's permanent online mute list
 *
 * @param LocalUserNum the user that is muting the remote talker
 * @param PlayerId the remote talker that is being muted
 *
 * @return TRUE if the function succeeds, FALSE otherwise
 */
native function bool MuteRemoteTalker(byte LocalUserNum,UniqueNetId PlayerId);

/**
 * Allows a remote talker to talk to the specified local player. NOTE: This call
 * will fail for remote talkers on the user's permanent online mute list
 *
 * @param LocalUserNum the user that is allowing the remote talker to talk
 * @param PlayerId the remote talker that is being restored to talking
 *
 * @return TRUE if the function succeeds, FALSE otherwise
 */
native function bool UnmuteRemoteTalker(byte LocalUserNum,UniqueNetId PlayerId);

/**
 * Called when a player is talking either locally or remote. This will be called
 * once for each active talker each frame.
 *
 * @param Player the player that is talking
 */
delegate OnPlayerTalking(UniqueNetId Player);

/**
 * Adds a talker delegate to the list of notifications
 *
 * @param TalkerDelegate the delegate to call when a player is talking
 */
function AddPlayerTalkingDelegate(delegate<OnPlayerTalking> TalkerDelegate)
{
	if (PlayerTalkingDelegates.Find(TalkerDelegate) == INDEX_NONE)
	{
		PlayerTalkingDelegates[PlayerTalkingDelegates.Length] = TalkerDelegate;
	}
}

/**
 * Removes a talker delegate to the list of notifications
 *
 * @param TalkerDelegate the delegate to remove from the notification list
 */
function ClearPlayerTalkingDelegate(delegate<OnPlayerTalking> TalkerDelegate)
{
	local int RemoveIndex;

	RemoveIndex = PlayerTalkingDelegates.Find(TalkerDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		PlayerTalkingDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Tells the voice layer that networked processing of the voice data is allowed
 * for the specified player. This allows for push-to-talk style voice communication
 *
 * @param LocalUserNum the local user to allow network transimission for
 */
native function StartNetworkedVoice(byte LocalUserNum);

/**
 * Tells the voice layer to stop processing networked voice support for the
 * specified player. This allows for push-to-talk style voice communication
 *
 * @param LocalUserNum the local user to disallow network transimission for
 */
native function StopNetworkedVoice(byte LocalUserNum);

/**
 * Tells the voice system to start tracking voice data for speech recognition
 *
 * @param LocalUserNum the local user to recognize voice data for
 *
 * @return true upon success, false otherwise
 */
native function bool StartSpeechRecognition(byte LocalUserNum);

/**
 * Tells the voice system to stop tracking voice data for speech recognition
 *
 * @param LocalUserNum the local user to recognize voice data for
 *
 * @return true upon success, false otherwise
 */
native function bool StopSpeechRecognition(byte LocalUserNum);

/**
 * Gets the results of the voice recognition
 *
 * @param LocalUserNum the local user to read the results of
 * @param Words the set of words that were recognized by the voice analyzer
 *
 * @return true upon success, false otherwise
 */
native function bool GetRecognitionResults(byte LocalUserNum,out array<SpeechRecognizedWord> Words);

/**
 * Called when speech recognition for a given player has completed. The
 * consumer of the notification can call GetRecognitionResults() to get the
 * words that were recognized
 */
delegate OnRecognitionComplete();

/**
 * Sets the speech recognition notification callback to use for the specified user
 *
 * @param LocalUserNum the local user to receive notifications for
 * @param RecognitionDelegate the delegate to call when recognition is complete
 */
function AddRecognitionCompleteDelegate(byte LocalUserNum,delegate<OnRecognitionComplete> RecognitionDelegate)
{
	if (SpeechRecognitionCompleteDelegates.Find(RecognitionDelegate) == INDEX_NONE)
	{
		SpeechRecognitionCompleteDelegates[SpeechRecognitionCompleteDelegates.Length] = RecognitionDelegate;
	}
}

/**
 * Clears the speech recognition notification callback to use for the specified user
 *
 * @param LocalUserNum the local user to receive notifications for
 * @param RecognitionDelegate the delegate to call when recognition is complete
 */
function ClearRecognitionCompleteDelegate(byte LocalUserNum,delegate<OnRecognitionComplete> RecognitionDelegate)
{
	local int RemoveIndex;

	RemoveIndex = SpeechRecognitionCompleteDelegates.Find(RecognitionDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		SpeechRecognitionCompleteDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Changes the vocabulary id that is currently being used
 *
 * @param LocalUserNum the local user that is making the change
 * @param VocabularyId the new id to use
 *
 * @return true if successful, false otherwise
 */
native function bool SelectVocabulary(byte LocalUserNum,int VocabularyId);

/**
 * Changes the object that is in use to the one specified
 *
 * @param LocalUserNum the local user that is making the change
 * @param SpeechRecogObj the new object use
 *
 * @param true if successful, false otherwise
 */
native function bool SetSpeechRecognitionObject(byte LocalUserNum,SpeechRecognition SpeechRecogObj);

/**
 * Reads a set of stats for the specified list of players
 *
 * @param Players the array of unique ids to read stats for
 * @param StatsRead holds the definitions of the tables to read the data from and
 *		  results are copied into the specified object
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool ReadOnlineStats(const out array<UniqueNetId> Players,OnlineStatsRead StatsRead);

/**
 * Reads a player's stats and all of that player's friends stats for the
 * specified set of stat views. This allows you to easily compare a player's
 * stats to their friends.
 *
 * @param LocalUserNum the local player having their stats and friend's stats read for
 * @param StatsRead holds the definitions of the tables to read the data from and
 *		  results are copied into the specified object
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool ReadOnlineStatsForFriends(byte LocalUserNum,OnlineStatsRead StatsRead);

/**
 * Reads stats by ranking. This grabs the rows starting at StartIndex through
 * NumToRead and places them in the StatsRead object.
 *
 * @param StatsRead holds the definitions of the tables to read the data from and
 *		  results are copied into the specified object
 * @param StartIndex the starting rank to begin reads at (1 for top)
 * @param NumToRead the number of rows to read (clamped at 100 underneath)
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool ReadOnlineStatsByRank(OnlineStatsRead StatsRead,optional int StartIndex = 1,optional int NumToRead = 100);

/**
 * Reads stats by ranking centered around a player. This grabs a set of rows
 * above and below the player's current rank
 *
 * @param LocalUserNum the local player having their stats being centered upon
 * @param StatsRead holds the definitions of the tables to read the data from and
 *		  results are copied into the specified object
 * @param NumRows the number of rows to read above and below the player's rank
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool ReadOnlineStatsByRankAroundPlayer(byte LocalUserNum,OnlineStatsRead StatsRead,optional int NumRows = 10);

/**
 * Adds the delegate to a list used to notify the gameplay code that the stats read has completed
 *
 * @param ReadOnlineStatsCompleteDelegate the delegate to use for notifications
 */
function AddReadOnlineStatsCompleteDelegate(delegate<OnReadOnlineStatsComplete> ReadOnlineStatsCompleteDelegate)
{
	if (ReadOnlineStatsCompleteDelegates.Find(ReadOnlineStatsCompleteDelegate) == INDEX_NONE)
	{
		ReadOnlineStatsCompleteDelegates[ReadOnlineStatsCompleteDelegates.Length] = ReadOnlineStatsCompleteDelegate;
	}
}

/**
 * Removes the delegate from the notify list
 *
 * @param ReadOnlineStatsCompleteDelegate the delegate to use for notifications
 */
function ClearReadOnlineStatsCompleteDelegate(delegate<OnReadOnlineStatsComplete> ReadOnlineStatsCompleteDelegate)
{
	local int RemoveIndex;
	// Find it in the list
	RemoveIndex = ReadOnlineStatsCompleteDelegates.Find(ReadOnlineStatsCompleteDelegate);
	// Only remove if found
	if (RemoveIndex != INDEX_NONE)
	{
		ReadOnlineStatsCompleteDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Notifies the interested party that the last stats read has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnReadOnlineStatsComplete(bool bWasSuccessful);

/**
 * Cleans up any platform specific allocated data contained in the stats data
 *
 * @param StatsRead the object to handle per platform clean up on
 */
native function FreeStats(OnlineStatsRead StatsRead);

/**
 * Writes out the stats contained within the stats write object to the online
 * subsystem's cache of stats data. Note the new data replaces the old. It does
 * not write the data to the permanent storage until a FlushOnlineStats() call
 * or a session ends. Stats cannot be written without a session or the write
 * request is ignored. No more than 5 stats views can be written to at a time
 * or the write request is ignored.
 *
 * @param Player the player to write stats for
 * @param StatsWrite the object containing the information to write
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool WriteOnlineStats(UniqueNetId Player,OnlineStatsWrite StatsWrite);

/**
 * Commits any changes in the online stats cache to the permanent storage
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool FlushOnlineStats();

/**
 * Delegate called when the stats flush operation has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnFlushOnlineStatsComplete(bool bWasSuccessful);

/**
 * Adds the delegate used to notify the gameplay code that the stats flush has completed
 *
 * @param FlushOnlineStatsCompleteDelegate the delegate to use for notifications
 */
function AddFlushOnlineStatsCompleteDelegate(delegate<OnFlushOnlineStatsComplete> FlushOnlineStatsCompleteDelegate)
{
	if (FlushOnlineStatsDelegates.Find(FlushOnlineStatsCompleteDelegate) == INDEX_NONE)
	{
		FlushOnlineStatsDelegates[FlushOnlineStatsDelegates.Length] = FlushOnlineStatsCompleteDelegate;
	}
}

/**
 * Clears the delegate used to notify the gameplay code that the stats flush has completed
 *
 * @param FlushOnlineStatsCompleteDelegate the delegate to use for notifications
 */
function ClearFlushOnlineStatsCompleteDelegate(delegate<OnFlushOnlineStatsComplete> FlushOnlineStatsCompleteDelegate)
{
	local int RemoveIndex;

	RemoveIndex = FlushOnlineStatsDelegates.Find(FlushOnlineStatsCompleteDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		FlushOnlineStatsDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Writes the score data for the match
 *
 * @param PlayerScores the list of players, teams, and scores they earned
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool WriteOnlinePlayerScores(const out array<OnlinePlayerScore> PlayerScores);

/**
 * Returns the name of the player for the specified index
 *
 * @param UserIndex the user to return the name of
 *
 * @return the name of the player at the specified index
 */
event string GetPlayerNicknameFromIndex(int UserIndex)
{
	if (UserIndex == 0)
	{
		return LoggedInPlayerName;
	}
	return "";
}

/**
 * Returns the unique id of the player for the specified index
 *
 * @param UserIndex the user to return the id of
 *
 * @return the unique id of the player at the specified index
 */
event UniqueNetId GetPlayerUniqueNetIdFromIndex(int UserIndex)
{
	local UniqueNetId Zero;

	if (UserIndex == 0)
	{
		return LoggedInPlayerId;
	}
	return Zero;
}

/**
 * Determines if the ethernet link is connected or not
 */
native function bool HasLinkConnection();

/**
 * Delegate fired when the network link status changes
 *
 * @param bIsConnected whether the link is currently connected or not
 */
delegate OnLinkStatusChange(bool bIsConnected);

/**
 * Adds the delegate used to notify the gameplay code that link status changed
 *
 * @param LinkStatusDelegate the delegate to use for notifications
 */
function AddLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
	// Only add to the list once
	if (LinkStatusDelegates.Find(LinkStatusDelegate) == INDEX_NONE)
	{
		LinkStatusDelegates[LinkStatusDelegates.Length] = LinkStatusDelegate;
	}
}

/**
 * Removes the delegate from the notify list
 *
 * @param LinkStatusDelegate the delegate to remove
 */
function ClearLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
	local int RemoveIndex;
	// See if the specified delegate is in the list
	RemoveIndex = LinkStatusDelegates.Find(LinkStatusDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		LinkStatusDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Delegate fired when an external UI display state changes (opening/closing)
 *
 * @param bIsOpening whether the external UI is opening or closing
 */
delegate OnExternalUIChange(bool bIsOpening);

/**
 * Sets the delegate used to notify the gameplay code that external UI state
 * changed (opened/closed)
 *
 * @param ExternalUIDelegate the delegate to use for notifications
 */
function AddExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate);

/**
 * Removes the delegate from the notification list
 *
 * @param ExternalUIDelegate the delegate to remove
 */
function ClearExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate);

/**
 * Determines the current notification position setting
 */
function ENetworkNotificationPosition GetNetworkNotificationPosition()
{
//@todo joeg -- hook up properly
	return NNP_BottomCenter;
}

/**
 * Sets a new position for the network notification icons/images
 *
 * @param NewPos the new location to use
 */
function SetNetworkNotificationPosition(ENetworkNotificationPosition NewPos);

/**
 * Delegate fired when the controller becomes dis/connected
 *
 * @param ControllerId the id of the controller that changed connection state
 * @param bIsConnected whether the controller connected (true) or disconnected (false)
 */
delegate OnControllerChange(int ControllerId,bool bIsConnected);

/**
 * Sets the delegate used to notify the gameplay code that the controller state changed
 *
 * @param ControllerChangeDelegate the delegate to use for notifications
 */
function AddControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
	// Only add to the list once
	if (ControllerChangeDelegates.Find(ControllerChangeDelegate) == INDEX_NONE)
	{
		ControllerChangeDelegates[ControllerChangeDelegates.Length] = ControllerChangeDelegate;
	}
}

/**
 * Removes the delegate used to notify the gameplay code that the controller state changed
 *
 * @param ControllerChangeDelegate the delegate to remove
 */
function ClearControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
	local int RemoveIndex;
	// See if the specified delegate is in the list
	RemoveIndex = ControllerChangeDelegates.Find(ControllerChangeDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		ControllerChangeDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Determines if the specified controller is connected or not
 *
 * @param ControllerId the controller to query
 *
 * @return true if connected, false otherwise
 */
native function bool IsControllerConnected(int ControllerId);

/**
 * Delegate fire when the online server connection state changes
 *
 * @param ConnectionStatus the new connection status
 */
delegate OnConnectionStatusChange(EOnlineServerConnectionStatus ConnectionStatus);

/**
 * Adds the delegate to the list to be notified when the connection status changes
 *
 * @param ConnectionStatusDelegate the delegate to add
 */
function AddConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
	// Only add to the list once
	if (ConnectionStatusChangeDelegates.Find(ConnectionStatusDelegate) == INDEX_NONE)
	{
		ConnectionStatusChangeDelegates[ConnectionStatusChangeDelegates.Length] = ConnectionStatusDelegate;
	}
}

/**
 * Removes the delegate from the notify list
 *
 * @param ConnectionStatusDelegate the delegate to remove
 */
function ClearConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
	local int RemoveIndex;
	// See if the specified delegate is in the list
	RemoveIndex = ConnectionStatusChangeDelegates.Find(ConnectionStatusDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		ConnectionStatusChangeDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Determines the NAT type the player is using
 */
native function ENATType GetNATType();

/**
 * Delegate fired when a storage device change is detected
 */
delegate OnStorageDeviceChange();

/**
 * Adds the delegate to the list to be notified when a storage device changes
 *
 * @param StorageDeviceChangeDelegate the delegate to add
 */
function AddStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate);

/**
 * Removes the delegate from the notify list
 *
 * @param ConnectionStatusDelegate the delegate to remove
 */
function ClearStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate);

/**
 * Creates a network enabled account on the online service
 *
 * @param UserName the unique nickname of the account
 * @param Password the password securing the account
 * @param EmailAddress the address used to send password hints to
 * @param ProductKey
 */
native function bool CreateOnlineAccount(string UserName,string Password,string EmailAddress,optional string ProductKey);

/**
 * Delegate used in notifying the UI/game that the account creation completed
 *
 * @param ErrorStatus whether the account created successfully or not
 */
delegate OnCreateOnlineAccountCompleted(EOnlineAccountCreateStatus ErrorStatus);

/**
 * Sets the delegate used to notify the gameplay code that account creation completed
 *
 * @param AccountCreateDelegate the delegate to use for notifications
 */
function AddCreateOnlineAccountCompletedDelegate(delegate<OnCreateOnlineAccountCompleted> AccountCreateDelegate)
{
	if (AccountCreateDelegates.Find(AccountCreateDelegate) == INDEX_NONE)
	{
		AccountCreateDelegates[AccountCreateDelegates.Length] = AccountCreateDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param AccountCreateDelegate the delegate to use for notifications
 */
function ClearCreateOnlineAccountCompletedDelegate(delegate<OnCreateOnlineAccountCompleted> AccountCreateDelegate)
{
	local int RemoveIndex;

	RemoveIndex = AccountCreateDelegates.Find(AccountCreateDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		AccountCreateDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Creates a non-networked account on the local system. Password is only used
 * when supplied. Otherwise the account is not secured.
 *
 * @param UserName the unique nickname of the account
 * @param Password the password securing the account
 *
 * @return true if the account was created, false otherwise
 */
function bool CreateLocalAccount(string UserName,optional string Password);

/**
 * Changes the name of a local account
 *
 * @param UserName the unique nickname of the account
 * @param Password the password securing the account
 *
 * @return true if the account was renamed, false otherwise
 */
function bool RenameLocalAccount(string NewUserName,string OldUserName,optional string Password);

/**
 * Deletes a local account if the password matches
 *
 * @param UserName the unique nickname of the account
 * @param Password the password securing the account
 *
 * @return true if the account was deleted, false otherwise
 */
function bool DeleteLocalAccount(string UserName,optional string Password);

/**
 * Fetches a list of local accounts
 *
 * @param Accounts the array that is populated with the accounts
 *
 * @return true if the list was read, false otherwise
 */
function bool GetLocalAccountNames(out array<string> Accounts);

/**
 * Sets the online status information to use for the specified player. Used to
 * tell other players what the player is doing (playing, menus, away, etc.)
 *
 * @param LocalUserNum the controller number of the associated user
 * @param StatusId the status id to use (maps to strings where possible)
 * @param LocalizedStringSettings the list of localized string settings to set
 * @param Properties the list of properties to set
 */
native function SetOnlineStatus(byte LocalUserNum,int StatusId,const out array<LocalizedStringSetting> LocalizedStringSettings,const out array<SettingsProperty> Properties);

/**
 * Displays the UI that shows the keyboard for inputing text
 *
 * @param LocalUserNum the controller number of the associated user
 * @param TitleText the title to display to the user
 * @param DescriptionText the text telling the user what to input
 * @param bIsPassword whether the item being entered is a password or not
 * @param bShouldValidate whether to apply the string validation API after input or not
 * @param DefaultText the default string to display
 * @param MaxResultLength the maximum length string expected to be filled in
 *
 * @return TRUE if it was able to show the UI, FALSE if it failed
 */
native function bool ShowKeyboardUI(byte LocalUserNum,string TitleText,string DescriptionText,
	optional bool bIsPassword = false,
	optional bool bShouldValidate = true,
	optional string DefaultText,
	optional int MaxResultLength = 256);

/**
 * Adds the delegate used to notify the gameplay code that the user has completed
 * their keyboard input
 *
 * @param InputDelegate the delegate to use for notifications
 */
function AddKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate)
{
	// Add this delegate to the array if not already present
	if (KeyboardInputDelegates.Find(InputDelegate) == INDEX_NONE)
	{
		KeyboardInputDelegates[KeyboardInputDelegates.Length] = InputDelegate;
	}
}

/**
 * Clears the delegate used to notify the gameplay code that the user has completed
 * their keyboard input
 *
 * @param InputDelegate the delegate to use for notifications
 */
function ClearKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate)
{
	local int RemoveIndex;

	RemoveIndex = KeyboardInputDelegates.Find(InputDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		KeyboardInputDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Fetches the results of the input
 *
 * @param bWasCanceled whether the user cancelled the input or not
 *
 * @return the string entered by the user. Note the string will be empty if it
 * fails validation
 */
function string GetKeyboardInputResults(out byte bWasCanceled)
{
	bWasCanceled = bWasKeyboardInputCanceled;
	return KeyboardResultsString;
}

/**
 * Delegate used when the keyboard input request has completed
 *
 * @param bWasSuccessful true if the async action completed without error, false if there was an error
 */
delegate OnKeyboardInputComplete(bool bWasSuccessful);

/**
 * Sends a friend invite to the specified player
 *
 * @param LocalUserNum the user that is sending the invite
 * @param NewFriend the player to send the friend request to
 * @param Message the message to display to the recipient
 *
 * @return true if successful, false otherwise
 */
native function bool AddFriend(byte LocalUserNum,UniqueNetId NewFriend,optional string Message);

/**
 * Sends a friend invite to the specified player nick
 *
 * @param LocalUserNum the user that is sending the invite
 * @param FriendName the name of the player to send the invite to
 * @param Message the message to display to the recipient
 *
 * @return true if successful, false otherwise
 */
native function bool AddFriendByName(byte LocalUserNum,string FriendName,optional string Message);

/**
 * Called when a friend invite arrives for a local player
 *
 * @param bWasSuccessful true if successfully added, false if not found or failed
 */
delegate OnAddFriendByNameComplete(bool bWasSuccessful);

/**
 * Adds the delegate used to notify the gameplay code that the user has received a friend invite
 *
 * @param LocalUserNum the user associated with the notification
 * @param FriendDelegate the delegate to use for notifications
 */
function AddAddFriendByNameCompleteDelegate(byte LocalUserNum,delegate<OnAddFriendByNameComplete> FriendDelegate)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		if (AddFriendByNameCompleteDelegates.Find(FriendDelegate) == INDEX_NONE)
		{
			AddFriendByNameCompleteDelegates[AddFriendByNameCompleteDelegates.Length] = FriendDelegate;
		}
	}
}

/**
 * Removes the delegate specified from the list
 *
 * @param LocalUserNum the user associated with the notification
 * @param FriendDelegate the delegate to use for notifications
 */
function ClearAddFriendByNameCompleteDelegate(byte LocalUserNum,delegate<OnAddFriendByNameComplete> FriendDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == LoggedInPlayerNum)
	{
		RemoveIndex = AddFriendByNameCompleteDelegates.Find(FriendDelegate);
		if (RemoveIndex != INDEX_NONE)
		{
			AddFriendByNameCompleteDelegates.Remove(RemoveIndex,1);
		}
	}
}

/**
 * Removes a friend from the player's friend list
 *
 * @param LocalUserNum the user that is removing the friend
 * @param FormerFriend the player to remove from the friend list
 *
 * @return true if successful, false otherwise
 */
native function bool RemoveFriend(byte LocalUserNum,UniqueNetId FormerFriend);

/**
 * Used to accept a friend invite sent to this player
 *
 * @param LocalUserNum the user the invite is for
 * @param RequestingPlayer the player the invite is from
 *
 * @param true if successful, false otherwise
 */
native function bool AcceptFriendInvite(byte LocalUserNum,UniqueNetId RequestingPlayer);

/**
 * Used to deny a friend request sent to this player
 *
 * @param LocalUserNum the user the invite is for
 * @param RequestingPlayer the player the invite is from
 *
 * @param true if successful, false otherwise
 */
native function bool DenyFriendInvite(byte LocalUserNum,UniqueNetId RequestingPlayer);

/**
 * Called when a friend invite arrives for a local player
 *
 * @param LocalUserNum the user that is receiving the invite
 * @param RequestingPlayer the player sending the friend request
 * @param RequestingNick the nick of the player sending the friend request
 * @param Message the message to display to the recipient
 *
 * @return true if successful, false otherwise
 */
delegate OnFriendInviteReceived(byte LocalUserNum,UniqueNetId RequestingPlayer,string RequestingNick,string Message);

/**
 * Adds the delegate used to notify the gameplay code that the user has received a friend invite
 *
 * @param LocalUserNum the user associated with the notification
 * @param InviteDelegate the delegate to use for notifications
 */
function AddFriendInviteReceivedDelegate(byte LocalUserNum,delegate<OnFriendInviteReceived> InviteDelegate)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		if (FriendInviteReceivedDelegates.Find(InviteDelegate) == INDEX_NONE)
		{
			FriendInviteReceivedDelegates[FriendInviteReceivedDelegates.Length] = InviteDelegate;
		}
	}
}

/**
 * Removes the delegate specified from the list
 *
 * @param LocalUserNum the user associated with the notification
 * @param InviteDelegate the delegate to use for notifications
 */
function ClearFriendInviteReceivedDelegate(byte LocalUserNum,delegate<OnFriendInviteReceived> InviteDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == LoggedInPlayerNum)
	{
		RemoveIndex = FriendInviteReceivedDelegates.Find(InviteDelegate);
		if (RemoveIndex != INDEX_NONE)
		{
			FriendInviteReceivedDelegates.Remove(RemoveIndex,1);
		}
	}
}

/**
 * Sends a message to a friend
 *
 * @param LocalUserNum the user that is sending the message
 * @param Friend the player to send the message to
 * @param Message the message to display to the recipient
 *
 * @return true if successful, false otherwise
 */
native function bool SendMessageToFriend(byte LocalUserNum,UniqueNetId Friend,string Message);

/**
 * Sends an invitation to play in the player's current session
 *
 * @param LocalUserNum the user that is sending the invite
 * @param Friend the player to send the invite to
 * @param Text the text of the message for the invite
 *
 * @return true if successful, false otherwise
 */
native function bool SendGameInviteToFriend(byte LocalUserNum,UniqueNetId Friend,optional string Text);

/**
 * Sends invitations to play in the player's current session
 *
 * @param LocalUserNum the user that is sending the invite
 * @param Friends the player to send the invite to
 * @param Text the text of the message for the invite
 *
 * @return true if successful, false otherwise
 */
native function bool SendGameInviteToFriends(byte LocalUserNum,array<UniqueNetId> Friends,optional string Text);

/**
 * Called when the online system receives a game invite that needs handling
 *
 * @param LocalUserNum the user that is receiving the invite
 * @param InviterName the nick name of the person sending the invite
 */
delegate OnReceivedGameInvite(byte LocalUserNum,string InviterName);

/**
 * Adds the delegate used to notify the gameplay code that the user has received a game invite
 *
 * @param LocalUserNum the user associated with the notification
 * @param ReceivedGameInviteDelegate the delegate to use for notifications
 */
function AddReceivedGameInviteDelegate(byte LocalUserNum,delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		if (ReceivedGameInviteDelegates.Find(ReceivedGameInviteDelegate) == INDEX_NONE)
		{
			ReceivedGameInviteDelegates[ReceivedGameInviteDelegates.Length] = ReceivedGameInviteDelegate;
		}
	}
}

/**
 * Removes the delegate specified from the list
 *
 * @param LocalUserNum the user associated with the notification
 * @param ReceivedGameInviteDelegate the delegate to use for notifications
 */
function ClearReceivedGameInviteDelegate(byte LocalUserNum,delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == LoggedInPlayerNum)
	{
		RemoveIndex = ReceivedGameInviteDelegates.Find(ReceivedGameInviteDelegate);
		if (RemoveIndex != INDEX_NONE)
		{
			ReceivedGameInviteDelegates.Remove(RemoveIndex,1);
		}
	}
}

/**
 * Allows the local player to follow a friend into a game
 *
 * @param LocalUserNum the local player wanting to join
 * @param Friend the player that is being followed
 *
 * @return true if the async call worked, false otherwise
 */
native function bool JoinFriendGame(byte LocalUserNum,UniqueNetId Friend);

/**
 * Called once the join task has completed
 *
 * @param bWasSuccessful the session was found and is joinable, false otherwise
 */
delegate OnJoinFriendGameComplete(bool bWasSuccessful);

/**
 * Sets the delegate used to notify when the join friend is complete
 *
 * @param JoinFriendGameCompleteDelegate the delegate to use for notifications
 */
function AddJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate)
{
	if (JoinFriendGameCompleteDelegates.Find(JoinFriendGameCompleteDelegate) == INDEX_NONE)
	{
		JoinFriendGameCompleteDelegates[JoinFriendGameCompleteDelegates.Length] = JoinFriendGameCompleteDelegate;
	}
}

/**
 * Removes the delegate from the list of notifications
 *
 * @param JoinFriendGameCompleteDelegate the delegate to use for notifications
 */
function ClearJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate)
{
	local int RemoveIndex;

	RemoveIndex = JoinFriendGameCompleteDelegates.Find(JoinFriendGameCompleteDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		JoinFriendGameCompleteDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Returns the list of messages for the specified player
 *
 * @param LocalUserNum the local player wanting to join
 * @param FriendMessages the set of messages cached locally for the player
 */
function GetFriendMessages(byte LocalUserNum,out array<OnlineFriendMessage> FriendMessages)
{
	if (LocalUserNum == 0)
	{
		FriendMessages = CachedFriendMessages;
	}
}

/**
 * Called when a friend invite arrives for a local player
 *
 * @param LocalUserNum the user that is receiving the invite
 * @param SendingPlayer the player sending the friend request
 * @param SendingNick the nick of the player sending the friend request
 * @param Message the message to display to the recipient
 *
 * @return true if successful, false otherwise
 */
delegate OnFriendMessageReceived(byte LocalUserNum,UniqueNetId SendingPlayer,string SendingNick,string Message);

/**
 * Adds the delegate used to notify the gameplay code that the user has received a friend invite
 *
 * @param LocalUserNum the user associated with the notification
 * @param MessageDelegate the delegate to use for notifications
 */
function AddFriendMessageReceivedDelegate(byte LocalUserNum,delegate<OnFriendMessageReceived> MessageDelegate)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		if (FriendMessageReceivedDelegates.Find(MessageDelegate) == INDEX_NONE)
		{
			FriendMessageReceivedDelegates[FriendMessageReceivedDelegates.Length] = MessageDelegate;
		}
	}
}

/**
 * Removes the delegate specified from the list
 *
 * @param LocalUserNum the user associated with the notification
 * @param MessageDelegate the delegate to use for notifications
 */
function ClearFriendMessageReceivedDelegate(byte LocalUserNum,delegate<OnFriendMessageReceived> MessageDelegate)
{
	local int RemoveIndex;

	if (LocalUserNum == LoggedInPlayerNum)
	{
		RemoveIndex = FriendMessageReceivedDelegates.Find(MessageDelegate);
		if (RemoveIndex != INDEX_NONE)
		{
			FriendMessageReceivedDelegates.Remove(RemoveIndex,1);
		}
	}
}

/**
 * Reads the host's stat guid for synching up stats. Only valid on the host.
 *
 * @return the host's stat guid
 */
native function string GetHostStatGuid();

/**
 * Registers the host's stat guid with the client for verification they are part of
 * the stat. Note this is an async task for any backend communication that needs to
 * happen before the registration is deemed complete
 *
 * @param HostStatGuid the host's stat guid
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool RegisterHostStatGuid(const out string HostStatGuid);

/**
 * Called when the host stat guid registration is complete
 *
 * @param bWasSuccessful whether the registration has completed or not
 */
delegate OnRegisterHostStatGuidComplete(bool bWasSuccessful);

/**
 * Adds the delegate for notifying when the host guid registration is done
 *
 * @param RegisterHostStatGuidCompleteDelegate the delegate to use for notifications
 */
function AddRegisterHostStatGuidCompleteDelegate(delegate<OnFlushOnlineStatsComplete> RegisterHostStatGuidCompleteDelegate)
{
	if (RegisterHostStatGuidCompleteDelegates.Find(RegisterHostStatGuidCompleteDelegate) == INDEX_NONE)
	{
		RegisterHostStatGuidCompleteDelegates[RegisterHostStatGuidCompleteDelegates.Length] = RegisterHostStatGuidCompleteDelegate;
	}
}

/**
 * Clears the delegate used to notify the gameplay code
 *
 * @param RegisterHostStatGuidCompleteDelegate the delegate to use for notifications
 */
function ClearRegisterHostStatGuidCompleteDelegateDelegate(delegate<OnFlushOnlineStatsComplete> RegisterHostStatGuidCompleteDelegate)
{
	local int RemoveIndex;

	RemoveIndex = RegisterHostStatGuidCompleteDelegates.Find(RegisterHostStatGuidCompleteDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		RegisterHostStatGuidCompleteDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Reads the client's stat guid that was generated by registering the host's guid
 * Used for synching up stats. Only valid on the client. Only callable after the
 * host registration has completed
 *
 * @return the client's stat guid
 */
native function string GetClientStatGuid();

/**
 * Registers the client's stat guid on the host to validate that the client was in the stat.
 * Used for synching up stats. Only valid on the host.
 *
 * @param PlayerId the client's unique net id
 * @param ClientStatGuid the client's stat guid
 *
 * @return TRUE if the call is successful, FALSE otherwise
 */
native function bool RegisterStatGuid(UniqueNetId PlayerId,const out string ClientStatGuid);

/**
 * Reads the game specific news from the online subsystem
 *
 * @param LocalUserNum the local user the news is being read for
 *
 * @return true if the async task was successfully started, false otherwise
 */
native function bool ReadGameNews(byte LocalUserNum);

/**
 * Delegate used in notifying the UI/game that the news read operation completed
 *
 * @param bWasSuccessful true if the read completed ok, false otherwise
 */
delegate OnReadGameNewsCompleted(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that news reading has completed
 *
 * @param ReadGameNewsDelegate the delegate to use for notifications
 */
function AddReadGameNewsCompletedDelegate(delegate<OnReadGameNewsCompleted> ReadGameNewsDelegate)
{
	if (ReadGameNewsDelegates.Find(ReadGameNewsDelegate) == INDEX_NONE)
	{
		ReadGameNewsDelegates[ReadGameNewsDelegates.Length] = ReadGameNewsDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param ReadGameNewsDelegate the delegate to use for notifications
 */
function ClearReadGameNewsCompletedDelegate(delegate<OnReadGameNewsCompleted> ReadGameNewsDelegate)
{
	local int RemoveIndex;

	RemoveIndex = ReadGameNewsDelegates.Find(ReadGameNewsDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		ReadGameNewsDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Returns the game specific news from the cache
 *
 * @param LocalUserNum the local user the news is being read for
 *
 * @return an empty string if no news was read, otherwise the contents of the read
 */
function string GetGameNews(byte LocalUserNum)
{
	return CachedNews;
}

/**
 * Reads the game specific content announcements from the online subsystem
 *
 * @param LocalUserNum the local user the request is for
 *
 * @return true if the async task was successfully started, false otherwise
 */
native function bool ReadContentAnnouncements(byte LocalUserNum);

/**
 * Delegate used in notifying the UI/game that the content announcements read operation completed
 *
 * @param bWasSuccessful true if the read completed ok, false otherwise
 */
delegate OnReadContentAnnouncementsCompleted(bool bWasSuccessful);

/**
 * Sets the delegate used to notify the gameplay code that content announcements reading has completed
 *
 * @param ReadContentAnnouncementsDelegate the delegate to use for notifications
 */
function AddReadContentAnnouncementsCompletedDelegate(delegate<OnReadContentAnnouncementsCompleted> ReadContentAnnouncementsDelegate)
{
	if (ReadContentAnnouncementsDelegates.Find(ReadContentAnnouncementsDelegate) == INDEX_NONE)
	{
		ReadContentAnnouncementsDelegates[ReadContentAnnouncementsDelegates.Length] = ReadContentAnnouncementsDelegate;
	}
}

/**
 * Removes the specified delegate from the notification list
 *
 * @param ReadContentAnnouncementsDelegate the delegate to use for notifications
 */
function ClearReadContentAnnouncementsCompletedDelegate(delegate<OnReadContentAnnouncementsCompleted> ReadContentAnnouncementsDelegate)
{
	local int RemoveIndex;

	RemoveIndex = ReadContentAnnouncementsDelegates.Find(ReadContentAnnouncementsDelegate);
	if (RemoveIndex != INDEX_NONE)
	{
		ReadContentAnnouncementsDelegates.Remove(RemoveIndex,1);
	}
}

/**
 * Returns the game specific content announcements from the cache
 *
 * @param LocalUserNum the local user the content announcements is being read for
 *
 * @return an empty string if no data was read, otherwise the contents of the read
 */
function string GetContentAnnouncements(byte LocalUserNum)
{
	return CachedContentAnnouncements;
}

/**
 * Mutes all voice or all but friends
 *
 * @param LocalUserNum the local user that is making the change
 * @param bAllowFriends whether to mute everyone or allow friends
 */
function bool MuteAll(byte LocalUserNum,bool bAllowFriends)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		CurrentLocalTalker.MuteType = bAllowFriends ? MUTE_AllButFriends : MUTE_All;
		return true;
	}
	return false;
}

/**
 * Allows all speakers to send voice
 *
 * @param LocalUserNum the local user that is making the change
 */
function bool UnmuteAll(byte LocalUserNum)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		CurrentLocalTalker.MuteType = MUTE_None;
		return true;
	}
	return false;
}

/**
 * Deletes a message from the list of messages
 *
 * @param LocalUserNum the user that is deleting the message
 * @param MessageIndex the index of the message to delete
 *
 * @return true if the message was deleted, false otherwise
 */
function bool DeleteMessage(byte LocalUserNum,int MessageIndex)
{
	if (LocalUserNum == LoggedInPlayerNum)
	{
		// If it's safe to access, remove it
		if (MessageIndex >= 0 && MessageIndex < CachedFriendMessages.Length)
		{
			//Delete the message now
			CachedFriendMessages.Remove(MessageIndex,1);

			//Save all remaining messages to disk
			WriteFriendMessages(LocalUserNum);
			return true;
		}
	}
	return false;
}

/**
 * @return true if the product key is valid, false if it is invalid
 */
native function bool IsKeyValid();

/**
 * Saves the product key
 *
 * @param ProductKey the product key the user entered
 *
 * @return true if the key was stored successfully, false otherwise
 */
native function bool SaveKey(string ProductKey);

/************************************************************************/
/*   UT3G implementation for trophies                                   */
/************************************************************************/

/**
* Displays the UI that allows a player to give feedback on another player
*
* @param LocalUserNum the controller number of the associated user
* @param PlayerId the id of the player having feedback given for
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowFeedbackUI(byte LocalUserNum,UniqueNetId PlayerId)  //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowFeedbackUI");
	return false;
}

/**
* Displays the gamer card UI for the specified player
*
* @param LocalUserNum the controller number of the associated user
* @param PlayerId the id of the player to show the gamer card of
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowGamerCardUI(byte LocalUserNum,UniqueNetId PlayerId) //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowGamerCardUI");
	return false;
}

/**
* Displays the messages UI for a player
*
* @param LocalUserNum the controller number of the associated user
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowMessagesUI(byte LocalUserNum)	//should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowMessagesUI");
	return false;
}

/**
* Displays the achievements UI for a player
*
* @param LocalUserNum the controller number of the associated user
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowAchievementsUI(byte LocalUserNum)  //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowAchievementsUI");
	return false;
}

/**
* Displays the invite ui
*
* @param LocalUserNum the local user sending the invite
* @param InviteText the string to prefill the UI with
*/
function bool ShowInviteUI(byte LocalUserNum,optional string InviteText)   //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowInviteUI");
	return false;
}

/**
* Displays the marketplace UI for content
*
* @param LocalUserNum the local user viewing available content
*/
function bool ShowContentMarketplaceUI(byte LocalUserNum) //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowContentMarketplaceUI");
	return false;
}

/**
* Displays the marketplace UI for memberships
*
* @param LocalUserNum the local user viewing available memberships
*/
function bool ShowMembershipMarketplaceUI(byte LocalUserNum)   //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowMembershipMarketplaceUI");
	return false;
}

/**
* Displays the UI that allows the user to choose which device to save content to
*
* @param LocalUserNum the controller number of the associated user
* @param SizeNeeded the size of the data to be saved in bytes
* @param bForceShowUI true to always show the UI, false to only show the
*		  UI if there are multiple valid choices
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowDeviceSelectionUI(byte LocalUserNum,int SizeNeeded,bool bForceShowUI = false) //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ShowDeviceSelectionUI");
	return false;
}

/**
* Adds the delegate used to notify the gameplay code that the user has completed
* their device selection
*
* @param DeviceDelegate the delegate to use for notifications
*/
function AddDeviceSelectionDoneDelegate(byte LocalUserNum,delegate<OnDeviceSelectionComplete> DeviceDelegate) //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!AddDeviceSelectionDoneDelegate");
}

/**
* Removes the specified delegate from the list of callbacks
*
* @param DeviceDelegate the delegate to use for notifications
*/
function ClearDeviceSelectionDoneDelegate(byte LocalUserNum,delegate<OnDeviceSelectionComplete> DeviceDelegate)  //should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ClearDeviceSelectionDoneDelegate");
}
/**
* Fetches the results of the device selection
*
* @param LocalUserNum the player to check the results for
* @param DeviceName out param that gets a copy of the string
*
* @return the ID of the device that was selected
* NOTE: Zero means the user hasn't selected one
*/
function int GetDeviceSelectionResults(byte LocalUserNum,out string DeviceName) //should do nothing 
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!GetDeviceSelectionResults");
	return 0;
}
/**
* Delegate used when the device selection request has completed
*
* @param bWasSuccessful true if the async action completed without error, false if there was an error
*/
delegate OnDeviceSelectionComplete(bool bWasSuccessful);  //should do nothing

/**
* Checks the device id to determine if it is still valid (could be removed)
*
* @param DeviceId the device to check
*
* @return true if valid, false otherwise
*/
function bool IsDeviceValid(int DeviceId)	//should do nothing
{
	LogInternal("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!IsDeviceValid");
	return false;
}
/**
* Unlocks the specified achievement for the specified user
*
* @param LocalUserNum the controller number of the associated user
* @param AchievementId the id of the achievement to unlock
*
* @return TRUE if the call worked, FALSE otherwise
*/
native function bool UnlockAchievement(byte LocalUserNum,int AchievementId);

/**
* Adds the delegate used to notify the gameplay code that the achievement unlocking has completed
*
* @param LocalUserNum which user to watch for read complete notifications
* @param UnlockAchievementCompleteDelegate the delegate to use for notifications
*/
function AddUnlockAchievementCompleteDelegate(byte LocalUserNum,delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate)
{
	// Make sure the user is valid
	if (LocalUserNum >= 0 && LocalUserNum < 4)
	{
		if (PerUserDelegates[LocalUserNum].AchievementDelegates.Find(UnlockAchievementCompleteDelegate) == INDEX_NONE)
		{
			PerUserDelegates[LocalUserNum].AchievementDelegates[PerUserDelegates[LocalUserNum].AchievementDelegates.Length] = UnlockAchievementCompleteDelegate;
		}
	}
	else
	{
		WarnInternal("Invalid index ("$LocalUserNum$") passed to AddUnlockAchievementCompleteDelegate()");
	}
}

/**
* Clears the delegate used to notify the gameplay code that the achievement unlocking has completed
*
* @param LocalUserNum which user to watch for read complete notifications
* @param UnlockAchievementCompleteDelegate the delegate to use for notifications
*/
function ClearUnlockAchievementCompleteDelegate(byte LocalUserNum,delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate)
{
	local int RemoveIndex;

	// Make sure the user is valid
	if (LocalUserNum >= 0 && LocalUserNum < 4)
	{
		RemoveIndex = PerUserDelegates[LocalUserNum].AchievementDelegates.Find(UnlockAchievementCompleteDelegate);
		if (RemoveIndex != INDEX_NONE)
		{
			PerUserDelegates[LocalUserNum].AchievementDelegates.Remove(RemoveIndex,1);
		}
	}
	else
	{
		WarnInternal("Invalid index ("$LocalUserNum$") passed to ClearUnlockAchievementCompleteDelegate()");
	}
}

/**
* Delegate used when the achievement unlocking has completed
*
* @param bWasSuccessful true if the async action completed without error, false if there was an error
*/
delegate OnUnlockAchievementComplete(bool bWasSuccessful);

/**
* Returns whether or not an achievement has been unlocked
*
* @return true if the achievement is already unlocked, false otherwise
*/
native function bool IsAchievementUnlocked(int AchievementId);

/**
* Unlocks a gamer picture for the local user
*
* @param LocalUserNum the user to unlock the picture for
* @param PictureId the id of the picture to unlock
*/
function bool UnlockGamerPicture(byte LocalUserNum,int PictureId) //should do nothing
{
	return false;
}

/**
* Called when an external change to player profile data has occured
*/
delegate OnProfileDataChanged();  //should do nothing

/**
* Sets the delegate used to notify the gameplay code that someone has changed their profile data externally
*
* @param LocalUserNum the user the delegate is interested in
* @param ProfileDataChangedDelegate the delegate to use for notifications
*/
function AddProfileDataChangedDelegate(byte LocalUserNum,delegate<OnProfileDataChanged> ProfileDataChangedDelegate) //should do nothing
{
}
/**
* Clears the delegate used to notify the gameplay code that someone has changed their profile data externally
*
* @param LocalUserNum the user the delegate is interested in
* @param ProfileDataChangedDelegate the delegate to use for notifications
*/
function ClearProfileDataChangedDelegate(byte LocalUserNum,delegate<OnProfileDataChanged> ProfileDataChangedDelegate)   //should do nothing
{
}
/**
* Displays the UI that shows a user's list of friends
*
* @param LocalUserNum the controller number of the associated user
* @param PlayerId the id of the player being invited
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowFriendsInviteUI(byte LocalUserNum,UniqueNetId PlayerId)    //should do nothing
{
	return false;
}
/**
* Displays the UI that shows the player list
*
* @param LocalUserNum the controller number of the associated user
*
* @return TRUE if it was able to show the UI, FALSE if it failed
*/
function bool ShowPlayersUI(byte LocalUserNum) //should do nothing
{
	return false;
}

defaultproperties
{
   LocalProfileName="Giocatore"
   LoggedInPlayerName="Local Profile"
   ProfileDataDirectory="../UTGame/SaveData"
   ProfileDataExtension=".ue3profile"
   ProfileMessageDataExtension=".ue3messages"
   GameID=1727
   ProductID=11097
   NamespaceID=64
   StatsVersion=2
   NickStatsKeyId=1
   PlaceStatsKeyId=2
   DuelStatsKeyId=521
   NewsUrl="http://gamecontent.unrealtournament3.com/motd/motd.ita"
   ContentAnnouncementsUrl="http://gamecontent.unrealtournament3.com/dlc/ContentAnnouncement.ita"
   StatsKeyMappings(0)=(ViewId=1,PropertyId=268435783,KeyId=521)
   StatsKeyMappings(1)=(ViewId=2,PropertyId=268435783,KeyId=521)
   StatsKeyMappings(2)=(ViewId=1,KeyId=262)
   StatsKeyMappings(3)=(ViewId=1,PropertyId=268435778,KeyId=265)
   StatsKeyMappings(4)=(ViewId=1,PropertyId=268435462,KeyId=264)
   StatsKeyMappings(5)=(ViewId=1,PropertyId=268435549,KeyId=266)
   StatsKeyMappings(6)=(ViewId=1,PropertyId=268435550,KeyId=267)
   StatsKeyMappings(7)=(ViewId=1,PropertyId=268435551,KeyId=268)
   StatsKeyMappings(8)=(ViewId=1,PropertyId=268435552,KeyId=269)
   StatsKeyMappings(9)=(ViewId=1,PropertyId=268435553,KeyId=271)
   StatsKeyMappings(10)=(ViewId=1,PropertyId=268435779,KeyId=270)
   StatsKeyMappings(11)=(ViewId=1,PropertyId=268435554,KeyId=272)
   StatsKeyMappings(12)=(ViewId=1,PropertyId=268435461,KeyId=263)
   StatsKeyMappings(13)=(ViewId=1,PropertyId=268435556,KeyId=273)
   StatsKeyMappings(14)=(ViewId=1,PropertyId=268435729,KeyId=275)
   StatsKeyMappings(15)=(ViewId=1,PropertyId=268435734,KeyId=274)
   StatsKeyMappings(16)=(ViewId=1,PropertyId=268435555,KeyId=276)
   StatsKeyMappings(17)=(ViewId=1,PropertyId=268435558,KeyId=277)
   StatsKeyMappings(18)=(ViewId=1,PropertyId=268435560,KeyId=278)
   StatsKeyMappings(19)=(ViewId=1,PropertyId=268435561,KeyId=280)
   StatsKeyMappings(20)=(ViewId=1,PropertyId=268435562,KeyId=281)
   StatsKeyMappings(21)=(ViewId=1,PropertyId=268435563,KeyId=282)
   StatsKeyMappings(22)=(ViewId=1,PropertyId=268435564,KeyId=283)
   StatsKeyMappings(23)=(ViewId=1,PropertyId=268435565,KeyId=284)
   StatsKeyMappings(24)=(ViewId=1,PropertyId=268435566,KeyId=285)
   StatsKeyMappings(25)=(ViewId=1,PropertyId=268435567,KeyId=286)
   StatsKeyMappings(26)=(ViewId=1,PropertyId=268435568,KeyId=287)
   StatsKeyMappings(27)=(ViewId=1,PropertyId=268435569,KeyId=288)
   StatsKeyMappings(28)=(ViewId=1,PropertyId=268435570,KeyId=289)
   StatsKeyMappings(29)=(ViewId=1,PropertyId=268435571,KeyId=290)
   StatsKeyMappings(30)=(ViewId=1,PropertyId=268435572,KeyId=291)
   StatsKeyMappings(31)=(ViewId=1,PropertyId=268435707,KeyId=298)
   StatsKeyMappings(32)=(ViewId=1,PropertyId=268435719,KeyId=292)
   StatsKeyMappings(33)=(ViewId=1,PropertyId=268435708,KeyId=299)
   StatsKeyMappings(34)=(ViewId=1,PropertyId=268435720,KeyId=293)
   StatsKeyMappings(35)=(ViewId=1,PropertyId=268435721,KeyId=294)
   StatsKeyMappings(36)=(ViewId=1,PropertyId=268435722,KeyId=295)
   StatsKeyMappings(37)=(ViewId=1,PropertyId=268435782,KeyId=296)
   StatsKeyMappings(38)=(ViewId=1,PropertyId=268435723,KeyId=297)
   StatsKeyMappings(39)=(ViewId=1,PropertyId=268435727,KeyId=300)
   StatsKeyMappings(40)=(ViewId=1,PropertyId=268435724,KeyId=301)
   StatsKeyMappings(41)=(ViewId=1,PropertyId=268435728,KeyId=302)
   StatsKeyMappings(42)=(ViewId=1,PropertyId=268435726,KeyId=303)
   StatsKeyMappings(43)=(ViewId=1,PropertyId=268435573,KeyId=304)
   StatsKeyMappings(44)=(ViewId=1,PropertyId=268435574,KeyId=305)
   StatsKeyMappings(45)=(ViewId=1,PropertyId=268435575,KeyId=306)
   StatsKeyMappings(46)=(ViewId=1,PropertyId=268435576,KeyId=307)
   StatsKeyMappings(47)=(ViewId=1,PropertyId=268435577,KeyId=308)
   StatsKeyMappings(48)=(ViewId=1,PropertyId=268435578,KeyId=309)
   StatsKeyMappings(49)=(ViewId=1,PropertyId=268435579,KeyId=310)
   StatsKeyMappings(50)=(ViewId=1,PropertyId=268435580,KeyId=311)
   StatsKeyMappings(51)=(ViewId=1,PropertyId=268435581,KeyId=312)
   StatsKeyMappings(52)=(ViewId=1,PropertyId=268435582,KeyId=313)
   StatsKeyMappings(53)=(ViewId=1,PropertyId=268435583,KeyId=314)
   StatsKeyMappings(54)=(ViewId=1,PropertyId=268435584,KeyId=315)
   StatsKeyMappings(55)=(ViewId=1,PropertyId=268435585,KeyId=316)
   StatsKeyMappings(56)=(ViewId=1,PropertyId=268435586,KeyId=317)
   StatsKeyMappings(57)=(ViewId=1,PropertyId=268435588,KeyId=319)
   StatsKeyMappings(58)=(ViewId=1,PropertyId=268435587,KeyId=318)
   StatsKeyMappings(59)=(ViewId=1,PropertyId=268435589,KeyId=320)
   StatsKeyMappings(60)=(ViewId=2,KeyId=3)
   StatsKeyMappings(61)=(ViewId=2,PropertyId=268435778,KeyId=6)
   StatsKeyMappings(62)=(ViewId=2,PropertyId=268435462,KeyId=5)
   StatsKeyMappings(63)=(ViewId=2,PropertyId=268435549,KeyId=7)
   StatsKeyMappings(64)=(ViewId=2,PropertyId=268435550,KeyId=8)
   StatsKeyMappings(65)=(ViewId=2,PropertyId=268435551,KeyId=9)
   StatsKeyMappings(66)=(ViewId=2,PropertyId=268435552,KeyId=10)
   StatsKeyMappings(67)=(ViewId=2,PropertyId=268435553,KeyId=12)
   StatsKeyMappings(68)=(ViewId=2,PropertyId=268435779,KeyId=11)
   StatsKeyMappings(69)=(ViewId=2,PropertyId=268435554,KeyId=13)
   StatsKeyMappings(70)=(ViewId=2,PropertyId=268435461,KeyId=4)
   StatsKeyMappings(71)=(ViewId=2,PropertyId=268435556,KeyId=14)
   StatsKeyMappings(72)=(ViewId=2,PropertyId=268435729,KeyId=16)
   StatsKeyMappings(73)=(ViewId=2,PropertyId=268435734,KeyId=15)
   StatsKeyMappings(74)=(ViewId=2,PropertyId=268435555,KeyId=17)
   StatsKeyMappings(75)=(ViewId=2,PropertyId=268435558,KeyId=18)
   StatsKeyMappings(76)=(ViewId=2,PropertyId=268435560,KeyId=19)
   StatsKeyMappings(77)=(ViewId=2,PropertyId=268435561,KeyId=21)
   StatsKeyMappings(78)=(ViewId=2,PropertyId=268435562,KeyId=22)
   StatsKeyMappings(79)=(ViewId=2,PropertyId=268435563,KeyId=23)
   StatsKeyMappings(80)=(ViewId=2,PropertyId=268435564,KeyId=24)
   StatsKeyMappings(81)=(ViewId=2,PropertyId=268435565,KeyId=25)
   StatsKeyMappings(82)=(ViewId=2,PropertyId=268435566,KeyId=26)
   StatsKeyMappings(83)=(ViewId=2,PropertyId=268435567,KeyId=27)
   StatsKeyMappings(84)=(ViewId=2,PropertyId=268435568,KeyId=28)
   StatsKeyMappings(85)=(ViewId=2,PropertyId=268435569,KeyId=29)
   StatsKeyMappings(86)=(ViewId=2,PropertyId=268435570,KeyId=30)
   StatsKeyMappings(87)=(ViewId=2,PropertyId=268435571,KeyId=31)
   StatsKeyMappings(88)=(ViewId=2,PropertyId=268435572,KeyId=32)
   StatsKeyMappings(89)=(ViewId=2,PropertyId=268435707,KeyId=39)
   StatsKeyMappings(90)=(ViewId=2,PropertyId=268435719,KeyId=33)
   StatsKeyMappings(91)=(ViewId=2,PropertyId=268435708,KeyId=40)
   StatsKeyMappings(92)=(ViewId=2,PropertyId=268435720,KeyId=34)
   StatsKeyMappings(93)=(ViewId=2,PropertyId=268435721,KeyId=35)
   StatsKeyMappings(94)=(ViewId=2,PropertyId=268435722,KeyId=36)
   StatsKeyMappings(95)=(ViewId=2,PropertyId=268435782,KeyId=37)
   StatsKeyMappings(96)=(ViewId=2,PropertyId=268435723,KeyId=38)
   StatsKeyMappings(97)=(ViewId=2,PropertyId=268435727,KeyId=41)
   StatsKeyMappings(98)=(ViewId=2,PropertyId=268435724,KeyId=42)
   StatsKeyMappings(99)=(ViewId=2,PropertyId=268435728,KeyId=43)
   StatsKeyMappings(100)=(ViewId=2,PropertyId=268435726,KeyId=44)
   StatsKeyMappings(101)=(ViewId=2,PropertyId=268435573,KeyId=45)
   StatsKeyMappings(102)=(ViewId=2,PropertyId=268435574,KeyId=46)
   StatsKeyMappings(103)=(ViewId=2,PropertyId=268435575,KeyId=47)
   StatsKeyMappings(104)=(ViewId=2,PropertyId=268435576,KeyId=48)
   StatsKeyMappings(105)=(ViewId=2,PropertyId=268435577,KeyId=49)
   StatsKeyMappings(106)=(ViewId=2,PropertyId=268435578,KeyId=50)
   StatsKeyMappings(107)=(ViewId=2,PropertyId=268435579,KeyId=51)
   StatsKeyMappings(108)=
   StatsKeyMappings(109)=(ViewId=2,PropertyId=268435580,KeyId=52)
   StatsKeyMappings(110)=(ViewId=2,PropertyId=268435581,KeyId=53)
   StatsKeyMappings(111)=(ViewId=2,PropertyId=268435582,KeyId=54)
   StatsKeyMappings(112)=(ViewId=2,PropertyId=268435583,KeyId=55)
   StatsKeyMappings(113)=(ViewId=2,PropertyId=268435584,KeyId=56)
   StatsKeyMappings(114)=(ViewId=2,PropertyId=268435585,KeyId=57)
   StatsKeyMappings(115)=(ViewId=2,PropertyId=268435586,KeyId=58)
   StatsKeyMappings(116)=(ViewId=2,PropertyId=268435588,KeyId=60)
   StatsKeyMappings(117)=(ViewId=2,PropertyId=268435587,KeyId=59)
   StatsKeyMappings(118)=(ViewId=2,PropertyId=268435589,KeyId=61)
   StatsKeyMappings(119)=(ViewId=3,KeyId=467)
   StatsKeyMappings(120)=(ViewId=3,PropertyId=268435463,KeyId=468)
   StatsKeyMappings(121)=(ViewId=3,PropertyId=268435464,KeyId=469)
   StatsKeyMappings(122)=(ViewId=3,PropertyId=268435469,KeyId=470)
   StatsKeyMappings(123)=(ViewId=3,PropertyId=268435470,KeyId=471)
   StatsKeyMappings(124)=(ViewId=3,PropertyId=268435471,KeyId=472)
   StatsKeyMappings(125)=(ViewId=3,PropertyId=268435780,KeyId=473)
   StatsKeyMappings(126)=(ViewId=3,PropertyId=268435476,KeyId=474)
   StatsKeyMappings(127)=(ViewId=3,PropertyId=268435477,KeyId=475)
   StatsKeyMappings(128)=(ViewId=3,PropertyId=268435483,KeyId=476)
   StatsKeyMappings(129)=(ViewId=3,PropertyId=268435489,KeyId=477)
   StatsKeyMappings(130)=(ViewId=3,PropertyId=268435490,KeyId=478)
   StatsKeyMappings(131)=(ViewId=3,PropertyId=268435494,KeyId=479)
   StatsKeyMappings(132)=(ViewId=3,PropertyId=268435716,KeyId=480)
   StatsKeyMappings(133)=(ViewId=3,PropertyId=268435496,KeyId=481)
   StatsKeyMappings(134)=(ViewId=3,PropertyId=268435712,KeyId=482)
   StatsKeyMappings(135)=(ViewId=3,PropertyId=268435740,KeyId=483)
   StatsKeyMappings(136)=(ViewId=3,PropertyId=268435499,KeyId=484)
   StatsKeyMappings(137)=(ViewId=3,PropertyId=268435500,KeyId=485)
   StatsKeyMappings(138)=(ViewId=3,PropertyId=268435505,KeyId=486)
   StatsKeyMappings(139)=(ViewId=3,PropertyId=268435506,KeyId=487)
   StatsKeyMappings(140)=(ViewId=3,PropertyId=268435511,KeyId=488)
   StatsKeyMappings(141)=(ViewId=3,PropertyId=268435512,KeyId=489)
   StatsKeyMappings(142)=(ViewId=3,PropertyId=268435513,KeyId=490)
   StatsKeyMappings(143)=(ViewId=3,PropertyId=268435517,KeyId=491)
   StatsKeyMappings(144)=(ViewId=3,PropertyId=268435519,KeyId=492)
   StatsKeyMappings(145)=(ViewId=3,PropertyId=268435520,KeyId=493)
   StatsKeyMappings(146)=(ViewId=3,PropertyId=268435526,KeyId=494)
   StatsKeyMappings(147)=(ViewId=3,PropertyId=268435533,KeyId=495)
   StatsKeyMappings(148)=(ViewId=3,PropertyId=268435534,KeyId=496)
   StatsKeyMappings(149)=(ViewId=3,PropertyId=268435538,KeyId=497)
   StatsKeyMappings(150)=(ViewId=3,PropertyId=268435540,KeyId=498)
   StatsKeyMappings(151)=(ViewId=3,PropertyId=268435541,KeyId=499)
   StatsKeyMappings(152)=(ViewId=3,PropertyId=268435713,KeyId=500)
   StatsKeyMappings(153)=(ViewId=3,PropertyId=268435756,KeyId=501)
   StatsKeyMappings(154)=(ViewId=3,PropertyId=268435543,KeyId=502)
   StatsKeyMappings(155)=(ViewId=3,PropertyId=268435544,KeyId=503)
   StatsKeyMappings(156)=(ViewId=3,PropertyId=268435626,KeyId=504)
   StatsKeyMappings(157)=(ViewId=3,PropertyId=268435627,KeyId=505)
   StatsKeyMappings(158)=(ViewId=3,PropertyId=268435632,KeyId=506)
   StatsKeyMappings(159)=(ViewId=3,PropertyId=268435633,KeyId=507)
   StatsKeyMappings(160)=(ViewId=3,PropertyId=268435634,KeyId=508)
   StatsKeyMappings(161)=(ViewId=3,PropertyId=268435639,KeyId=509)
   StatsKeyMappings(162)=(ViewId=3,PropertyId=268435640,KeyId=510)
   StatsKeyMappings(163)=(ViewId=3,PropertyId=268435646,KeyId=511)
   StatsKeyMappings(164)=(ViewId=3,PropertyId=268435652,KeyId=512)
   StatsKeyMappings(165)=(ViewId=3,PropertyId=268435653,KeyId=513)
   StatsKeyMappings(166)=(ViewId=3,PropertyId=268435657,KeyId=514)
   StatsKeyMappings(167)=(ViewId=3,PropertyId=268435715,KeyId=515)
   StatsKeyMappings(168)=(ViewId=3,PropertyId=268435659,KeyId=516)
   StatsKeyMappings(169)=(ViewId=3,PropertyId=268435714,KeyId=517)
   StatsKeyMappings(170)=(ViewId=3,PropertyId=268435777,KeyId=518)
   StatsKeyMappings(171)=(ViewId=3,PropertyId=268435662,KeyId=519)
   StatsKeyMappings(172)=(ViewId=3,PropertyId=268435663,KeyId=520)
   StatsKeyMappings(173)=(ViewId=4,KeyId=321)
   StatsKeyMappings(174)=(ViewId=4,PropertyId=268435590,KeyId=322)
   StatsKeyMappings(175)=(ViewId=4,PropertyId=268435591,KeyId=323)
   StatsKeyMappings(176)=(ViewId=4,PropertyId=268435592,KeyId=324)
   StatsKeyMappings(177)=(ViewId=4,PropertyId=268435593,KeyId=325)
   StatsKeyMappings(178)=(ViewId=4,PropertyId=268435594,KeyId=326)
   StatsKeyMappings(179)=(ViewId=4,PropertyId=268435595,KeyId=327)
   StatsKeyMappings(180)=(ViewId=4,PropertyId=268435596,KeyId=328)
   StatsKeyMappings(181)=(ViewId=4,PropertyId=268435597,KeyId=329)
   StatsKeyMappings(182)=(ViewId=4,PropertyId=268435598,KeyId=330)
   StatsKeyMappings(183)=(ViewId=4,PropertyId=268435599,KeyId=331)
   StatsKeyMappings(184)=(ViewId=4,PropertyId=268435600,KeyId=332)
   StatsKeyMappings(185)=(ViewId=4,PropertyId=268435601,KeyId=333)
   StatsKeyMappings(186)=(ViewId=4,PropertyId=268435604,KeyId=336)
   StatsKeyMappings(187)=(ViewId=4,PropertyId=268435602,KeyId=334)
   StatsKeyMappings(188)=(ViewId=4,PropertyId=268435603,KeyId=335)
   StatsKeyMappings(189)=(ViewId=4,PropertyId=268435605,KeyId=337)
   StatsKeyMappings(190)=(ViewId=4,PropertyId=268435607,KeyId=338)
   StatsKeyMappings(191)=(ViewId=4,PropertyId=268435606,KeyId=339)
   StatsKeyMappings(192)=(ViewId=4,PropertyId=268435668,KeyId=340)
   StatsKeyMappings(193)=(ViewId=4,PropertyId=268435669,KeyId=341)
   StatsKeyMappings(194)=(ViewId=4,PropertyId=268435670,KeyId=342)
   StatsKeyMappings(195)=(ViewId=4,PropertyId=268435671,KeyId=343)
   StatsKeyMappings(196)=(ViewId=4,PropertyId=268435672,KeyId=344)
   StatsKeyMappings(197)=(ViewId=4,PropertyId=268435673,KeyId=345)
   StatsKeyMappings(198)=(ViewId=4,PropertyId=268435674,KeyId=346)
   StatsKeyMappings(199)=(ViewId=4,PropertyId=268435675,KeyId=347)
   StatsKeyMappings(200)=(ViewId=4,PropertyId=268435676,KeyId=348)
   StatsKeyMappings(201)=(ViewId=4,PropertyId=268435677,KeyId=349)
   StatsKeyMappings(202)=(ViewId=4,PropertyId=268435678,KeyId=350)
   StatsKeyMappings(203)=(ViewId=4,PropertyId=268435679,KeyId=351)
   StatsKeyMappings(204)=(ViewId=4,PropertyId=268435682,KeyId=354)
   StatsKeyMappings(205)=(ViewId=4,PropertyId=268435680,KeyId=352)
   StatsKeyMappings(206)=(ViewId=4,PropertyId=268435681,KeyId=353)
   StatsKeyMappings(207)=(ViewId=4,PropertyId=268435683,KeyId=355)
   StatsKeyMappings(208)=(ViewId=4,PropertyId=268435711,KeyId=356)
   StatsKeyMappings(209)=(ViewId=4,PropertyId=268435684,KeyId=357)
   StatsKeyMappings(210)=(ViewId=5,KeyId=358)
   StatsKeyMappings(211)=(ViewId=5,PropertyId=268435465,KeyId=359)
   StatsKeyMappings(212)=(ViewId=5,PropertyId=268435466,KeyId=360)
   StatsKeyMappings(213)=(ViewId=5,PropertyId=268435467,KeyId=361)
   StatsKeyMappings(214)=(ViewId=5,PropertyId=268435468,KeyId=362)
   StatsKeyMappings(215)=(ViewId=5,PropertyId=268435472,KeyId=363)
   StatsKeyMappings(216)=(ViewId=5,PropertyId=268435473,KeyId=364)
   StatsKeyMappings(217)=(ViewId=5,PropertyId=268435474,KeyId=365)
   StatsKeyMappings(218)=(ViewId=5,PropertyId=268435475,KeyId=366)
   StatsKeyMappings(219)=(ViewId=5,PropertyId=268435730,KeyId=367)
   StatsKeyMappings(220)=(ViewId=5,PropertyId=268435479,KeyId=368)
   StatsKeyMappings(221)=(ViewId=5,PropertyId=268435480,KeyId=369)
   StatsKeyMappings(222)=(ViewId=5,PropertyId=268435481,KeyId=370)
   StatsKeyMappings(223)=(ViewId=5,PropertyId=268435731,KeyId=371)
   StatsKeyMappings(224)=(ViewId=5,PropertyId=268435482,KeyId=372)
   StatsKeyMappings(225)=(ViewId=5,PropertyId=268435484,KeyId=373)
   StatsKeyMappings(226)=(ViewId=5,PropertyId=268435485,KeyId=374)
   StatsKeyMappings(227)=(ViewId=5,PropertyId=268435732,KeyId=375)
   StatsKeyMappings(228)=(ViewId=5,PropertyId=268435733,KeyId=376)
   StatsKeyMappings(229)=(ViewId=5,PropertyId=268435486,KeyId=377)
   StatsKeyMappings(230)=(ViewId=5,PropertyId=268435488,KeyId=378)
   StatsKeyMappings(231)=(ViewId=5,PropertyId=268435735,KeyId=379)
   StatsKeyMappings(232)=(ViewId=5,PropertyId=268435741,KeyId=385)
   StatsKeyMappings(233)=(ViewId=5,PropertyId=268435498,KeyId=386)
   StatsKeyMappings(234)=(ViewId=5,PropertyId=268435742,KeyId=387)
   StatsKeyMappings(235)=(ViewId=5,PropertyId=268435492,KeyId=381)
   StatsKeyMappings(236)=(ViewId=5,PropertyId=268435736,KeyId=380)
   StatsKeyMappings(237)=(ViewId=5,PropertyId=268435737,KeyId=382)
   StatsKeyMappings(238)=(ViewId=5,PropertyId=268435738,KeyId=383)
   StatsKeyMappings(239)=(ViewId=5,PropertyId=268435739,KeyId=384)
   StatsKeyMappings(240)=(ViewId=5,PropertyId=268435743,KeyId=388)
   StatsKeyMappings(241)=(ViewId=5,PropertyId=268435501,KeyId=389)
   StatsKeyMappings(242)=(ViewId=5,PropertyId=268435744,KeyId=390)
   StatsKeyMappings(243)=(ViewId=5,PropertyId=268435502,KeyId=391)
   StatsKeyMappings(244)=(ViewId=5,PropertyId=268435503,KeyId=392)
   StatsKeyMappings(245)=(ViewId=5,PropertyId=268435504,KeyId=393)
   StatsKeyMappings(246)=(ViewId=5,PropertyId=268435745,KeyId=394)
   StatsKeyMappings(247)=(ViewId=5,PropertyId=268435507,KeyId=395)
   StatsKeyMappings(248)=(ViewId=5,PropertyId=268435508,KeyId=396)
   StatsKeyMappings(249)=(ViewId=5,PropertyId=268435509,KeyId=397)
   StatsKeyMappings(250)=(ViewId=5,PropertyId=268435510,KeyId=398)
   StatsKeyMappings(251)=(ViewId=5,PropertyId=268435514,KeyId=399)
   StatsKeyMappings(252)=(ViewId=5,PropertyId=268435515,KeyId=400)
   StatsKeyMappings(253)=(ViewId=5,PropertyId=268435516,KeyId=401)
   StatsKeyMappings(254)=(ViewId=5,PropertyId=268435518,KeyId=402)
   StatsKeyMappings(255)=(ViewId=5,PropertyId=268435747,KeyId=403)
   StatsKeyMappings(256)=(ViewId=5,PropertyId=268435522,KeyId=404)
   StatsKeyMappings(257)=(ViewId=5,PropertyId=268435525,KeyId=405)
   StatsKeyMappings(258)=(ViewId=5,PropertyId=268435523,KeyId=406)
   StatsKeyMappings(259)=(ViewId=5,PropertyId=268435748,KeyId=407)
   StatsKeyMappings(260)=(ViewId=5,PropertyId=268435524,KeyId=408)
   StatsKeyMappings(261)=(ViewId=5,PropertyId=268435527,KeyId=409)
   StatsKeyMappings(262)=(ViewId=5,PropertyId=268435528,KeyId=410)
   StatsKeyMappings(263)=(ViewId=5,PropertyId=268435749,KeyId=411)
   StatsKeyMappings(264)=(ViewId=5,PropertyId=268435750,KeyId=412)
   StatsKeyMappings(265)=(ViewId=5,PropertyId=268435529,KeyId=413)
   StatsKeyMappings(266)=(ViewId=5,PropertyId=268435531,KeyId=414)
   StatsKeyMappings(267)=(ViewId=5,PropertyId=268435751,KeyId=415)
   StatsKeyMappings(268)=(ViewId=5,PropertyId=268435757,KeyId=421)
   StatsKeyMappings(269)=(ViewId=5,PropertyId=268435542,KeyId=422)
   StatsKeyMappings(270)=(ViewId=5,PropertyId=268435758,KeyId=423)
   StatsKeyMappings(271)=(ViewId=5,PropertyId=268435536,KeyId=417)
   StatsKeyMappings(272)=(ViewId=5,PropertyId=268435752,KeyId=416)
   StatsKeyMappings(273)=(ViewId=5,PropertyId=268435753,KeyId=418)
   StatsKeyMappings(274)=(ViewId=5,PropertyId=268435754,KeyId=419)
   StatsKeyMappings(275)=(ViewId=5,PropertyId=268435755,KeyId=420)
   StatsKeyMappings(276)=(ViewId=5,PropertyId=268435759,KeyId=424)
   StatsKeyMappings(277)=(ViewId=5,PropertyId=268435545,KeyId=425)
   StatsKeyMappings(278)=(ViewId=5,PropertyId=268435760,KeyId=426)
   StatsKeyMappings(279)=(ViewId=5,PropertyId=268435546,KeyId=427)
   StatsKeyMappings(280)=(ViewId=5,PropertyId=268435547,KeyId=428)
   StatsKeyMappings(281)=(ViewId=5,PropertyId=268435548,KeyId=429)
   StatsKeyMappings(282)=(ViewId=5,PropertyId=268435761,KeyId=430)
   StatsKeyMappings(283)=(ViewId=5,PropertyId=268435628,KeyId=431)
   StatsKeyMappings(284)=(ViewId=5,PropertyId=268435629,KeyId=432)
   StatsKeyMappings(285)=(ViewId=5,PropertyId=268435630,KeyId=433)
   StatsKeyMappings(286)=(ViewId=5,PropertyId=268435631,KeyId=434)
   StatsKeyMappings(287)=(ViewId=5,PropertyId=268435635,KeyId=435)
   StatsKeyMappings(288)=(ViewId=5,PropertyId=268435636,KeyId=436)
   StatsKeyMappings(289)=(ViewId=5,PropertyId=268435637,KeyId=437)
   StatsKeyMappings(290)=(ViewId=5,PropertyId=268435638,KeyId=438)
   StatsKeyMappings(291)=(ViewId=5,PropertyId=268435762,KeyId=439)
   StatsKeyMappings(292)=(ViewId=5,PropertyId=268435642,KeyId=440)
   StatsKeyMappings(293)=(ViewId=5,PropertyId=268435643,KeyId=441)
   StatsKeyMappings(294)=(ViewId=5,PropertyId=268435644,KeyId=442)
   StatsKeyMappings(295)=(ViewId=5,PropertyId=268435763,KeyId=443)
   StatsKeyMappings(296)=(ViewId=5,PropertyId=268435645,KeyId=444)
   StatsKeyMappings(297)=(ViewId=5,PropertyId=268435647,KeyId=445)
   StatsKeyMappings(298)=(ViewId=5,PropertyId=268435648,KeyId=446)
   StatsKeyMappings(299)=(ViewId=5,PropertyId=268435764,KeyId=447)
   StatsKeyMappings(300)=(ViewId=5,PropertyId=268435765,KeyId=448)
   StatsKeyMappings(301)=(ViewId=5,PropertyId=268435649,KeyId=449)
   StatsKeyMappings(302)=(ViewId=5,PropertyId=268435651,KeyId=450)
   StatsKeyMappings(303)=(ViewId=5,PropertyId=268435766,KeyId=451)
   StatsKeyMappings(304)=(ViewId=5,PropertyId=268435772,KeyId=457)
   StatsKeyMappings(305)=(ViewId=5,PropertyId=268435661,KeyId=458)
   StatsKeyMappings(306)=(ViewId=5,PropertyId=268435773,KeyId=459)
   StatsKeyMappings(307)=(ViewId=5,PropertyId=268435655,KeyId=453)
   StatsKeyMappings(308)=(ViewId=5,PropertyId=268435767,KeyId=452)
   StatsKeyMappings(309)=(ViewId=5,PropertyId=268435768,KeyId=454)
   StatsKeyMappings(310)=(ViewId=5,PropertyId=268435769,KeyId=455)
   StatsKeyMappings(311)=(ViewId=5,PropertyId=268435770,KeyId=456)
   StatsKeyMappings(312)=(ViewId=5,PropertyId=268435774,KeyId=460)
   StatsKeyMappings(313)=(ViewId=5,PropertyId=268435664,KeyId=461)
   StatsKeyMappings(314)=(ViewId=5,PropertyId=268435775,KeyId=462)
   StatsKeyMappings(315)=(ViewId=5,PropertyId=268435665,KeyId=463)
   StatsKeyMappings(316)=(ViewId=5,PropertyId=268435666,KeyId=464)
   StatsKeyMappings(317)=(ViewId=5,PropertyId=268435667,KeyId=465)
   StatsKeyMappings(318)=(ViewId=5,PropertyId=268435776,KeyId=466)
   StatsKeyMappings(319)=(ViewId=6,KeyId=62)
   StatsKeyMappings(320)=(ViewId=6,PropertyId=268435590,KeyId=63)
   StatsKeyMappings(321)=(ViewId=6,PropertyId=268435591,KeyId=64)
   StatsKeyMappings(322)=(ViewId=6,PropertyId=268435592,KeyId=65)
   StatsKeyMappings(323)=(ViewId=6,PropertyId=268435593,KeyId=66)
   StatsKeyMappings(324)=(ViewId=6,PropertyId=268435594,KeyId=67)
   StatsKeyMappings(325)=(ViewId=6,PropertyId=268435595,KeyId=68)
   StatsKeyMappings(326)=(ViewId=6,PropertyId=268435596,KeyId=69)
   StatsKeyMappings(327)=(ViewId=6,PropertyId=268435597,KeyId=70)
   StatsKeyMappings(328)=(ViewId=6,PropertyId=268435598,KeyId=71)
   StatsKeyMappings(329)=(ViewId=6,PropertyId=268435599,KeyId=72)
   StatsKeyMappings(330)=(ViewId=6,PropertyId=268435600,KeyId=73)
   StatsKeyMappings(331)=(ViewId=6,PropertyId=268435601,KeyId=74)
   StatsKeyMappings(332)=(ViewId=6,PropertyId=268435604,KeyId=77)
   StatsKeyMappings(333)=(ViewId=6,PropertyId=268435602,KeyId=75)
   StatsKeyMappings(334)=(ViewId=6,PropertyId=268435603,KeyId=76)
   StatsKeyMappings(335)=(ViewId=6,PropertyId=268435605,KeyId=78)
   StatsKeyMappings(336)=(ViewId=6,PropertyId=268435607,KeyId=79)
   StatsKeyMappings(337)=(ViewId=6,PropertyId=268435606,KeyId=80)
   StatsKeyMappings(338)=(ViewId=6,PropertyId=268435668,KeyId=81)
   StatsKeyMappings(339)=(ViewId=6,PropertyId=268435669,KeyId=82)
   StatsKeyMappings(340)=(ViewId=6,PropertyId=268435670,KeyId=83)
   StatsKeyMappings(341)=(ViewId=6,PropertyId=268435671,KeyId=84)
   StatsKeyMappings(342)=(ViewId=6,PropertyId=268435672,KeyId=85)
   StatsKeyMappings(343)=(ViewId=6,PropertyId=268435673,KeyId=86)
   StatsKeyMappings(344)=(ViewId=6,PropertyId=268435674,KeyId=87)
   StatsKeyMappings(345)=(ViewId=6,PropertyId=268435675,KeyId=88)
   StatsKeyMappings(346)=(ViewId=6,PropertyId=268435676,KeyId=89)
   StatsKeyMappings(347)=(ViewId=6,PropertyId=268435677,KeyId=90)
   StatsKeyMappings(348)=(ViewId=6,PropertyId=268435678,KeyId=91)
   StatsKeyMappings(349)=(ViewId=6,PropertyId=268435679,KeyId=92)
   StatsKeyMappings(350)=(ViewId=6,PropertyId=268435682,KeyId=95)
   StatsKeyMappings(351)=(ViewId=6,PropertyId=268435680,KeyId=93)
   StatsKeyMappings(352)=(ViewId=6,PropertyId=268435681,KeyId=94)
   StatsKeyMappings(353)=(ViewId=6,PropertyId=268435683,KeyId=96)
   StatsKeyMappings(354)=(ViewId=6,PropertyId=268435711,KeyId=97)
   StatsKeyMappings(355)=(ViewId=6,PropertyId=268435684,KeyId=98)
   StatsKeyMappings(356)=(ViewId=7,KeyId=99)
   StatsKeyMappings(357)=(ViewId=7,PropertyId=268435465,KeyId=100)
   StatsKeyMappings(358)=(ViewId=7,PropertyId=268435466,KeyId=101)
   StatsKeyMappings(359)=(ViewId=7,PropertyId=268435467,KeyId=102)
   StatsKeyMappings(360)=(ViewId=7,PropertyId=268435468,KeyId=103)
   StatsKeyMappings(361)=(ViewId=7,PropertyId=268435472,KeyId=104)
   StatsKeyMappings(362)=(ViewId=7,PropertyId=268435473,KeyId=105)
   StatsKeyMappings(363)=(ViewId=7,PropertyId=268435474,KeyId=106)
   StatsKeyMappings(364)=(ViewId=7,PropertyId=268435475,KeyId=107)
   StatsKeyMappings(365)=(ViewId=7,PropertyId=268435730,KeyId=108)
   StatsKeyMappings(366)=(ViewId=7,PropertyId=268435479,KeyId=109)
   StatsKeyMappings(367)=(ViewId=7,PropertyId=268435480,KeyId=110)
   StatsKeyMappings(368)=(ViewId=7,PropertyId=268435481,KeyId=111)
   StatsKeyMappings(369)=(ViewId=7,PropertyId=268435731,KeyId=112)
   StatsKeyMappings(370)=(ViewId=7,PropertyId=268435482,KeyId=113)
   StatsKeyMappings(371)=(ViewId=7,PropertyId=268435484,KeyId=114)
   StatsKeyMappings(372)=(ViewId=7,PropertyId=268435485,KeyId=115)
   StatsKeyMappings(373)=(ViewId=7,PropertyId=268435732,KeyId=116)
   StatsKeyMappings(374)=(ViewId=7,PropertyId=268435733,KeyId=117)
   StatsKeyMappings(375)=(ViewId=7,PropertyId=268435486,KeyId=118)
   StatsKeyMappings(376)=(ViewId=7,PropertyId=268435488,KeyId=119)
   StatsKeyMappings(377)=(ViewId=7,PropertyId=268435735,KeyId=120)
   StatsKeyMappings(378)=(ViewId=7,PropertyId=268435741,KeyId=126)
   StatsKeyMappings(379)=(ViewId=7,PropertyId=268435498,KeyId=127)
   StatsKeyMappings(380)=(ViewId=7,PropertyId=268435742,KeyId=128)
   StatsKeyMappings(381)=(ViewId=7,PropertyId=268435492,KeyId=122)
   StatsKeyMappings(382)=(ViewId=7,PropertyId=268435736,KeyId=121)
   StatsKeyMappings(383)=(ViewId=7,PropertyId=268435737,KeyId=123)
   StatsKeyMappings(384)=(ViewId=7,PropertyId=268435738,KeyId=124)
   StatsKeyMappings(385)=(ViewId=7,PropertyId=268435739,KeyId=125)
   StatsKeyMappings(386)=(ViewId=7,PropertyId=268435743,KeyId=129)
   StatsKeyMappings(387)=(ViewId=7,PropertyId=268435501,KeyId=130)
   StatsKeyMappings(388)=(ViewId=7,PropertyId=268435744,KeyId=131)
   StatsKeyMappings(389)=(ViewId=7,PropertyId=268435502,KeyId=132)
   StatsKeyMappings(390)=(ViewId=7,PropertyId=268435503,KeyId=133)
   StatsKeyMappings(391)=(ViewId=7,PropertyId=268435504,KeyId=134)
   StatsKeyMappings(392)=(ViewId=7,PropertyId=268435745,KeyId=135)
   StatsKeyMappings(393)=(ViewId=7,PropertyId=268435507,KeyId=136)
   StatsKeyMappings(394)=(ViewId=7,PropertyId=268435508,KeyId=137)
   StatsKeyMappings(395)=(ViewId=7,PropertyId=268435509,KeyId=138)
   StatsKeyMappings(396)=(ViewId=7,PropertyId=268435510,KeyId=139)
   StatsKeyMappings(397)=(ViewId=7,PropertyId=268435514,KeyId=140)
   StatsKeyMappings(398)=(ViewId=7,PropertyId=268435515,KeyId=141)
   StatsKeyMappings(399)=(ViewId=7,PropertyId=268435516,KeyId=142)
   StatsKeyMappings(400)=(ViewId=7,PropertyId=268435518,KeyId=143)
   StatsKeyMappings(401)=(ViewId=7,PropertyId=268435747,KeyId=144)
   StatsKeyMappings(402)=(ViewId=7,PropertyId=268435522,KeyId=145)
   StatsKeyMappings(403)=(ViewId=7,PropertyId=268435525,KeyId=146)
   StatsKeyMappings(404)=(ViewId=7,PropertyId=268435523,KeyId=147)
   StatsKeyMappings(405)=(ViewId=7,PropertyId=268435748,KeyId=148)
   StatsKeyMappings(406)=(ViewId=7,PropertyId=268435524,KeyId=149)
   StatsKeyMappings(407)=(ViewId=7,PropertyId=268435527,KeyId=150)
   StatsKeyMappings(408)=(ViewId=7,PropertyId=268435528,KeyId=151)
   StatsKeyMappings(409)=(ViewId=7,PropertyId=268435749,KeyId=152)
   StatsKeyMappings(410)=(ViewId=7,PropertyId=268435750,KeyId=153)
   StatsKeyMappings(411)=(ViewId=7,PropertyId=268435529,KeyId=154)
   StatsKeyMappings(412)=(ViewId=7,PropertyId=268435531,KeyId=155)
   StatsKeyMappings(413)=(ViewId=7,PropertyId=268435751,KeyId=156)
   StatsKeyMappings(414)=(ViewId=7,PropertyId=268435757,KeyId=162)
   StatsKeyMappings(415)=(ViewId=7,PropertyId=268435542,KeyId=163)
   StatsKeyMappings(416)=(ViewId=7,PropertyId=268435758,KeyId=164)
   StatsKeyMappings(417)=(ViewId=7,PropertyId=268435536,KeyId=158)
   StatsKeyMappings(418)=(ViewId=7,PropertyId=268435752,KeyId=157)
   StatsKeyMappings(419)=(ViewId=7,PropertyId=268435753,KeyId=159)
   StatsKeyMappings(420)=(ViewId=7,PropertyId=268435754,KeyId=160)
   StatsKeyMappings(421)=(ViewId=7,PropertyId=268435755,KeyId=161)
   StatsKeyMappings(422)=(ViewId=7,PropertyId=268435759,KeyId=165)
   StatsKeyMappings(423)=(ViewId=7,PropertyId=268435545,KeyId=166)
   StatsKeyMappings(424)=(ViewId=7,PropertyId=268435760,KeyId=167)
   StatsKeyMappings(425)=(ViewId=7,PropertyId=268435546,KeyId=168)
   StatsKeyMappings(426)=(ViewId=7,PropertyId=268435547,KeyId=169)
   StatsKeyMappings(427)=(ViewId=7,PropertyId=268435548,KeyId=170)
   StatsKeyMappings(428)=(ViewId=7,PropertyId=268435761,KeyId=171)
   StatsKeyMappings(429)=(ViewId=7,PropertyId=268435628,KeyId=172)
   StatsKeyMappings(430)=(ViewId=7,PropertyId=268435629,KeyId=173)
   StatsKeyMappings(431)=(ViewId=7,PropertyId=268435630,KeyId=174)
   StatsKeyMappings(432)=(ViewId=7,PropertyId=268435631,KeyId=175)
   StatsKeyMappings(433)=(ViewId=7,PropertyId=268435635,KeyId=176)
   StatsKeyMappings(434)=(ViewId=7,PropertyId=268435636,KeyId=177)
   StatsKeyMappings(435)=(ViewId=7,PropertyId=268435637,KeyId=178)
   StatsKeyMappings(436)=(ViewId=7,PropertyId=268435638,KeyId=179)
   StatsKeyMappings(437)=(ViewId=7,PropertyId=268435762,KeyId=180)
   StatsKeyMappings(438)=(ViewId=7,PropertyId=268435642,KeyId=181)
   StatsKeyMappings(439)=(ViewId=7,PropertyId=268435643,KeyId=182)
   StatsKeyMappings(440)=(ViewId=7,PropertyId=268435644,KeyId=183)
   StatsKeyMappings(441)=(ViewId=7,PropertyId=268435763,KeyId=184)
   StatsKeyMappings(442)=(ViewId=7,PropertyId=268435645,KeyId=185)
   StatsKeyMappings(443)=(ViewId=7,PropertyId=268435647,KeyId=186)
   StatsKeyMappings(444)=(ViewId=7,PropertyId=268435648,KeyId=187)
   StatsKeyMappings(445)=(ViewId=7,PropertyId=268435764,KeyId=188)
   StatsKeyMappings(446)=(ViewId=7,PropertyId=268435765,KeyId=189)
   StatsKeyMappings(447)=(ViewId=7,PropertyId=268435649,KeyId=190)
   StatsKeyMappings(448)=(ViewId=7,PropertyId=268435651,KeyId=191)
   StatsKeyMappings(449)=(ViewId=7,PropertyId=268435766,KeyId=192)
   StatsKeyMappings(450)=(ViewId=7,PropertyId=268435772,KeyId=198)
   StatsKeyMappings(451)=(ViewId=7,PropertyId=268435661,KeyId=199)
   StatsKeyMappings(452)=(ViewId=7,PropertyId=268435773,KeyId=200)
   StatsKeyMappings(453)=(ViewId=7,PropertyId=268435655,KeyId=194)
   StatsKeyMappings(454)=(ViewId=7,PropertyId=268435767,KeyId=193)
   StatsKeyMappings(455)=(ViewId=7,PropertyId=268435768,KeyId=195)
   StatsKeyMappings(456)=(ViewId=7,PropertyId=268435769,KeyId=196)
   StatsKeyMappings(457)=(ViewId=7,PropertyId=268435770,KeyId=197)
   StatsKeyMappings(458)=(ViewId=7,PropertyId=268435774,KeyId=201)
   StatsKeyMappings(459)=(ViewId=7,PropertyId=268435664,KeyId=202)
   StatsKeyMappings(460)=(ViewId=7,PropertyId=268435775,KeyId=203)
   StatsKeyMappings(461)=(ViewId=7,PropertyId=268435665,KeyId=204)
   StatsKeyMappings(462)=(ViewId=7,PropertyId=268435666,KeyId=205)
   StatsKeyMappings(463)=(ViewId=7,PropertyId=268435667,KeyId=206)
   StatsKeyMappings(464)=(ViewId=7,PropertyId=268435776,KeyId=207)
   StatsKeyMappings(465)=(ViewId=8,KeyId=208)
   StatsKeyMappings(466)=(ViewId=8,PropertyId=268435463,KeyId=209)
   StatsKeyMappings(467)=(ViewId=8,PropertyId=268435464,KeyId=210)
   StatsKeyMappings(468)=(ViewId=8,PropertyId=268435469,KeyId=211)
   StatsKeyMappings(469)=(ViewId=8,PropertyId=268435470,KeyId=212)
   StatsKeyMappings(470)=(ViewId=8,PropertyId=268435471,KeyId=213)
   StatsKeyMappings(471)=(ViewId=8,PropertyId=268435780,KeyId=214)
   StatsKeyMappings(472)=(ViewId=8,PropertyId=268435476,KeyId=215)
   StatsKeyMappings(473)=(ViewId=8,PropertyId=268435477,KeyId=216)
   StatsKeyMappings(474)=(ViewId=8,PropertyId=268435483,KeyId=217)
   StatsKeyMappings(475)=(ViewId=8,PropertyId=268435489,KeyId=218)
   StatsKeyMappings(476)=(ViewId=8,PropertyId=268435490,KeyId=219)
   StatsKeyMappings(477)=(ViewId=8,PropertyId=268435494,KeyId=220)
   StatsKeyMappings(478)=(ViewId=8,PropertyId=268435716,KeyId=221)
   StatsKeyMappings(479)=(ViewId=8,PropertyId=268435496,KeyId=222)
   StatsKeyMappings(480)=(ViewId=8,PropertyId=268435712,KeyId=223)
   StatsKeyMappings(481)=(ViewId=8,PropertyId=268435740,KeyId=224)
   StatsKeyMappings(482)=(ViewId=8,PropertyId=268435499,KeyId=225)
   StatsKeyMappings(483)=(ViewId=8,PropertyId=268435500,KeyId=226)
   StatsKeyMappings(484)=(ViewId=8,PropertyId=268435505,KeyId=227)
   StatsKeyMappings(485)=(ViewId=8,PropertyId=268435506,KeyId=228)
   StatsKeyMappings(486)=(ViewId=8,PropertyId=268435511,KeyId=229)
   StatsKeyMappings(487)=(ViewId=8,PropertyId=268435512,KeyId=230)
   StatsKeyMappings(488)=(ViewId=8,PropertyId=268435513,KeyId=231)
   StatsKeyMappings(489)=(ViewId=8,PropertyId=268435517,KeyId=232)
   StatsKeyMappings(490)=(ViewId=8,PropertyId=268435519,KeyId=233)
   StatsKeyMappings(491)=(ViewId=8,PropertyId=268435520,KeyId=234)
   StatsKeyMappings(492)=(ViewId=8,PropertyId=268435526,KeyId=235)
   StatsKeyMappings(493)=(ViewId=8,PropertyId=268435533,KeyId=236)
   StatsKeyMappings(494)=(ViewId=8,PropertyId=268435534,KeyId=237)
   StatsKeyMappings(495)=(ViewId=8,PropertyId=268435538,KeyId=238)
   StatsKeyMappings(496)=(ViewId=8,PropertyId=268435540,KeyId=239)
   StatsKeyMappings(497)=(ViewId=8,PropertyId=268435541,KeyId=240)
   StatsKeyMappings(498)=(ViewId=8,PropertyId=268435713,KeyId=241)
   StatsKeyMappings(499)=(ViewId=8,PropertyId=268435756,KeyId=242)
   StatsKeyMappings(500)=(ViewId=8,PropertyId=268435543,KeyId=243)
   StatsKeyMappings(501)=(ViewId=8,PropertyId=268435544,KeyId=244)
   StatsKeyMappings(502)=(ViewId=8,PropertyId=268435626,KeyId=245)
   StatsKeyMappings(503)=(ViewId=8,PropertyId=268435627,KeyId=246)
   StatsKeyMappings(504)=(ViewId=8,PropertyId=268435632,KeyId=247)
   StatsKeyMappings(505)=(ViewId=8,PropertyId=268435633,KeyId=248)
   StatsKeyMappings(506)=(ViewId=8,PropertyId=268435634,KeyId=249)
   StatsKeyMappings(507)=(ViewId=8,PropertyId=268435639,KeyId=250)
   StatsKeyMappings(508)=(ViewId=8,PropertyId=268435640,KeyId=251)
   StatsKeyMappings(509)=(ViewId=8,PropertyId=268435646,KeyId=252)
   StatsKeyMappings(510)=(ViewId=8,PropertyId=268435652,KeyId=253)
   StatsKeyMappings(511)=(ViewId=8,PropertyId=268435653,KeyId=254)
   StatsKeyMappings(512)=(ViewId=8,PropertyId=268435657,KeyId=255)
   StatsKeyMappings(513)=(ViewId=8,PropertyId=268435715,KeyId=256)
   StatsKeyMappings(514)=(ViewId=8,PropertyId=268435659,KeyId=257)
   StatsKeyMappings(515)=(ViewId=8,PropertyId=268435714,KeyId=258)
   StatsKeyMappings(516)=(ViewId=8,PropertyId=268435777,KeyId=259)
   StatsKeyMappings(517)=(ViewId=8,PropertyId=268435662,KeyId=260)
   StatsKeyMappings(518)=(ViewId=8,PropertyId=268435663,KeyId=261)
   LocationUrlsForInvites(0)="ut3pc"
   LocationUrl="ut3pc"
   DefaultStatus="In gioco"
   GameInviteMessage="Would you like to play a game?"
   ConnectionPresenceTimeInterval=0.500000
   EncryptedProductKey="NotForShip"
   StunServerAddress(0)="stunserver.org"
   StunServerAddress(1)="stun.xten.com"
   Name="Default__OnlineSubsystemGameSpy"
   ObjectArchetype=OnlineSubsystemCommonImpl'IpDrv.Default__OnlineSubsystemCommonImpl'
}
