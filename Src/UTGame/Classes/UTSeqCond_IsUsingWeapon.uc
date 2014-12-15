/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqCond_IsUsingWeapon extends SequenceCondition;

/** player to look for inventory on */
var Actor Target;
/** weapon to check */
var() class<Weapon> RequiredWeapon;
/** whether subclasses of the specified class count */
var() bool bAllowSubclass;

/** Ii this is true, the weapon must be the Impact Hammer */
var() bool bMustBeImpactHammer;

/** Ii this is true, the weapon must be the Impact Hammer */
var() bool bMustBeTranslocator;

event Activated()
{
	local Pawn P;
	local bool bHasItem;

	P = GetPawn(Target);
	if (P != None)
	{
		if (P.Weapon != None)
		{

			if ( bMustBeImpactHAmmer )
			{
				bHasItem = ClassIsChildOf(P.Weapon.Class,class'UTWeap_ImpactHAmmer');
			}
			else if ( bMustBeTranslocator )
			{
				bHasItem = ClassIsChildOf(P.Weapon.Class,class'UTWeap_Translocator');
			}
			else
			{
				bHasItem = (bAllowSubclass ? ClassIsChildOf(P.Weapon.Class, RequiredWeapon) : P.Weapon.Class == RequiredWeapon);
			}
		}

		OutputLinks[bHasItem ? 0 : 1].bHasImpulse = true;
	}
}

defaultproperties
{
   OutputLinks(0)=(LinkDesc="Using It")
   OutputLinks(1)=(LinkDesc="Not Using It")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Target",PropertyName="Target",MinVars=1,MaxVars=1)
   ObjName="Is Using Weapon"
   Name="Default__UTSeqCond_IsUsingWeapon"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
