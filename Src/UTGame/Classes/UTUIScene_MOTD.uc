/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_MOTD extends UTUIScene_Hud
	native(UI);


var bool bFadingOut;
var transient UISafeRegionPanel Panel;
var transient UTDrawPanel DrawPanel;


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


event PostInitialize()
{
	local worldinfo WI;
	local UTGameReplicationInfo GRI;
	local class<UTGame> GC;
	local UILabel Lbl;
	Super.PostInitialize();

	Panel = UISafeRegionPanel(FindChild('SafePanel',true));
//	Panel.PlayUIAnimation('FadeIn',,0.5);

	WI = GetWorldInfo();
	if ( WI != none )
	{
		GC = class<UTGame>(WI.GetGameClass());
		GRI = UTGameReplicationInfo(WI.GRI);
		if (GRI != none && GC != none)
		{
		 	Lbl = UILabel(FindChild('ServerRules',true));
		 	if ( Lbl != none )
		 	{
		 		Lbl.SetDatastorebinding( GC.static.GetEndOfMatchRules(GRI.GoalScore, GRI.TimeLimit) );
		 	}
		}
	}
}

event Finish()
{
	bFadingOut = true;
	Panel.PlayUIAnimation('FadeOut',,0.5);
}

function AnimEnd(UIObject AnimTarget, int AnimIndex, UIAnimationSeq AnimSeq)
{
	if (AnimSeq.SeqName == 'FadeOut')
	{
		SceneClient.CloseScene(Self);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_MOTD"
   ObjectArchetype=UTUIScene_Hud'UTGame.Default__UTUIScene_Hud'
}
