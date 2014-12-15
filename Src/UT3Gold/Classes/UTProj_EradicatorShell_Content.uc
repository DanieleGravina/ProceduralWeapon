/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_EradicatorShell_Content extends UTProj_SPMAShell_Content;

defaultproperties
{
   ChildProjectileClass=Class'UT3Gold.UTProj_EradicatorShellChild'
   MyDamageType=Class'UT3Gold.UTDmgType_EradicatorShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_SPMAShell_Content:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_SPMAShell_Content:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_EradicatorShell_Content"
   ObjectArchetype=UTProj_SPMAShell_Content'UTGameContent.Default__UTProj_SPMAShell_Content'
}
