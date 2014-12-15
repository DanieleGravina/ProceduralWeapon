/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_CauseDamage extends SequenceAction
	native(Sequence);

/** Type of damage to apply */
var() class<DamageType>		DamageType;

/** Amount of momentum to apply */
var() float					Momentum;

/** Amount of damage to apply */
var() float			DamageAmount;

/** player that should take credit for the damage (Controller or Pawn) */
var Actor Instigator;

defaultproperties
{
   Momentum=500.000000
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Amount",PropertyName="DamageAmount",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Instigator",PropertyName="Instigator",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Cause Damage"
   ObjCategory="Actor"
   Name="Default__SeqAct_CauseDamage"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
