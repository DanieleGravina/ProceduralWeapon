/**
 * Example of how to setup a complex widget which contains child widgets in unrealscript.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ScriptConsoleEntry extends UIPanel;

var	instanced	UIEditBox		InputBox;
var	instanced	UIImage			UpperConsoleBorder;
var	instanced	UIImage			LowerConsoleBorder;

const ConsolePromptText = "(> ";

event Initialized()
{
	Super.Initialized();

	InsertChild(InputBox,INDEX_NONE,false);
	InsertChild(UpperConsoleBorder,INDEX_NONE,false);
	InsertChild(LowerConsoleBorder,INDEX_NONE,false);
}


event PostInitialize()
{
	Super.PostInitialize();

	// setup the lower border image
	LowerConsoleBorder.SetDockTarget(UIFACE_Bottom, Self, UIFACE_Bottom);

	// setup the input label
	InputBox.SetDockTarget(UIFACE_Left,		Self,				UIFACE_Left);
	InputBox.SetDockParameters(UIFACE_Bottom,	LowerConsoleBorder,	UIFACE_Bottom, -3);
	InputBox.SetDockTarget(UIFACE_Right,	Self,				UIFACE_Right);

	// setup the upper border image
	UpperConsoleBorder.SetDockParameters(UIFACE_Bottom, InputBox, UIFACE_Top, -2);

	// setup this widget
	SetDockTarget(UIFACE_Left,		GetParent(),		UIFACE_Left);
	SetDockTarget(UIFACE_Right,		GetParent(),		UIFACE_Right);
	SetDockTarget(UIFACE_Bottom,	GetParent(),		UIFACE_Bottom);
	SetDockTarget(UIFACE_Top,		UpperConsoleBorder,	UIFACE_Top);
}

function SetValue( string NewValue )
{
	InputBox.SetValue(ConsolePromptText $ NewValue);
}

function OnCreateChild( UIObject CreatedWidget, UIScreenObject CreatorContainer )
{
	if ( CreatedWidget == InputBox )
	{
		InputBox.StringRenderComponent.bIgnoreMarkup=true;
		InputBox.StringRenderComponent.EnableAutoSizing(UIORIENT_Vertical);

		InputBox.StringRenderComponent.SetWrapMode(CLIP_Wrap);
		InputBox.StringRenderComponent.StringCaret.bDisplayCaret=true;
	}
}

defaultproperties
{
   Begin Object Class=UIEditBox Name=ConsoleInputTemplate ObjName=ConsoleInputTemplate Archetype=UIEditBox'Engine.Default__UIEditBox'
      Begin Object Class=UIComp_DrawStringEditbox Name=EditboxStringRenderer ObjName=EditboxStringRenderer Archetype=UIComp_DrawStringEditbox'Engine.Default__UIEditBox:EditboxStringRenderer'
         ObjectArchetype=UIComp_DrawStringEditbox'EditboxStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=EditboxBackgroundTemplate ObjName=EditboxBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIEditBox:EditboxBackgroundTemplate'
         ObjectArchetype=UIComp_DrawImage'EditboxBackgroundTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIEditBox:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      DataSource=(MarkupString="(> ")
      WidgetTag="InputBox"
      PrimaryStyle=(DefaultStyleTag="ConsoleStyle")
      __OnCreate__Delegate=Default__ScriptConsoleEntry.OnCreateChild
      Position=(Value[3]=16.000000,ScaleType[3]=EVALPOS_PixelOwner)
      Name="ConsoleInputTemplate"
      ObjectArchetype=UIEditBox'Engine.Default__UIEditBox'
   End Object
   InputBox=UIEditBox'Engine.Default__ScriptConsoleEntry:ConsoleInputTemplate'
   Begin Object Class=UIImage Name=UpperBorderTemplate ObjName=UpperBorderTemplate Archetype=UIImage'Engine.Default__UIImage'
      Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__UIImage:ImageComponentTemplate'
         ObjectArchetype=UIComp_DrawImage'ImageComponentTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIImage:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      WidgetTag="UpperConsoleBorder"
      PrimaryStyle=(DefaultStyleTag="ConsoleImageStyle")
      Position=(Value[2]=1.000000,Value[3]=2.000000,ScaleType[2]=EVALPOS_PercentageOwner)
      Name="UpperBorderTemplate"
      ObjectArchetype=UIImage'Engine.Default__UIImage'
   End Object
   UpperConsoleBorder=UIImage'Engine.Default__ScriptConsoleEntry:UpperBorderTemplate'
   Begin Object Class=UIImage Name=LowerBorderTemplate ObjName=LowerBorderTemplate Archetype=UIImage'Engine.Default__UIImage'
      Begin Object Class=UIComp_DrawImage Name=ImageComponentTemplate ObjName=ImageComponentTemplate Archetype=UIComp_DrawImage'Engine.Default__UIImage:ImageComponentTemplate'
         ObjectArchetype=UIComp_DrawImage'ImageComponentTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIImage:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      WidgetTag="LowerConsoleBorder"
      PrimaryStyle=(DefaultStyleTag="ConsoleImageStyle")
      Position=(Value[2]=1.000000,Value[3]=2.000000,ScaleType[2]=EVALPOS_PercentageOwner)
      Name="LowerBorderTemplate"
      ObjectArchetype=UIImage'Engine.Default__UIImage'
   End Object
   LowerConsoleBorder=UIImage'Engine.Default__ScriptConsoleEntry:LowerBorderTemplate'
   Begin Object Class=UIComp_DrawImage Name=PanelBackgroundTemplate ObjName=PanelBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIPanel:PanelBackgroundTemplate'
      ImageStyle=(DefaultStyleTag="ConsoleBackgroundStyle")
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIPanel:PanelBackgroundTemplate'
   End Object
   BackgroundImageComponent=PanelBackgroundTemplate
   WidgetTag="ConsoleInputBox"
   PrimaryStyle=(DefaultStyleTag="ConsoleStyle",RequiredStyleClass=Class'Engine.UIStyle_Combo')
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIPanel:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIPanel:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__ScriptConsoleEntry"
   ObjectArchetype=UIPanel'Engine.Default__UIPanel'
}
