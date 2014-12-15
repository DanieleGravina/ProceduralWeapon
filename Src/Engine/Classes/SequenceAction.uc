/**
 * This is an op that by default performs a behavior on any targeted
 * objects.
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SequenceAction extends SequenceOp
	native(Sequence)
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Handler function name for this action, if none will use the class name to autogenerate one: SeqAct_DoSomething sets HandlerName to "OnDoSomething" */
var Name HandlerName;

/** If true this action will call the handler function on all targeted actors */
var bool bCallHandler;

/** List of objects to call the handler function on */
var() array<Object> Targets;

defaultproperties
{
   bCallHandler=True
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Target",PropertyName="Targets",MinVars=1,MaxVars=255)
   ObjName="Unknown Action"
   ObjColor=(B=255,G=0,R=255,A=255)
   Name="Default__SequenceAction"
   ObjectArchetype=SequenceOp'Engine.Default__SequenceOp'
}
