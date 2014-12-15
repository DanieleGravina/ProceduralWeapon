/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_RedeemerRed extends UTProj_Redeemer;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'UTGameContent.Default__UTProj_Redeemer:ProjectileMesh'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTProj_Redeemer:ProjectileMesh'
   End Object
   ProjMesh=ProjectileMesh
   TeamColor=(R=14.000000,G=1.000000,B=0.500000,A=1.000000)
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_Redeemer:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_Redeemer:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=RedeemerLightEnvironment ObjName=RedeemerLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_Redeemer:RedeemerLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_Redeemer:RedeemerLightEnvironment'
   End Object
   Components(1)=RedeemerLightEnvironment
   Components(2)=ProjectileMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_RedeemerRed"
   ObjectArchetype=UTProj_Redeemer'UTGameContent.Default__UTProj_Redeemer'
}
