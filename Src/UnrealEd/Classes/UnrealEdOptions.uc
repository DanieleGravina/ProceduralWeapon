/**
 * This class stores options global to the entire editor.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UnrealEdOptions extends Object
	Config(Editor)
	native;


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


/** A category to store a list of commands. */
struct native EditorCommandCategory
{
	var name Parent;
	var name Name;
};

/** A parameterless exec command that can be bound to hotkeys and menu items in the editor. */
struct native EditorCommand
{
	var name Parent;
	var name CommandName;
	var string ExecCommand;
	var string Description;
};

/** Categories of commands. */
var config array<EditorCommandCategory> EditorCategories;

/** Commands that can be bound to in the editor. */
var config array<EditorCommand> EditorCommands;

/** Pointer to the key bindings object that actually stores key bindings for the editor. */
var UnrealEdKeyBindings	EditorKeyBindings;

/** Mapping of command name's to array index. */
var native map{FName, INT}	CommandMap;

defaultproperties
{
   EditorCategories(0)=(Name="Matinee")
   EditorCategories(1)=(Name="CurveEditor")
   EditorCommands(0)=(Parent="Matinee",CommandName="Matinee_TogglePlayPause",ExecCommand="Matinee TogglePlayPause",Description="Matinee_TogglePlayPause_Desc")
   EditorCommands(1)=(Parent="Matinee",CommandName="Matinee_DeleteSelection",ExecCommand="Matinee DeleteSelection",Description="Matinee_DeleteSelection_Desc")
   EditorCommands(2)=(Parent="Matinee",CommandName="Matinee_Undo",ExecCommand="Matinee Undo",Description="Matinee_Undo_Desc")
   EditorCommands(3)=(Parent="Matinee",CommandName="Matinee_Redo",ExecCommand="Matinee Redo",Description="Matinee_Redo_Desc")
   EditorCommands(4)=(Parent="Matinee",CommandName="Matinee_Copy",ExecCommand="Matinee Copy",Description="Matinee_Copy_Desc")
   EditorCommands(5)=(Parent="Matinee",CommandName="Matinee_Cut",ExecCommand="Matinee Cut",Description="Matinee_Cut_Desc")
   EditorCommands(6)=(Parent="Matinee",CommandName="Matinee_Paste",ExecCommand="Matinee Paste",Description="Matinee_Paste_Desc")
   EditorCommands(7)=(Parent="Matinee",CommandName="Matinee_MarkInSection",ExecCommand="Matinee MarkInSection",Description="Matinee_MarkInSection_Desc")
   EditorCommands(8)=(Parent="Matinee",CommandName="Matinee_MarkOutSection",ExecCommand="Matinee MarkOutSection",Description="Matinee_MarkOutSection_Desc")
   EditorCommands(9)=(Parent="Matinee",CommandName="Matinee_IncrementPosition",ExecCommand="Matinee IncrementPosition",Description="Matinee_IncrementPosition_Desc")
   EditorCommands(10)=(Parent="Matinee",CommandName="Matinee_DecrementPosition",ExecCommand="Matinee DecrementPosition",Description="Matinee_DecrementPosition_Desc")
   EditorCommands(11)=(Parent="Matinee",CommandName="Matinee_MoveToNextKey",ExecCommand="Matinee MoveToNextKey",Description="Matinee_MoveToNextKey_Desc")
   EditorCommands(12)=(Parent="Matinee",CommandName="Matinee_MoveToPrevKey",ExecCommand="Matinee MoveToPrevKey",Description="Matinee_MoveToPrevKey_Desc")
   EditorCommands(13)=(Parent="Matinee",CommandName="Matinee_SplitAnimKey",ExecCommand="Matinee SplitAnimKey",Description="Matinee_SplitAnimKey_Desc")
   EditorCommands(14)=(Parent="Matinee",CommandName="Matinee_ToggleSnap",ExecCommand="Matinee ToggleSnap",Description="Matinee_ToggleSnap_Desc")
   EditorCommands(15)=(Parent="Matinee",CommandName="Matinee_MoveActiveUp",ExecCommand="Matinee MoveActiveUp",Description="Matinee_MoveActiveUp_Desc")
   EditorCommands(16)=(Parent="Matinee",CommandName="Matinee_MoveActiveDown",ExecCommand="Matinee MoveActiveDown",Description="Matinee_MoveActiveDown_Desc")
   EditorCommands(17)=(Parent="Matinee",CommandName="Matinee_AddKey",ExecCommand="Matinee AddKey",Description="Matinee_AddKey_Desc")
   EditorCommands(18)=(Parent="Matinee",CommandName="Matinee_DuplicateSelectedKeys",ExecCommand="Matinee DuplicateSelectedKeys",Description="Matinee_DuplicateSelectedKeys_Desc")
   EditorCommands(19)=(Parent="Matinee",CommandName="Matinee_CropAnimationBeginning",ExecCommand="Matinee CropAnimationBeginning",Description="Matinee_CropAnimationBeginning_Desc")
   EditorCommands(20)=(Parent="Matinee",CommandName="Matinee_CropAnimationEnd",ExecCommand="Matinee CropAnimationEnd",Description="Matinee_CropAnimationEnd_Desc")
   EditorCommands(21)=(Parent="Matinee",CommandName="Matinee_ViewFitSequence",ExecCommand="Matinee ViewFitSequence",Description="Matinee_ViewFitSequence_Desc")
   EditorCommands(22)=(Parent="Matinee",CommandName="Matinee_ViewFitLoop",ExecCommand="Matinee ViewFitLoop",Description="Matinee_ViewFitLoop_Desc")
   EditorCommands(23)=(Parent="Matinee",CommandName="Matinee_ViewFitLoopSequence",ExecCommand="Matinee ViewFitLoopSequence",Description="Matinee_ViewFitLoopSequence_Desc")
   EditorCommands(24)=(Parent="Matinee",CommandName="Matinee_ChangeKeyInterpModeAUTO",ExecCommand="Matinee ChangeKeyInterpModeAUTO",Description="Matinee_ChangeKeyInterpModeAUTO_Desc")
   EditorCommands(25)=(Parent="Matinee",CommandName="Matinee_ChangeKeyInterpModeUSER",ExecCommand="Matinee ChangeKeyInterpModeUSER",Description="Matinee_ChangeKeyInterpModeUSER_Desc")
   EditorCommands(26)=(Parent="Matinee",CommandName="Matinee_ChangeKeyInterpModeBREAK",ExecCommand="Matinee ChangeKeyInterpModeBREAK",Description="Matinee_ChangeKeyInterpModeBREAK_Desc")
   EditorCommands(27)=(Parent="Matinee",CommandName="Matinee_ChangeKeyInterpModeLINEAR",ExecCommand="Matinee ChangeKeyInterpModeLINEAR",Description="Matinee_ChangeKeyInterpModeLINEAR_Desc")
   EditorCommands(28)=(Parent="Matinee",CommandName="Matinee_ChangeKeyInterpModeCONSTANT",ExecCommand="Matinee ChangeKeyInterpModeCONSTANT",Description="Matinee_ChangeKeyInterpModeCONSTANT_Desc")
   EditorCommands(29)=(Parent="CurveEditor",CommandName="CurveEditor_ChangeInterpModeAUTO",ExecCommand="CurveEditor ChangeInterpModeAUTO",Description="CurveEditor_ChangeInterpModeAUTO_Desc")
   EditorCommands(30)=(Parent="CurveEditor",CommandName="CurveEditor_ChangeInterpModeUSER",ExecCommand="CurveEditor ChangeInterpModeUSER",Description="CurveEditor_ChangeInterpModeUSER_Desc")
   EditorCommands(31)=(Parent="CurveEditor",CommandName="CurveEditor_ChangeInterpModeBREAK",ExecCommand="CurveEditor ChangeInterpModeBREAK",Description="CurveEditor_ChangeInterpModeBREAK_Desc")
   EditorCommands(32)=(Parent="CurveEditor",CommandName="CurveEditor_ChangeInterpModeLINEAR",ExecCommand="CurveEditor ChangeInterpModeLINEAR",Description="CurveEditor_ChangeInterpModeLINEAR_Desc")
   EditorCommands(33)=(Parent="CurveEditor",CommandName="CurveEditor_ChangeInterpModeCONSTANT",ExecCommand="CurveEditor ChangeInterpModeCONSTANT",Description="CurveEditor_ChangeInterpModeCONSTANT_Desc")
   EditorKeyBindings=UnrealEdKeyBindings'UnrealEd.Default__UnrealEdOptions:EditorKeyBindingsInst'
   Name="Default__UnrealEdOptions"
   ObjectArchetype=Object'Core.Default__Object'
}
