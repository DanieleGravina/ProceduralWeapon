/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTSeqAct_UseHoverboard extends SequenceAction;

/** reference to the hoverboard that was spawned, so that the scripter can access it */
var UTVehicle Hoverboard;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Hoverboard",PropertyName="Hoverboard",bWriteable=True,MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Use Hoverboard"
   ObjCategory="Pawn"
   Name="Default__UTSeqAct_UseHoverboard"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
