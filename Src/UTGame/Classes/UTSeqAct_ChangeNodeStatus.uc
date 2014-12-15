/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTSeqAct_ChangeNodeStatus extends SequenceAction;

/** the team that should have control of the node, if it is set to Constructing or Built state */
var() int OwnerTeam;

defaultproperties
{
   InputLinks(0)=(LinkDesc="Constructing")
   InputLinks(1)=(LinkDesc="Built")
   InputLinks(2)=(LinkDesc="Neutral")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Owner Team",PropertyName="OwnerTeam",MinVars=1,MaxVars=255)
   ObjName="Change Node Status"
   ObjCategory="Objective"
   Name="Default__UTSeqAct_ChangeNodeStatus"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
