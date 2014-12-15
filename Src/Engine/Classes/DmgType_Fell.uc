/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DmgType_Fell extends DamageType
	abstract;

defaultproperties
{
   DeathString="`k ha spinto `o oltre il bordo."
   FemaleSuicide="`o ha lasciato un piccolo cratere"
   MaleSuicide="`o ha lasciato un piccolo cratere"
   bLocationalHit=False
   bCausedByWorld=True
   GibModifier=2.000000
   Name="Default__DmgType_Fell"
   ObjectArchetype=DamageType'Engine.Default__DamageType'
}
