/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class KismetBindings extends Object
	native
	config(Editor);

struct native KismetKeyBind
{
	var config name		Key;
	var config bool		bControl;
	var config name		SeqObjClassName;
};

var config array<KismetKeyBind>	Bindings;

/** Represent one style preset for a Kismet comment box. */
struct native KismetCommentPreset
{
	var config name		PresetName;
	var config int		BorderWidth;
	var config color	BorderColor;
	var config bool		bFilled;
	var config color	FillColor;
};

/** Array of comment style presets, specified in ini file. */
var config array<KismetCommentPreset> CommentPresets;

defaultproperties
{
   Bindings(0)=(Key="O",SeqObjClassName="Engine.SeqVar_Object")
   Bindings(1)=(Key="S",SeqObjClassName="Engine.SeqVar_String")
   Bindings(2)=(Key="P",SeqObjClassName="Engine.SeqVar_Player")
   Bindings(3)=(Key="I",SeqObjClassName="Engine.SeqVar_Int")
   Bindings(4)=(Key="I",bControl=True,SeqObjClassName="Engine.SeqCond_CompareInt")
   Bindings(5)=(Key="F",SeqObjClassName="Engine.SeqVar_Float")
   Bindings(6)=(Key="F",bControl=True,SeqObjClassName="Engine.SeqCond_CompareFloat")
   Bindings(7)=(Key="B",SeqObjClassName="Engine.SeqVar_Bool")
   Bindings(8)=(Key="B",bControl=True,SeqObjClassName="Engine.SeqCond_CompareBool")
   Bindings(9)=(Key="N",SeqObjClassName="Engine.SeqVar_Named")
   Bindings(10)=(Key="E",SeqObjClassName="Engine.SeqVar_External")
   Bindings(11)=(Key="LeftBracket",SeqObjClassName="Engine.SeqEvent_SequenceActivated")
   Bindings(12)=(Key="RightBracket",SeqObjClassName="Engine.SeqAct_FinishSequence")
   Bindings(13)=(Key="T",SeqObjClassName="Engine.SeqAct_Toggle")
   Bindings(14)=(Key="D",SeqObjClassName="Engine.SeqAct_Delay")
   Bindings(15)=(Key="L",SeqObjClassName="Engine.SeqAct_Log")
   Bindings(16)=(Key="M",SeqObjClassName="Engine.SeqAct_Interp")
   Bindings(17)=(Key="S",bControl=True,SeqObjClassName="Engine.SeqEvent_LevelStartup")
   Bindings(18)=(Key="X",SeqObjClassName="Engine.SeqCond_Increment")
   Bindings(19)=(Key="Q",SeqObjClassName="Engine.Sequence")
   Bindings(20)=(Key="G",SeqObjClassName="Engine.SeqAct_Gate")
   CommentPresets(0)=(PresetName="Default",BorderWidth=1,BorderColor=(B=0,G=0,R=0,A=255),bFilled=True,FillColor=(B=0,G=0,R=0,A=16))
   Name="Default__KismetBindings"
   ObjectArchetype=Object'Core.Default__Object'
}
