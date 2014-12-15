/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_Teleport extends SequenceAction;

var() bool bUpdateRotation;

defaultproperties
{
   bUpdateRotation=True
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Destination",MinVars=1,MaxVars=255)
   ObjName="Teleport"
   ObjCategory="Actor"
   Name="Default__SeqAct_Teleport"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
