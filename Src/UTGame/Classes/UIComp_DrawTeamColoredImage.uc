/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Automatically apply a team color to an image
 */

class UIComp_DrawTeamColoredImage extends UIComp_DrawImage
	native(UI);

/** Holds the colors to use.  The last color in the array will be used for non-team games as well as team indexes that
    are out of range. */

var(Team) array<LinearColor> TeamColors;

/** For Testing - If we are in the editor, but not in the game, this value will be used */
var(Team) int EditorTeamIndex;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   TeamColors(0)=(R=3.000000,G=0.000000,B=0.050000,A=1.000000)
   TeamColors(1)=(R=0.500000,G=0.800000,B=10.000000,A=1.000000)
   TeamColors(2)=(R=4.000000,G=2.000000,B=0.500000,A=1.000000)
   Name="Default__UIComp_DrawTeamColoredImage"
   ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
}
