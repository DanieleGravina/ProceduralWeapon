/**
* This is an op that gives hero points to the targeted pawn(s)
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/
class UTSeqAct_GiveHeroPoints extends SequenceAction;

/** Number of hero points to give out */
var() int HeroPoints;

defaultproperties
{
   VariableLinks(0)=(LinkDesc="Pawns")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Amount",PropertyName="HeroPoints",MinVars=1,MaxVars=255)
   ObjName="Give Hero Points"
   ObjCategory="Pawn"
   Name="Default__UTSeqAct_GiveHeroPoints"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
