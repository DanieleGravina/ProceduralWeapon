/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_AttachTowCable extends SequenceAction;

/** vehicle to attach to */
var UTVehicle AttachTo;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Attach To",PropertyName="AttachTo",MinVars=1,MaxVars=255)
   ObjName="Attach Tow Cable"
   ObjCategory="Vehicle"
   Name="Default__UTSeqAct_AttachTowCable"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
