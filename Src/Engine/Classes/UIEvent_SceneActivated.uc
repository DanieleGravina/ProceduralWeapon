/**
 * This event is activated when a scene is opened.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIEvent_SceneActivated extends UIEvent_Scene;

/**
 * True if the scene has just been activated; FALSE if the scene is becoming active as a result of closing another scene.
 */
var		bool			bInitialActivation;

/**
 * Called when this event is deactivated.
 *
 * This version disables all output links if the container scene is invalid or is no
 * longer in the scene client's active scenes array.
 */
event DeActivated()
{
	local int i;
	local UIScene OwnerScene;

	Super.DeActivated();

	// find the scene that contains this event
	OwnerScene = GetOwnerScene();
	if ( OwnerScene == None || !OwnerScene.IsSceneActive() )
	{
		// if we don't have an owner scene, or it is no longer part of the scene client's active scenes, disable this
		// event's output links as any action linked to a "Scene Opened" event will probably need to perform work that is dangerous
		// if the scene is no longer active
		for ( i = 0; i < OutputLinks.Length; i++ )
		{
			OutputLinks[i].bHasImpulse = false;
		}


		if ( OwnerScene == None )
		{
			ScriptLog("Disabling" @ Class.Name @ PathName(Self) @ "because containing scene is None");
			LogInternal("Disabling" @ Class.Name @ PathName(Self) @ "because containing scene is None",'DevUI');
		}
		else
		{
			ScriptLog("Disabling" @ Class.Name @ PathName(Self) @ "because containing scene" @ OwnerScene.SceneTag @ "is no longer active");
			LogInternal("Disabling" @ Class.Name @ PathName(Self) @ "because containing scene" @ OwnerScene.SceneTag @ "is no longer active",'DevUI');
		}

	}
}

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Initial Activation",PropertyName="bInitialActivation",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   ObjClassVersion=3
   ObjPosX=48
   ObjPosY=216
   ObjName="Scene Opened"
   Name="Default__UIEvent_SceneActivated"
   ObjectArchetype=UIEvent_Scene'Engine.Default__UIEvent_Scene'
}
