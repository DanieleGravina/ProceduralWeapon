/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_SPMAShockBall extends UTProj_VehicleShockBallBase;

defaultproperties
{
   ComboDamageType=Class'UTGameContent.UTDmgType_SPMAShockChain'
   ComboTriggerType=Class'UTGameContent.UTDmgType_SPMAShockBeam'
   MyDamageType=Class'UTGameContent.UTDmgType_SPMAShockBall'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_VehicleShockBallBase:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_VehicleShockBallBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SPMAShockBall"
   ObjectArchetype=UTProj_VehicleShockBallBase'UTGameContent.Default__UTProj_VehicleShockBallBase'
}
