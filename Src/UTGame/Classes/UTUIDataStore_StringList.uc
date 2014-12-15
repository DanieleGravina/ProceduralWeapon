/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIDataStore_StringList extends UIDataStore
	config(Game)
	native(UI)
	transient
	implements(UIListElementProvider)
	implements(UIListElementCellProvider);

const INVALIDFIELD=-1;

struct native EStringListData
{
	/** the tag used for binding this data to a list cell */
	var name Tag;

	/** the string to use as the column header for cells bound to this field */
	var	localized string ColumnHeaderText;

	/** the currently selected value from the Strings array */
	var string CurrentValue;

	/** the index into the Strings array for the element that should be selected by default */
	var int DefaultValueIndex;

	/** the available value choices */
	var localized array<string> Strings;

	/** provider for the list of strings associated with this tag */
	var transient UTUIDataProvider_StringArray	DataProvider;
};

var config array<EStringListData> StringData;

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
 * Called when this data store is added to the data store manager's list of active data stores.
 *
 * @param	PlayerOwner		the player that will be associated with this DataStore.  Only relevant if this data store is
 *							associated with a particular player; NULL if this is a global data store.
 */
event Registered( LocalPlayer PlayerOwner )
{
	local int FieldIdx;

	Super.Registered(PlayerOwner);

	// Go through all of the config defined string items and set the default value string.
	for(FieldIdx=0; FieldIdx<StringData.length; FieldIdx++)
	{
		if(StringData[FieldIdx].Strings.length > StringData[FieldIdx].DefaultValueIndex && StringData[FieldIdx].DefaultValueIndex >= 0)
		{
			StringData[FieldIdx].CurrentValue = StringData[FieldIdx].Strings[StringData[FieldIdx].DefaultValueIndex];
		}
	}
}

/**
 * @param FieldName		Name of the String List to find
 * @return the index of a string list
 */
native function INT GetFieldIndex(Name FieldName);

/**
 * Add a string to the list
 *
 * @Param FieldName		The string list to work on
 * @Param NewString		The new string to add
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */
native function AddStr(name FieldName, string NewString, optional bool bBatchOp);

/**
 * Insert a string in to the list at a given index
 *
 * @Param FieldName		The string list to work on
 * @Param NewString		The new string to add
 * @Param InsertIndex	The index where you wish to insert the string
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */
native function InsertStr(name FieldName, string NewString, int InsertIndex, optional bool bBatchOp);

/**
 * Remove a string from the list
 *
 * @Param FieldName		The string list to work on
 * @Param StringToRemove 	The string to remove
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */
native function RemoveStr(name FieldName, string StringToRemove, optional bool bBatchOp);

/**
 * Remove a string (or multiple strings) by the index.
 *
 * @Param FieldName		The string list to work on
 * @Param Index			The index to remove
 * @Param Count			<Optional> # of strings to remove
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */
native function RemoveStrByIndex(name FieldName, int Index, optional int Count=1, optional bool bBatchOp);

/**
 * Empty a string List
 *
 * @Param FieldName		The string list to work on
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */
native function Empty(name FieldName, optional bool bBatchOp);

/**
 * Finds a string in the list
 *
 * @Param FieldName		The string list to add the new string to
 * @Param SearchStr		The string to find
 *
 * @returns the index in the list or INVALIDFIELD
 */
native function INT FindStr(name FieldName, string SearchString);

/**
 * Returns the a string by the index
 *
 * @Param FieldName		The string list to add the new string to
 * @Param StrIndex		The index of the string to get
 *
 * @returns the string.
 */
native function string GetStr(name FieldName, int StrIndex);

/**
 * Get a list
 *
 * @Param FieldName		The string list to add the new string to
 * @returns a copy of the list
 */
native function array<string> GetList(name FieldName);


/**
 * Returns the current value of a field.
 *
 * @param FieldName		Field to search.
 * @param out_Value		Variable to store the result string in.
 *
 * @return TRUE if the field was found, FLASE otherwise.
 */
event bool GetCurrentValue(name FieldName, out string out_Value)
{
	local bool Result;
	local int FieldIndex;

	Result = FALSE;

	FieldIndex = GetFieldIndex(FieldName);

	if(FieldIndex!=INDEX_NONE)
	{
		Result = TRUE;
		out_Value = StringData[FieldIndex].CurrentValue;
	}

	return Result;
}

/**
 * Returns the current value index of a given field.
 *
 * @param FieldName		Field to search.
 */
event int GetCurrentValueIndex(name FieldName)
{
	local int Result;
	local int FieldIndex;

	Result = INDEX_NONE;

	FieldIndex = GetFieldIndex(FieldName);

	if(FieldIndex!=INDEX_NONE)
	{
		Result = FindStr(FieldName, StringData[FieldIndex].CurrentValue);
	}

	return Result;
}

/**
 * Sets the current value index of a given field.
 *
 * @param FieldName		Field to change.
 * @param int			NewValueIndex
 */
event int SetCurrentValueIndex(name FieldName, int NewValueIndex)
{
	local int Result;
	local int FieldIndex;

	Result = INDEX_NONE;

	FieldIndex = GetFieldIndex(FieldName);

	if(FieldIndex!=INDEX_NONE && StringData[FieldIndex].Strings.length > NewValueIndex)
	{
		StringData[FieldIndex].CurrentValue = StringData[FieldIndex].Strings[NewValueIndex];
	}

	//@fixme - should we call refresh subscribers here?
	return Result;
}

/**
 * Get the number of strings in a given list
 *
 * @Param FieldName		The string list to work on
 * @returns the # of strings or -1 if the list does not exist
 */
event int Num(name FieldName)
{
	local int FieldIndex;
	FieldIndex = GetFieldIndex(FieldName);
	if ( FieldIndex > INDEX_NONE )  // Found it, add the string
	{
		return StringData[FieldIndex].Strings.Length;
	}

	return -1;
}

defaultproperties
{
   StringData(0)=(Tag="ServerType",ColumnHeaderText="Modalità Partita",DefaultValueIndex=1,Strings=("LAN","Internet"))
   StringData(1)=(Tag="ServerType360",ColumnHeaderText="Modalità Partita",DefaultValueIndex=1,Strings=("Collegamento sistema","Giocatore","Grado"))
   StringData(2)=(Tag="MatchType",ColumnHeaderText="Modalità Partita",DefaultValueIndex=1,Strings=("LAN","Internet"))
   StringData(3)=(Tag="MatchType360",ColumnHeaderText="Modalità Partita",DefaultValueIndex=1,Strings=("Collegamento sistema","Giocatore","Grado"))
   StringData(4)=(Tag="BotTeams",ColumnHeaderText="Squadra Bot",Strings=("Casuale","Iron Guard","Ronin","Krall","Liandri","Necris"))
   StringData(5)=(Tag="RecordDemo",ColumnHeaderText="Registrazione demo",Strings=("No","Sì"))
   StringData(6)=(Tag="FullScreen",ColumnHeaderText="Schermo Intero",DefaultValueIndex=1,Strings=("Schermo Intero","Finestra"))
   StringData(7)=(Tag="ScreenResolution",ColumnHeaderText="Risoluzione",Strings=("800x600","960x720","1024x768","1280x720","1600x1200"))
   StringData(8)=(Tag="PS3ButtonPresets",ColumnHeaderText="Tasti predefiniti",Strings=("Predefiniti 1","Predefiniti 2","Predefiniti 3"))
   StringData(9)=(Tag="Splitscreen",ColumnHeaderText="Schermo condiviso",Strings=("No","Sì"))
   StringData(10)=(Tag="CharacterParts",ColumnHeaderText="Uniforme",Strings=("Facemask","Elmetto","Occhiali","Torace","Imbottiture spalle","Armi","Gambe","Stivali"))
   StringData(11)=(Tag="PlayerCardOptions",ColumnHeaderText="Server Mode",Strings=("Ascolta","Dedicato"))
   StringData(12)=(Tag="ComboTest",Strings=("Item1","Item2","Item3","Item4"))
   StringData(13)=(Tag="MissionList",Strings=())
   StringData(14)=(Tag="PlayerName")
   StringData(15)=(Tag="MatchTypeCampaign",ColumnHeaderText="Tipo",Strings=("Giocatore Singolo","Splitscreen","LAN","Internet Pubblica","Internet Privata"))
   StringData(16)=(Tag="Difficulty",ColumnHeaderText="Difficoltà",DefaultValueIndex=1,Strings=("Casuale","Normale","Difficile","Pazzo"))
   StringData(17)=(Tag="BotCombatants",ColumnHeaderText="Bot combattenti",DefaultValueIndex=1,Strings=("Disabilitato","Abilitato"))
   StringData(18)=(Tag="BotCombatantsRatio",ColumnHeaderText="Bot combattenti",DefaultValueIndex=1,Strings=("Disabilitato","Abilitato","Giocatori contro Bot 1:1","Giocatori contro Bot 2:3","Giocatori contro Bot 1:2"))
   Tag="UTStringList"
   WriteAccessType=ACCESS_WriteAll
   Name="Default__UTUIDataStore_StringList"
   ObjectArchetype=UIDataStore'Engine.Default__UIDataStore'
}
