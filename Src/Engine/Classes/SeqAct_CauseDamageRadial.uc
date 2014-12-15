/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_CauseDamageRadial extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Type of damage to apply */
var() class<DamageType>		DamageType;

/** Amount of momentum to apply */
var() float					Momentum;

/** Amount of damage to apply */
var() float			DamageAmount;

/** Distance to Instigator within which to damage actors */
var()	float		DamageRadius;

/** Whether damage should decay linearly based on distance from the instigator. */
var()	bool		bDamageFalloff;

/** player that should take credit for the damage (Controller or Pawn) */
var Actor Instigator;

defaultproperties
{
   Momentum=500.000000
   DamageRadius=200.000000
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Amount",PropertyName="DamageAmount",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Instigator",PropertyName="Instigator",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Cause Damage Radial"
   ObjCategory="Actor"
   Name="Default__SeqAct_CauseDamageRadial"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
