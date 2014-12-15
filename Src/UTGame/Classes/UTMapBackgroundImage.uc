/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTMapBackgroundImage extends UIImage;

event PostInitialize()
{
	local Texture2D MapTex;
	local WorldInfo WI;
	local LocalPlayer LP;
	local UTOnslaughtMapInfo MapInfo;

	Super.PostInitialize();

	// Look up the Background
	LP = GetPlayerOwner();
	if ( LP != None && LP.Actor != None )
	{
		WI = LP.Actor.WorldInfo;
		if ( WI != none )
		{
 			MapInfo = UTOnslaughtMapInfo( WI.GetMapInfo() );
			if ( MapInfo != none )
			{
				MapTex = Texture2D(MapInfo.MapTexture);
				if ( MapTex != none )
				{
					ImageComponent.SetImage(MapTex);
					ImageComponent.DisableCustomColor();
					return;
				}
				else
				{
					SetVisibility(false);
				}

			}
		}
	}
}

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__UIImage:ImageComponentTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIImage:ImageComponentTemplate'
   End Object
   ImageComponent=ImageComponentTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIImage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIImage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTMapBackgroundImage"
   ObjectArchetype=UIImage'Engine.Default__UIImage'
}
