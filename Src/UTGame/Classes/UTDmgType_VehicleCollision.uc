/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_VehicleCollision extends UTDamageType
	abstract;

// no K impulse because this occurs during async tick, so we can add impulse to kactors

defaultproperties
{
   DamageOverlayTime=0.000000
   KillStatsName="EVENT_RANOVERKILLS"
   DeathStatsName="EVENT_RANOVERDEATHS"
   DeathString="`k ha colpito `o a velocità sfrenata."
   FemaleSuicide="`o ha fatto un incidente."
   MaleSuicide="`o ha fatto un incidente."
   bArmorStops=False
   bLocationalHit=False
   KDamageImpulse=0.000000
   KImpulseRadius=0.000000
   Name="Default__UTDmgType_VehicleCollision"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
