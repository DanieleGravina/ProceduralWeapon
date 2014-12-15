/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Specific version of the menu list that draws an icon in addition to the menu text.
 */
class UTUIIconMenuList extends UTUIMenuList;

/** Icon information. */
var transient vector2D IconPadding;
var transient Texture2D IconImage;
var transient float IconU;
var transient float IconV;
var transient float IconUL;
var transient float IconVL;
var transient LinearColor IconColor;

function DrawSelectionBG(float YPos)
{
	local float Width,Height;

	Height = DefaultCellHeight * SelectionCellHeightMultiplier * ResScaling.Y;
	Width = Height * ScrollWidthRatio;

	Super.DrawSelectionBG(YPos);

	Canvas.SetPos(Width*IconPadding.X, YPos+Height*IconPadding.Y);
	Canvas.DrawColorizedTile(IconImage, Width*(1.0 - IconPadding.X*2), Height*(1.0 - IconPadding.Y*2), IconU, IconV, IconUL, IconVL, IconColor);
}

/** Copies the icon from another icon menu list. */
function CopyIcon(UTUIIconMenuList OtherList)
{
	IconU=OtherList.IconU;
	IconV=OtherList.IconV;
	IconUL=OtherList.IconUL;
	IconVL=OtherList.IconVL;
	IconImage=OtherList.IconImage;
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIMenuList:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIMenuList:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIIconMenuList"
   ObjectArchetype=UTUIMenuList'UTGame.Default__UTUIMenuList'
}
