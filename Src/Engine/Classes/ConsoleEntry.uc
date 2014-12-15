/**
 * Temporary widget for representing the region that displays the text currently being typed into the console
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ConsoleEntry extends UIObject
	native(UIPrivate)
	notplaceable;		// notplaceable until I can resolve the circular docking relationship between the input box and the console prompt label

/** displays the text that is currently being typed */
var					UILabel			ConsolePromptLabel;
var					UIImage			ConsolePromptBackground;
var					UIEditBox		InputBox;
var					UIImage			LowerConsoleBorder;
var					UIImage			UpperConsoleBorder;

/** the current position of the cursor in InputBox's string */
var	transient 		int				CursorPosition;

/** controls whether the underline cursor is rendered */
var()				bool			bRenderCursor;

const ConsolePromptText = "(> ";

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event AddedChild( UIScreenObject WidgetOwner, UIObject NewChild )
{
	Super.AddedChild(WidgetOwner, NewChild);
//	if (InputText == None && UILabel(NewChild) != None )
//	{
//		InputText = UILabel(NewChild);
//		InputText.IgnoreMarkup(true);
//		SetValue("");
//	}
//	else if ( InputBox == None && UIEditBox(NewChild) != None )
//	{
//		InputBox = UIEditBox(NewChild);
//		InputBox.IgnoreMarkup(true);
//		SetValue("");
//	}
}

/**
 * Called immediately after a child has been removed from this screen object.  Clears the NotifyPositionChanged delegate in the removed child
 *
 * @param	WidgetOwner		the screen object that the widget was removed from.
 * @param	OldChild		the widget that was removed
 * @param	ExclusionSet	used to indicate that multiple widgets are being removed in one batch; useful for preventing references
 *							between the widgets being removed from being severed.
 *							NOTE: If a value is specified, OldChild will ALWAYS be part of the ExclusionSet, since it is being removed.
 */
event RemovedChild( UIScreenObject WidgetOwner, UIObject OldChild, optional array<UIObject> ExclusionSet )
{
	Super.RemovedChild(WidgetOwner, OldChild, ExclusionSet);
//	if ( InputText == OldChild )
//	{
//		InputText = None;
//	}
//	else if ( InputBox == OldChild )
//	{
//		InputBox = None;
//	}
}

event PostInitialize()
{
	Super.PostInitialize();

	// setup docking links
	SetupDockingLinks();
//	InputText = UILabel(FindChild('InputText'));
//	if ( InputText != None )
//	{
//		InputText.IgnoreMarkup(true);
//		SetValue("");
//	}
//	else
//	{
//		InputBox = UIEditBox(FindChild('InputBox'));
//		if ( InputBox != None )
//		{
//			InputBox.IgnoreMarkup(true);
//			SetValue("");
//		}
//	}
}

function SetupDockingLinks()
{
	// set our own dock targets.
//	SetDockTarget(UIFACE_Top, UpperConsoleBorder, UIFACE_Top);
	SetDockTarget(UIFACE_Bottom, GetScene(), UIFACE_Bottom);

	// set the docktargets for the input box
	InputBox.SetDockTarget(UIFACE_Left, ConsolePromptLabel, UIFACE_Right);
	InputBox.SetDockTarget(UIFACE_Right, Self, UIFACE_Right);
	InputBox.SetDockTarget(UIFACE_Bottom, LowerConsoleBorder, UIFACE_Top);

	// console prompt background
	ConsolePromptBackground.SetDockTarget(UIFACE_Left, ConsolePromptLabel, UIFACE_Left);
	ConsolePromptBackground.SetDockTarget(UIFACE_Top, ConsolePromptLabel, UIFACE_Top);
	ConsolePromptBackground.SetDockTarget(UIFACE_Right, ConsolePromptLabel, UIFACE_Right);
	ConsolePromptBackground.SetDockTarget(UIFACE_Bottom, ConsolePromptLabel, UIFACE_Bottom);

	// console prompt
	ConsolePromptLabel.SetDockTarget(UIFACE_Left, Self, UIFACE_Left);
	ConsolePromptLabel.SetDockTarget(UIFACE_Top, InputBox, UIFACE_Top);
	ConsolePromptLabel.SetDockTarget(UIFACE_Bottom, InputBox, UIFACE_Bottom);

	// border images
	LowerConsoleBorder.SetDockParameters(UIFACE_Top, Self, UIFACE_Bottom, -2.f);
	LowerConsoleBorder.SetDockTarget(UIFACE_Bottom, Self, UIFACE_Bottom);

	UpperConsoleBorder.SetDockParameters(UIFACE_Top, InputBox, UIFACE_Top, -2.f);
	UpperConsoleBorder.SetDockTarget(UIFACE_Bottom, InputBox, UIFACE_Top);
}

function SetValue( string NewValue )
{
	if ( InputBox != None )
	{
		InputBox.SetValue(NewValue);
	}
}

defaultproperties
{
   ConsolePromptLabel=UILabel'Engine.Default__ConsoleEntry:ConsolePromptTemplate'
   ConsolePromptBackground=UIImage'Engine.Default__ConsoleEntry:ConsolePromptBackgroundTemplate'
   InputBox=UIEditBox'Engine.Default__ConsoleEntry:InputBoxTemplate'
   LowerConsoleBorder=UIImage'Engine.Default__ConsoleEntry:LowerConsoleBorderTemplate'
   UpperConsoleBorder=UIImage'Engine.Default__ConsoleEntry:UpperConsoleBorderTemplate'
   WidgetTag="ConsoleEntry"
   PrimaryStyle=(DefaultStyleTag="ConsoleStyle")
   bSupportsPrimaryStyle=False
   Children(0)=UIEditBox'Engine.Default__ConsoleEntry:InputBoxTemplate'
   Children(1)=UIImage'Engine.Default__ConsoleEntry:ConsolePromptBackgroundTemplate'
   Children(2)=UILabel'Engine.Default__ConsoleEntry:ConsolePromptTemplate'
   Children(3)=UIImage'Engine.Default__ConsoleEntry:LowerConsoleBorderTemplate'
   Children(4)=UIImage'Engine.Default__ConsoleEntry:UpperConsoleBorderTemplate'
   DefaultStates(2)=Class'Engine.UIState_Focused'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__ConsoleEntry"
   ObjectArchetype=UIObject'Engine.Default__UIObject'
}
