/**
 * Contains information about how to present and format text
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIStyle_Text extends UIStyle_Data
	native(inherit);

/** the font associated with this text style */
var						Font				StyleFont;

/** attributes to apply to this style's font */
var						UITextAttributes	Attributes;

/** text alignment within the bounding region */
var						EUIAlignment		Alignment[EUIOrientation.UIORIENT_MAX];

/**
 * Determines what happens when the text doesn't fit into the bounding region.
 */
var 					ETextClipMode		ClipMode;

/** Determines how the nodes of this string are ordered when the string is being clipped */
var						EUIAlignment		ClipAlignment;

/** Allows text to be scaled to fit within the bounding region */
var						TextAutoScaleValue	AutoScaling;

/** the scale to use for rendering text */
var						Vector2D			Scale;

/** Horizontal spacing adjustment between characters and vertical spacing adjustment between lines of wrapped text */
var						Vector2D			SpacingAdjust;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   StyleFont=Font'EngineFonts.SmallFont'
   Alignment(1)=UIALIGN_Center
   AutoScaling=(MinScale=0.600000)
   Scale=(X=1.000000,Y=1.000000)
   UIEditorControlClass="WxStyleTextPropertiesGroup"
   Name="Default__UIStyle_Text"
   ObjectArchetype=UIStyle_Data'Engine.Default__UIStyle_Data'
}
