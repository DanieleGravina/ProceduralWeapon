/**
 * Copyright © 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUITabPage_Chat extends UTTabPage_MidGame;

var transient UIPanel ChatPanel;
var transient UILabel ChatText;
var transient UIEditBox ChatEdit;
var transient int ConsoleTextCnt;

function PostInitialize()
{
	local UTConsole Con;

	ChatText = UILabel(FindChild('ChatText',true));
	ChatText.SetValue("");
	ChatPanel = UIPanel(FindChild('ChatPanel',true));

	ChatEdit = UIEditBox(FindChild('ChatEdit',true));
	ChatEdit.OnSubmitText = EditBoxSubmit;
	ChatEdit.SetDataStoreBinding("");

	// Copy of the console...
	Con = UTConsole(GetPlayerOwner().ViewportClient.ViewportConsole);
	if (Con != none)
	{
		ConsoleTextCnt = Con.TextCount - 5;
	}

	OnPreRenderCallBack = PreRenderCallBack;

}


/**
 * This tab is being ticked
 */
function TabTick(float DeltaTime)
{
	local UTConsole Con;
	local string work;

	// Update the Console
	Con = UTConsole(GetPlayerOwner().ViewportClient.ViewportConsole);

	if (Con != none && ConsoleTextCnt != Con.TextCount)
	{

		Work = UTUIScene_MidGameMenu(GetScene()).ParseScrollback(Con.Scrollback);
		ChatText.SetDatastoreBinding( Work );
		ConsoleTextCnt = Con.TextCount;
	}
}

function bool EditBoxSubmit( UIEditBox Sender, int PlayerIndex )
{
	local string s;
	local UTPlayerController PC;

	s = ChatEdit.GetValue();


	PC = UTUIScene_MidGameMenu(GetScene()).GetUTPlayerOwner();
	if ( PC != none )
	{

		if ( PC.AllowTextMessage(S) )
		{
			PC.ServerSay(S);
			ChatEdit.SetValue("");
			return true;
		}

		else
		{
			PlayUISound('GenericError');
		}
	}

	return false;

}

function PreRenderCallBack()
{
	local UTConsole Con;


	ChatEdit.SetValue("");

	// Copy of the console...

	Con = UTConsole(GetPlayerOwner().ViewportClient.ViewportConsole);
	if (Con != none)
	{
		ConsoleTextCnt = Con.TextCount - 5;
	}
}

defaultproperties
{
   bRequiresTick=True
   __OnTick__Delegate=Default__UTUITabPage_Chat.TabTick
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTTabPage_MidGame:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTTabPage_MidGame:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_Chat"
   ObjectArchetype=UTTabPage_MidGame'UTGame.Default__UTTabPage_MidGame'
}
