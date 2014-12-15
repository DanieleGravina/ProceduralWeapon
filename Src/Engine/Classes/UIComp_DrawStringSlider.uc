/**
 * This specialized version of UIComp_DrawString handles rendering the value caption for UISliders.  The responsibilities specific
 * to rendering slider captions are:
 * @todo
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIComp_DrawStringSlider extends UIComp_DrawString
	native(inherit);

defaultproperties
{
   StringStyle=(DefaultStyleTag="DefaultSliderCaptionStyle")
   Name="Default__UIComp_DrawStringSlider"
   ObjectArchetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
}
