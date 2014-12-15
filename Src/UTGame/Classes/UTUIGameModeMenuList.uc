/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Specific version of the menu list that draws an icon in addition to the menu text for game modes.
 */
class UTUIGameModeMenuList extends UTUIIconMenuList;

event SelectItem(int NewSelection)
{
	local string OutValue;

	// Clamp selection.
	if(NewSelection<0)
	{
		NewSelection = List.length-1;
	}
	else
	{
		NewSelection=NewSelection%List.length;
	}

	// IconImage
	GetCellFieldString(self, 'IconImage', NewSelection, OutValue);
	IconImage = Texture2D(DynamicLoadObject(OutValue, class'Texture2D'));

	// IconU
	GetCellFieldString(self, 'IconU', NewSelection, OutValue);
	IconU = float(OutValue);

	// IconV
	GetCellFieldString(self, 'IconV', NewSelection, OutValue);
	IconV = float(OutValue);

	// IconUL
	GetCellFieldString(self, 'IconUL', NewSelection, OutValue);
	IconUL = float(OutValue);

	// IconVL
	GetCellFieldString(self, 'IconVL', NewSelection, OutValue);
	IconVL = float(OutValue);

	Super.SelectItem(NewSelection);
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIGameModeMenuList"
   ObjectArchetype=UTUIIconMenuList'UTGame.Default__UTUIIconMenuList'
}
