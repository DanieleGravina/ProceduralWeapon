/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DemoDamageType extends DamageType
	abstract;
/**
 * Damage type sample class to show how forcefeedback can be hooked in
 */

defaultproperties
{
   DamagedFFWaveform=ForceFeedbackWaveform'UTGame.Default__DemoDamageType:ForceFeedbackWaveform0'
   KilledFFWaveform=ForceFeedbackWaveform'UTGame.Default__DemoDamageType:ForceFeedbackWaveform1'
   Name="Default__DemoDamageType"
   ObjectArchetype=DamageType'Engine.Default__DamageType'
}
