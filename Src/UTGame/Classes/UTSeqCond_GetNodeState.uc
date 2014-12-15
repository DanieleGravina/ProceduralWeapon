/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTSeqCond_GetNodeState extends SequenceCondition;

var() UTOnslaughtNodeObjective Node;

event Activated()
{
	if (Node == None)
	{
		ScriptLog("Invalid target specified for" @ self);
	}
	else
	{
		if (Node.IsActive())
		{
			OutputLinks[0].bHasImpulse = true;
		}
		else if (Node.bIsConstructing)
		{
			OutputLinks[1].bHasImpulse = true;
		}
		else
		{
			OutputLinks[2].bHasImpulse = true;
		}
	}
}

defaultproperties
{
   OutputLinks(0)=(LinkDesc="Active")
   OutputLinks(1)=(LinkDesc="Constructing")
   OutputLinks(2)=(LinkDesc="Neutral/Destroyed")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Node",PropertyName="Node",MinVars=1,MaxVars=1)
   ObjName="Onslaught Node State"
   Name="Default__UTSeqCond_GetNodeState"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
