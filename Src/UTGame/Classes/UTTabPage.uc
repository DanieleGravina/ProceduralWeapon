/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTTabPage extends UITabPage
	native(UI);

/** If true, this object require tick */
var bool bRequiresTick;

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

/** Delegate for when the tab page is ticked. */
delegate OnTick(float DeltaTime);

function OnChildRepositioned( UIScreenObject Sender );


/** Callback allowing the tabpage to setup the button bar for the current scene. */
function SetupButtonBar(UTUIButtonBar ButtonBar)
{
	// Do nothing by default.
}

/**
 * Wrapper for getting a reference to the scene's button bar.
 */
function UTUIButtonBar GetButtonBar()
{
	local UTUIFrontEnd UTOwnerScene;

	UTOwnerScene = UTUIFrontEnd(GetScene());
	return UTOwnerScene != None ? UTOwnerScene.ButtonBar : None;
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
	return false;
}


/**
 * Closes the parent Scene
 */
function CloseParentScene()
{
	local UTUIScene S;
	S = UTUIScene(GetScene());
	if ( S != none )
	{
		S.CloseScene(S);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UITabPage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UITabPage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTTabPage"
   ObjectArchetype=UITabPage'Engine.Default__UITabPage'
}
