/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Specific version of the menu list that draws an icon in addition to the menu text for the current faction.
 */
class UTUICharacterFactionMenuList extends UTUIIconMenuList;

event SelectItem(int NewSelection)
{
	local string OutValue;

	Super.SelectItem(NewSelection);

	// IconImage
	GetCellFieldString(self, 'IconImage', Selection, OutValue);
	IconImage = Texture2D(DynamicLoadObject(OutValue, class'Texture2D'));

	// IconU
	GetCellFieldString(self, 'IconU', Selection, OutValue);
	IconU = float(OutValue);

	// IconV
	GetCellFieldString(self, 'IconV', Selection, OutValue);
	IconV = float(OutValue);

	// IconUL
	GetCellFieldString(self, 'IconUL', Selection, OutValue);
	IconUL = float(OutValue);

	// IconVL
	GetCellFieldString(self, 'IconVL', Selection, OutValue);
	IconVL = float(OutValue);
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUICharacterFactionMenuList"
   ObjectArchetype=UTUIIconMenuList'UTGame.Default__UTUIIconMenuList'
}
