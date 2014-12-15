/**
 * Custom list presenter class for the UIContextMenu.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIComp_ContextMenuListPresenter extends UIComp_ListPresenterCascade
	within UIContextMenu
	native(inherit);

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
   Begin Object Class=UITexture Name=NormalOverlayTemplate ObjName=NormalOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:NormalOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:NormalOverlayTemplate'
   End Object
   ListItemOverlay(0)=UITexture'Engine.Default__UIComp_ContextMenuListPresenter:NormalOverlayTemplate'
   Begin Object Class=UITexture Name=ActiveOverlayTemplate ObjName=ActiveOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:ActiveOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:ActiveOverlayTemplate'
   End Object
   ListItemOverlay(1)=UITexture'Engine.Default__UIComp_ContextMenuListPresenter:ActiveOverlayTemplate'
   Begin Object Class=UITexture Name=SelectionOverlayTemplate ObjName=SelectionOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:SelectionOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:SelectionOverlayTemplate'
   End Object
   ListItemOverlay(2)=UITexture'Engine.Default__UIComp_ContextMenuListPresenter:SelectionOverlayTemplate'
   Begin Object Class=UITexture Name=HoverOverlayTemplate ObjName=HoverOverlayTemplate Archetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:HoverOverlayTemplate'
      ObjectArchetype=UITexture'Engine.Default__UIComp_ListPresenterCascade:HoverOverlayTemplate'
   End Object
   ListItemOverlay(3)=UITexture'Engine.Default__UIComp_ContextMenuListPresenter:HoverOverlayTemplate'
   bDisplayColumnHeaders=False
   Name="Default__UIComp_ContextMenuListPresenter"
   ObjectArchetype=UIComp_ListPresenterCascade'Engine.Default__UIComp_ListPresenterCascade'
}
