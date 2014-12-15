/** 
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTMapMusicInfo extends Object
	native
	dependson(UTTypes)
	hidecategories(Object)
	editinlinenew;


/** 
 * This is the music for the map.  Content folk will pick from the various sets of music that exist
 * and then specify the music the map should have.
 **/
var() MusicForAMap MapMusic;

/** These are the stingers for the map **/
var() StingersForAMap MapStingers;

defaultproperties
{
   MapMusic=(Action=(CrossfadeToMeNumMeasuresDuration=1),Ambient=(CrossfadeToMeNumMeasuresDuration=1),Intro=(CrossfadeToMeNumMeasuresDuration=1),Suspense=(CrossfadeToMeNumMeasuresDuration=1),Tension=(CrossfadeToMeNumMeasuresDuration=1),Victory=(CrossfadeToMeNumMeasuresDuration=1))
   Name="Default__UTMapMusicInfo"
   ObjectArchetype=Object'Core.Default__Object'
}
