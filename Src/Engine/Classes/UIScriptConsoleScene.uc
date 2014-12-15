/**
 * Example of how to setup a scene in unrealscript.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIScriptConsoleScene extends UIScene
	transient
	notplaceable;

/** the console's buffer text */
var	instanced UILabel				BufferText;

/** the background for the console */
var	instanced UIImage				BufferBackground;

/** where the text that is currently being typed appears */
var	instanced ScriptConsoleEntry	CommandRegion;

event Initialized()
{
	Super.Initialized();

	InsertChild(BufferBackground);
	InsertChild(BufferText);
	InsertChild(CommandRegion);
}

event PostInitialize()
{
	Super.PostInitialize();

	BufferBackground.SetDockTarget(UIFACE_Left,		Self,			UIFACE_Left);
	BufferBackground.SetDockTarget(UIFACE_Top,		Self,			UIFACE_Top);
	BufferBackground.SetDockTarget(UIFACE_Right,	Self,			UIFACE_Right);
	BufferBackground.SetDockTarget(UIFACE_Bottom,	CommandRegion,	UIFACE_Top);

	BufferText.SetDockTarget(UIFACE_Bottom, CommandRegion, UIFACE_Top);
}

function OnCreateChild( UIObject CreatedWidget, UIScreenObject CreatorContainer )
{
	if ( CreatedWidget == BufferText )
	{
		BufferText.StringRenderComponent.EnableAutoSizing(UIORIENT_Vertical);
		BufferText.StringRenderComponent.SetWrapMode(CLIP_Wrap);
	}
}

defaultproperties
{
   Begin Object Class=UILabel Name=BufferTextTemplate ObjName=BufferTextTemplate Archetype=UILabel'Engine.Default__UILabel'
      Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UILabel:LabelStringRenderer'
         ObjectArchetype=UIComp_DrawString'LabelStringRenderer'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UILabel:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      WidgetTag="BufferText"
      PrimaryStyle=(DefaultStyleTag="ConsoleBufferStyle")
      __OnCreate__Delegate=Default__UIScriptConsoleScene.OnCreateChild
      Position=(Value[2]=1.000000,ScaleType[2]=EVALPOS_PercentageOwner)
      Name="BufferTextTemplate"
      ObjectArchetype=UILabel'Engine.Default__UILabel'
   End Object
   BufferText=UILabel'Engine.Default__UIScriptConsoleScene:BufferTextTemplate'
   Begin Object Class=UIImage Name=BufferBackgroundTemplate ObjName=BufferBackgroundTemplate Archetype=UIImage'Engine.Default__UIImage'
      Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__UIImage:ImageComponentTemplate'
         ObjectArchetype=UIComp_DrawImage'ImageComponentTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIImage:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      WidgetTag="BufferBackground"
      PrimaryStyle=(DefaultStyleTag="ConsoleBufferImageStyle")
      Name="BufferBackgroundTemplate"
      ObjectArchetype=UIImage'Engine.Default__UIImage'
   End Object
   BufferBackground=UIImage'Engine.Default__UIScriptConsoleScene:BufferBackgroundTemplate'
   Begin Object Class=ScriptConsoleEntry Name=CommandRegionTemplate ObjName=CommandRegionTemplate Archetype=ScriptConsoleEntry'Engine.Default__ScriptConsoleEntry'
      Begin Object Class=UIEditBox Name=ConsoleInputTemplate ObjName=ConsoleInputTemplate Archetype=UIEditBox'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate'
         Begin Object Class=UIComp_DrawStringEditbox Name=EditboxStringRenderer ObjName=EditboxStringRenderer Archetype=UIComp_DrawStringEditbox'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate.EditboxStringRenderer'
            ObjectArchetype=UIComp_DrawStringEditbox'EditboxStringRenderer'
         End Object
         Begin Object Class=UIComp_DrawImage Name=EditboxBackgroundTemplate ObjName=EditboxBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate.EditboxBackgroundTemplate'
            ObjectArchetype=UIComp_DrawImage'EditboxBackgroundTemplate'
         End Object
         Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate.WidgetEventComponent'
            ObjectArchetype=UIComp_Event'WidgetEventComponent'
         End Object
         __OnCreate__Delegate=CommandRegionTemplate.OnCreateChild
         ObjectArchetype=UIEditBox'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate'
      End Object
      Begin Object Class=UIImage Name=UpperBorderTemplate ObjName=UpperBorderTemplate Archetype=UIImage'Engine.Default__ScriptConsoleEntry:UpperBorderTemplate'
         Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__ScriptConsoleEntry:UpperBorderTemplate.ImageComponentTemplate'
            ObjectArchetype=UIComp_DrawImage'ImageComponentTemplate'
         End Object
         Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__ScriptConsoleEntry:UpperBorderTemplate.WidgetEventComponent'
            ObjectArchetype=UIComp_Event'WidgetEventComponent'
         End Object
         ObjectArchetype=UIImage'Engine.Default__ScriptConsoleEntry:UpperBorderTemplate'
      End Object
      Begin Object Class=UIImage Name=LowerBorderTemplate ObjName=LowerBorderTemplate Archetype=UIImage'Engine.Default__ScriptConsoleEntry:LowerBorderTemplate'
         Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__ScriptConsoleEntry:LowerBorderTemplate.ImageComponentTemplate'
            ObjectArchetype=UIComp_DrawImage'ImageComponentTemplate'
         End Object
         Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__ScriptConsoleEntry:LowerBorderTemplate.WidgetEventComponent'
            ObjectArchetype=UIComp_Event'WidgetEventComponent'
         End Object
         ObjectArchetype=UIImage'Engine.Default__ScriptConsoleEntry:LowerBorderTemplate'
      End Object
      Begin Object Class=UIComp_DrawImage Name=PanelBackgroundTemplate ObjName=PanelBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__ScriptConsoleEntry:PanelBackgroundTemplate'
         ObjectArchetype=UIComp_DrawImage'PanelBackgroundTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__ScriptConsoleEntry:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      InputBox=UIEditBox'Engine.Default__UIScriptConsoleScene:CommandRegionTemplate.ConsoleInputTemplate'
      UpperConsoleBorder=UIImage'Engine.Default__UIScriptConsoleScene:CommandRegionTemplate.UpperBorderTemplate'
      LowerConsoleBorder=UIImage'Engine.Default__UIScriptConsoleScene:CommandRegionTemplate.LowerBorderTemplate'
      Name="CommandRegionTemplate"
      ObjectArchetype=ScriptConsoleEntry'Engine.Default__ScriptConsoleEntry'
   End Object
   CommandRegion=ScriptConsoleEntry'Engine.Default__UIScriptConsoleScene:CommandRegionTemplate'
   SceneTag="ConsoleScene"
   Position=(Value[3]=0.750000,ScaleType[2]=EVALPOS_PercentageViewport,ScaleType[3]=EVALPOS_PercentageViewport)
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'Engine.Default__UIScene:SceneEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIScene:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UIScriptConsoleScene"
   ObjectArchetype=UIScene'Engine.Default__UIScene'
}
