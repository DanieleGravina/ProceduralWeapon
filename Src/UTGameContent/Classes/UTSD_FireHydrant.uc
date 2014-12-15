/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTSD_FireHydrant extends UTSimpleDestroyable
	placeable;

defaultproperties
{
   bDestroyOnPlayerTouch=False
   MeshOnDestroy=StaticMesh'HU_Deco3.SM.Mesh.S_HU_Deco_SM_FireHydrantCap01'
   SoundOnDestroy=SoundCue'A_Gameplay.FireHydrant.FireHydrant_BreakSpewCue'
   ParticlesOnDestroy=ParticleSystem'Envy_Level_Effects.Water.P_Water_BrokenHydrant'
   SpawnPhysMesh=StaticMesh'HU_Deco3.SM.Mesh.S_HU_Deco_SM_FireHydrant01'
   SpawnPhysMeshLinearVel=(X=0.000000,Y=0.000000,Z=1000.000000)
   SpawnPhysMeshAngularVel=(X=0.000000,Y=10.000000,Z=0.000000)
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'UTGame.Default__UTSimpleDestroyable:StaticMeshComponent0'
      StaticMesh=StaticMesh'HU_Deco3.SM.Mesh.S_HU_Deco_SM_FireHydrant01'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTSimpleDestroyable:StaticMeshComponent0'
   End Object
   StaticMeshComponent=StaticMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSimpleDestroyable:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSimpleDestroyable:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Components(0)=MyLightEnvironment
   Components(1)=StaticMeshComponent0
   CollisionComponent=StaticMeshComponent0
   Name="Default__UTSD_FireHydrant"
   ObjectArchetype=UTSimpleDestroyable'UTGame.Default__UTSimpleDestroyable'
}
