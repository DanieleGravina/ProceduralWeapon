/**
 * This viewport input class is used by viewports in 2D object editor windows.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class ObjectEditorViewportInput extends EditorViewportInput
	transient
	native(Private)
	config(Input);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Bindings(0)=(Name="Y",Command="TRANSACTION REDO",Control=True)
   Bindings(1)=(Name="Z",Command="TRANSACTION REDO",Control=True,Shift=True)
   Bindings(2)=(Name="Z",Command="TRANSACTION UNDO",Control=True)
   Name="Default__ObjectEditorViewportInput"
   ObjectArchetype=EditorViewportInput'Editor.Default__EditorViewportInput'
}
