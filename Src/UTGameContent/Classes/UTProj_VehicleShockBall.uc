/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_VehicleShockBall extends UTProj_VehicleShockBallBase;

defaultproperties
{
   ComboDamageType=Class'UTGameContent.UTDmgType_VehicleShockChain'
   ComboTriggerType=Class'UTGameContent.UTDmgType_VehicleShockBeam'
   MyDamageType=Class'UTGameContent.UTDmgType_VehicleShockBall'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_VehicleShockBallBase:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_VehicleShockBallBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_VehicleShockBall"
   ObjectArchetype=UTProj_VehicleShockBallBase'UTGameContent.Default__UTProj_VehicleShockBallBase'
}
