/**
 * This component presents list data in a cascading (aka context menus with submenus) fashion.
 *
 * @todo - not yet implemented
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIComp_ListPresenterCascade extends UIComp_ListPresenter
	native(inherit);

defaultproperties
{
   Begin Object Class=UITexture Name=NormalOverlayTemplate ObjName=NormalOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenter:NormalOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenter:NormalOverlayTemplate'
   End Object
   ListItemOverlay(0)=UITexture'Engine.Default__UIComp_ListPresenterCascade:NormalOverlayTemplate'
   Begin Object Class=UITexture Name=ActiveOverlayTemplate ObjName=ActiveOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenter:ActiveOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenter:ActiveOverlayTemplate'
   End Object
   ListItemOverlay(1)=UITexture'Engine.Default__UIComp_ListPresenterCascade:ActiveOverlayTemplate'
   Begin Object Class=UITexture Name=SelectionOverlayTemplate ObjName=SelectionOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenter:SelectionOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenter:SelectionOverlayTemplate'
   End Object
   ListItemOverlay(2)=UITexture'Engine.Default__UIComp_ListPresenterCascade:SelectionOverlayTemplate'
   Begin Object Class=UITexture Name=HoverOverlayTemplate ObjName=HoverOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenter:HoverOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenter:HoverOverlayTemplate'
   End Object
   ListItemOverlay(3)=UITexture'Engine.Default__UIComp_ListPresenterCascade:HoverOverlayTemplate'
   Name="Default__UIComp_ListPresenterCascade"
   ObjectArchetype=UIComp_ListPresenter'Engine.Default__UIComp_ListPresenter'
}
