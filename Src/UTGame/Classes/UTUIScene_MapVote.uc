/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_MapVote extends UTUIScene_Hud
	native(UI);

var transient UTDrawMapVotePanel MapList;
var transient UILabel TimeRemaining;
var transient UTVoteReplicationInfo VoteRI;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


event PostInitialize()
{
	super.PostInitialize();

	MapList = UTDrawMapVotePanel( FindChild('MapList',true));
	TimeRemaining = UILabel( FindChild('TimeRemaining',true));
}

function InitializeVRI(UTVoteReplicationInfo NewVoteRI)
{
	if ( MapList != none )
	{
		MapList.InitializeVRI(NewVoteRI);
	}
}

defaultproperties
{
   bDisplayCursor=True
   bRenderParentScenes=False
   bAlwaysRenderScene=True
   SceneInputMode=INPUTMODE_MatchingOnly
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_MapVote"
   ObjectArchetype=UTUIScene_Hud'UTGame.Default__UTUIScene_Hud'
}
