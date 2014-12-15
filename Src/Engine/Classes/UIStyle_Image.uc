/**
 * Contains information about how to present and format an image's appearance
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIStyle_Image extends UIStyle_Data
	native(inherit);

/** The material to use if the image material cannot be loaded or this style is not applied to an image. */
var()			Surface					DefaultImage;

/** if DefaultImage points to a texture atlas, represents the coordinates to use for rendering this image */
var()			TextureCoordinates		Coordinates;

/** Information about how to modify the way the image is rendered. */
var()			UIImageAdjustmentData	AdjustmentType[EUIOrientation.UIORIENT_MAX];

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
   DefaultImage=Texture2D'EngineResources.DefaultTexture'
   AdjustmentType(0)=(AdjustmentType=ADJUST_Normal)
   AdjustmentType(1)=(AdjustmentType=ADJUST_Normal)
   UIEditorControlClass="WxStyleImagePropertiesGroup"
   Name="Default__UIStyle_Image"
   ObjectArchetype=UIStyle_Data'Engine.Default__UIStyle_Data'
}
