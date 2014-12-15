/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_EradicatorShellChild extends UTProj_SPMAShellChild;

defaultproperties
{
   MyDamageType=Class'UT3Gold.UTDmgType_EradicatorShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_SPMAShellChild:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_SPMAShellChild:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_EradicatorShellChild"
   ObjectArchetype=UTProj_SPMAShellChild'UTGameContent.Default__UTProj_SPMAShellChild'
}
