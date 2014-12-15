/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class EditorViewportInput extends Input
	transient
	config(Input)
	native;

var EditorEngine	Editor;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Bindings(0)=(Name="SpaceBar",Command="MODE WIDGETMODECYCLE")
   Bindings(1)=(Name="Tilde",Command="MODE WIDGETCOORDSYSTEMCYCLE")
   Bindings(2)=(Name="Delete",Command="DELETE")
   Bindings(3)=(Name="F4",Command="EDCALLBACK ACTORPROPS")
   Bindings(4)=(Name="F4",Command="QUIT_EDITOR",Alt=True)
   Bindings(5)=(Name="F5",Command="EDCALLBACK SURFPROPS")
   Bindings(6)=(Name="F6",Command="EDCALLBACK LEVELPROPS")
   Bindings(7)=(Name="A",Command="ACTOR SELECT ALL",Shift=True)
   Bindings(8)=(Name="B",Command="POLY SELECT MATCHING BRUSH",Shift=True)
   Bindings(9)=(Name="C",Command="POLY SELECT ADJACENT COPLANARS",Shift=True)
   Bindings(10)=(Name="D",Command="DUPLICATE",Shift=True)
   Bindings(11)=(Name="E",Command="ACTOR SELECT MATCHINGSTATICMESH",Shift=True)
   Bindings(12)=(Name="F",Command="POLY SELECT ADJACENT FLOORS",Shift=True)
   Bindings(13)=(Name="G",Command="POLY SELECT MATCHING GROUPS",Shift=True)
   Bindings(14)=(Name="I",Command="POLY SELECT MATCHING ITEMS",Shift=True)
   Bindings(15)=(Name="J",Command="POLY SELECT ADJACENT ALL",Shift=True)
   Bindings(16)=(Name="M",Command="POLY SELECT MEMORY SET",Shift=True)
   Bindings(17)=(Name="M",Command="ACTOR LEVELCURRENT")
   Bindings(18)=(Name="M",Command="ACTOR MOVETOCURRENT",Control=True)
   Bindings(19)=(Name="N",Command="SELECT NONE",Shift=True)
   Bindings(20)=(Name="O",Command="POLY SELECT MEMORY INTERSECT",Shift=True)
   Bindings(21)=(Name="Q",Command="POLY SELECT REVERSE",Shift=True)
   Bindings(22)=(Name="R",Command="POLY SELECT MEMORY RECALL",Shift=True)
   Bindings(23)=(Name="S",Command="POLY SELECT ALL",Shift=True)
   Bindings(24)=(Name="T",Command="POLY SELECT MATCHING TEXTURE",Shift=True)
   Bindings(25)=(Name="U",Command="POLY SELECT MEMORY UNION",Shift=True)
   Bindings(26)=(Name="W",Command="POLY SELECT ADJACENT WALLS",Shift=True)
   Bindings(27)=(Name="X",Command="POLY SELECT MEMORY XOR",Shift=True)
   Bindings(28)=(Name="Y",Command="POLY SELECT ADJACENT SLANTS",Shift=True)
   Bindings(29)=(Name="Z",Command="ACTOR SELECT MATCHINGSTATICMESH ALLCLASSES",Shift=True)
   Bindings(30)=(Name="C",Command="EDIT COPY",Control=True)
   Bindings(31)=(Name="V",Command="EDIT PASTE",Control=True)
   Bindings(32)=(Name="W",Command="DUPLICATE",Control=True)
   Bindings(33)=(Name="X",Command="EDIT CUT",Control=True)
   Bindings(34)=(Name="Y",Command="TRANSACTION REDO",Control=True)
   Bindings(35)=(Name="Z",Command="TRANSACTION UNDO",Control=True)
   Bindings(36)=(Name="A",Command="BRUSH ADD",Control=True)
   Bindings(37)=(Name="S",Command="BRUSH SUBTRACT",Control=True)
   Bindings(38)=(Name="I",Command="BRUSH FROM INTERSECTION",Control=True)
   Bindings(39)=(Name="D",Command="BRUSH FROM DEINTERSECTION",Control=True)
   Bindings(40)=(Name="P",Command="PREFAB SELECTACTORSINPREFABS",Shift=True)
   Bindings(41)=(Name="End",Command="ACTOR ALIGN SNAPTOFLOOR ALIGN=0")
   Bindings(42)=(Name="End",Command="ACTOR ALIGN MOVETOGRID",Control=True)
   Bindings(43)=(Name="Home",Command="CAMERA ALIGN")
   Bindings(44)=(Name="Home",Command="CAMERA ALIGN ACTIVEVIEWPORTONLY",Shift=True)
   Bindings(45)=(Name="P",Command="MAP BRUSH GET",Control=True)
   Bindings(46)=(Name="K",Command="ACTOR FIND KISMET",Control=True)
   Bindings(47)=(Name="A",Command="ACTOR SELECT ALL FROMOBJ",Control=True,Shift=True)
   Bindings(48)=(Name="B",Command="ACTOR SYNCBROWSER",Control=True)
   Bindings(49)=(Name="Escape",Command="ACTOR DESELECT")
   Bindings(50)=(Name="Tab",Command="CTRLTAB SHIFTDOWN=FALSE",Control=True)
   Bindings(51)=(Name="Tab",Command="CTRLTAB SHIFTDOWN=TRUE",Control=True,Shift=True)
   Name="Default__EditorViewportInput"
   ObjectArchetype=Input'Engine.Default__Input'
}
