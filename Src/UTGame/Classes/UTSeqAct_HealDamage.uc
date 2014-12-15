/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_HealDamage extends SeqAct_HealDamage;

/** heal UTPawns up to SuperHealthMax instead of their normal max health */
var() bool bSuperHeal;

defaultproperties
{
   HandlerName="OnHealDamage"
   ObjName="Heal Damage (UT)"
   Name="Default__UTSeqAct_HealDamage"
   ObjectArchetype=SeqAct_HealDamage'Engine.Default__SeqAct_HealDamage'
}
