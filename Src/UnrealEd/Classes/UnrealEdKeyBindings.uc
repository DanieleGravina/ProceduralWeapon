/**
 * This class handles hotkey binding management for the editor.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UnrealEdKeyBindings extends Object
	Config(EditorKeyBindings)
	native;

/** An editor hotkey binding to a parameterless exec. */
struct native EditorKeyBinding
{
	var bool bCtrlDown;
	var bool bAltDown;
	var bool bShiftDown;
	var name Key;
	var name CommandName;
};

/** Array of keybindings */
var config array<EditorKeyBinding> KeyBindings;

defaultproperties
{
   KeyBindings(0)=(Key="SpaceBar",CommandName="Matinee_TogglePlayPause")
   KeyBindings(1)=(Key="Delete",CommandName="Matinee_DeleteSelection")
   KeyBindings(2)=(bCtrlDown=True,Key="Z",CommandName="Matinee_Undo")
   KeyBindings(3)=(bCtrlDown=True,Key="Y",CommandName="Matinee_Redo")
   KeyBindings(4)=(Key="I",CommandName="Matinee_MarkInSection")
   KeyBindings(5)=(Key="O",CommandName="Matinee_MarkOutSection")
   KeyBindings(6)=(Key="Period",CommandName="Matinee_IncrementPosition")
   KeyBindings(7)=(Key="Comma",CommandName="Matinee_DecrementPosition")
   KeyBindings(8)=(Key="Right",CommandName="Matinee_MoveToNextKey")
   KeyBindings(9)=(Key="Left",CommandName="Matinee_MoveToPrevKey")
   KeyBindings(10)=(Key="R",CommandName="Matinee_SplitAnimKey")
   KeyBindings(11)=(Key="S",CommandName="Matinee_ToggleSnap")
   KeyBindings(12)=(Key="Up",CommandName="Matinee_MoveActiveUp")
   KeyBindings(13)=(Key="Down",CommandName="Matinee_MoveActiveDown")
   KeyBindings(14)=(Key="Enter",CommandName="Matinee_AddKey")
   KeyBindings(15)=(bCtrlDown=True,Key="W",CommandName="Matinee_DuplicateSelectedKeys")
   KeyBindings(16)=(bCtrlDown=True,Key="I",CommandName="Matinee_CropAnimationBeginning")
   KeyBindings(17)=(bCtrlDown=True,Key="O",CommandName="Matinee_CropAnimationEnd")
   KeyBindings(18)=(bCtrlDown=True,Key="C",CommandName="Matinee_Copy")
   KeyBindings(19)=(bCtrlDown=True,Key="X",CommandName="Matinee_Cut")
   KeyBindings(20)=(bCtrlDown=True,Key="V",CommandName="Matinee_Paste")
   KeyBindings(21)=(Key="A",CommandName="Matinee_ViewFitSequence")
   KeyBindings(22)=(bShiftDown=True,Key="A",CommandName="Matinee_ViewFitLoop")
   KeyBindings(23)=(bCtrlDown=True,Key="A",CommandName="Matinee_ViewFitLoopSequence")
   KeyBindings(24)=(Key="one",CommandName="Matinee_ChangeKeyInterpModeAUTO")
   KeyBindings(25)=(Key="two",CommandName="Matinee_ChangeKeyInterpModeUSER")
   KeyBindings(26)=(Key="three",CommandName="Matinee_ChangeKeyInterpModeBREAK")
   KeyBindings(27)=(Key="four",CommandName="Matinee_ChangeKeyInterpModeLINEAR")
   KeyBindings(28)=(Key="five",CommandName="Matinee_ChangeKeyInterpModeCONSTANT")
   KeyBindings(29)=(Key="one",CommandName="CurveEditor_ChangeInterpModeAUTO")
   KeyBindings(30)=(Key="two",CommandName="CurveEditor_ChangeInterpModeUSER")
   KeyBindings(31)=(Key="three",CommandName="CurveEditor_ChangeInterpModeBREAK")
   KeyBindings(32)=(Key="four",CommandName="CurveEditor_ChangeInterpModeLINEAR")
   KeyBindings(33)=(Key="five",CommandName="CurveEditor_ChangeInterpModeCONSTANT")
   Name="Default__UnrealEdKeyBindings"
   ObjectArchetype=Object'Core.Default__Object'
}
