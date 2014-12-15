/**
 * Copyright © 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_TimedTutorialMessage extends UTUIScene
	native(UI);

var transient UILabel MessageText;
var transient bool bFinished;
var transient float OnTime;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event PostInitialize()
{

	Super.PostInitialize();
	MessageText = UILabel( FindChild('MessageText',true));

	OnTime = GetWorldInfo().TimeSeconds;
}

function SetValue(string Text)
{
	MessageText.SetValue(Text);
}


function AnimEnd(UIObject AnimTarget, int AnimIndex, UIAnimationSeq AnimSeq)
{
	if ( AnimSeq.SeqName == 'FadeOut' )
	{
		CloseScene(self);
	}
}

defaultproperties
{
   bDisplayCursor=False
   bAlwaysRenderScene=True
   bPauseGameWhileActive=False
   SceneInputMode=INPUTMODE_None
   SceneRenderMode=SPLITRENDER_Fullscreen
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_TimedTutorialMessage"
   ObjectArchetype=UTUIScene'UTGame.Default__UTUIScene'
}
