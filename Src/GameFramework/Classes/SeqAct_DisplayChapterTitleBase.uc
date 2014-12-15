/**
 * Base class for DisplayingChapter titles on the screen.  Each game
 * should sub class this and do their own Activated() function
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_DisplayChapterTitleBase extends SequenceAction
	abstract;


// Total number of seconds to display the chapter title
var() float TotalDisplayTime;
// Time it will take to fade the text in and out
var() float TotalFadeTime;

defaultproperties
{
   TotalDisplayTime=6.000000
   TotalFadeTime=2.000000
   bCallHandler=False
   ObjClassVersion=2
   ObjName="Display Chapter Title"
   Name="Default__SeqAct_DisplayChapterTitleBase"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
