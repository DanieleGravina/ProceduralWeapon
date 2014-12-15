/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGib_RobotHead extends UTGib_Robot;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Robot:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Robot:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_HeadshotRoll_Cue'
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Gib_Corrupt_Part14',DrawScale=1.000000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_RobotHead"
   ObjectArchetype=UTGib_Robot'UTGame.Default__UTGib_Robot'
}
