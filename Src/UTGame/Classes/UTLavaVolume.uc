/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTLavaVolume extends WaterVolume
	placeable;

defaultproperties
{
   EntrySound=SoundCue'A_Character_Footsteps.FootSteps.A_Character_Footstep_WaterDeepLandCue'
   ExitSound=SoundCue'A_Character_Footsteps.FootSteps.A_Character_Footstep_WaterDeepCue'
   bPainCausing=True
   TerminalVelocity=1500.000000
   DamagePerSec=20.000000
   DamageType=Class'UTGame.UTDmgType_Lava'
   FluidFriction=8.000000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__WaterVolume:BrushComponent0'
      ObjectArchetype=BrushComponent'Engine.Default__WaterVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   CollisionComponent=BrushComponent0
   Name="Default__UTLavaVolume"
   ObjectArchetype=WaterVolume'Engine.Default__WaterVolume'
}
