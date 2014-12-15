/**
 * GamePlayerController
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class GamePlayerController extends PlayerController
	dependson(GamePawn)
	config(Game)
	native
	abstract;


/** Natively retrieve the chapter and act strings from the data store system */
native function GetChapterStrings( int eChapter, out String ChapterName, out String ActName );


/** Tell HUD to draw chapter title */
simulated function DisplayChapterTitle( int DisplayChapter, float TotalDisplayTime, float TotalFadeTime )
{
	ClientDisplayChapterTitle( DisplayChapter, TotalDisplayTime, TotalFadeTime );
}


reliable client function ClientDisplayChapterTitle( int DisplayChapter, float TotalDisplayTime, float TotalFadeTime )
{
	local string ChapterName, ActName;

	if ( myHUD != None )
	{
		// set this chapter to be the current chapter
		GetChapterStrings(DisplayChapter, ChapterName, ActName);
		GameHUD(myHUD).StartDrawingChapterTitle(ChapterName, ActName, TotalDisplayTime, TotalFadeTime);
	}
	// Update rich presence with the same information
	// @todo fill this in when we have rich presence
	//ClientSetCoopRichPresence(DisplayChapter, Difficulty);
}

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__PlayerController:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__PlayerController:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__PlayerController:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__PlayerController:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__GamePlayerController"
   ObjectArchetype=PlayerController'Engine.Default__PlayerController'
}
