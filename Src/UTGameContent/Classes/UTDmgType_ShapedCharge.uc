/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ShapedCharge extends UTDamageType;

defaultproperties
{
   bDestroysBarricades=True
   bComplainFriendlyFire=False
   DamageWeaponClass=Class'UTGameContent.UTDeployableShapedCharge'
   KillStatsName="KILLS_SHAPEDCHARGE"
   DeathStatsName="DEATHS_SHAPEDCHARGE"
   SuicideStatsName="SUICIDES_SHAPEDCHARGE"
   Name="Default__UTDmgType_ShapedCharge"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
