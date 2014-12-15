/**
 * This string rendering component is used in cases where the string should only be rendered within a small portion of the
 * widget's bounds, such as when rendering a caption for a complex widget or as some sort of overlay/tool tip.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIComp_DrawCaption extends UIComp_DrawString
	native(UIPrivate);

defaultproperties
{
   StyleResolverTag="Caption Style"
   TextStyleCustomization=(ClipMode=CLIP_Normal,bOverrideClipMode=True)
   Name="Default__UIComp_DrawCaption"
   ObjectArchetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
}
