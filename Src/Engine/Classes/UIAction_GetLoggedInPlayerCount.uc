/**
 * This action returns the number of players logged in.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetLoggedInPlayerCount extends UIAction
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Number of people logged-in in total. */
var int TotalLoggedIn;

/** Number of people logged with a online enabled profile. */
var int NumOnlineEnabled;

/** Number of people logged with a non-online profile. */
var int NumLocalOnly;

/** Maximum number of players this game supports. */
var() int MaxPlayers;

/** Gets the number of logged in players from the OnlineSubsystem and stores them into a variable. */
event GetLoginStatus()
{
	local int PlayerIdx;
	local OnlineSubsystem OnlineSub;
	local OnlinePlayerInterface PlayerInterface;
	local ELoginStatus Status;

	TotalLoggedIn = 0;
	NumOnlineEnabled = 0;
	NumLocalOnly = 0;

	// Figure out if we have an online subsystem registered
	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		// Grab the player interface to verify the subsystem supports it
		PlayerInterface = OnlineSub.PlayerInterface;
		if (PlayerInterface != None)
		{
			for(PlayerIdx=0; PlayerIdx<MaxPlayers;PlayerIdx++)
			{
				// Get status
				Status = PlayerInterface.GetLoginStatus(PlayerIdx);


				if(Status==LS_LoggedIn)
				{
					TotalLoggedIn++;
					NumOnlineEnabled++;
				}
				else if(Status==LS_UsingLocalProfile)
				{
					TotalLoggedIn++;
					NumLocalOnly++;
				}
			}
		}
	}
}

defaultproperties
{
   MaxPlayers=4
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Num with Online",PropertyName="NumOnlineEnabled",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Num Local Only",PropertyName="NumLocalOnly",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Num Total Signed-in",PropertyName="TotalLoggedIn",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get Logged-in Player Count"
   ObjCategory="Online"
   Name="Default__UIAction_GetLoggedInPlayerCount"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
