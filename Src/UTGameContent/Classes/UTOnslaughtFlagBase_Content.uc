/**
 * UTOnslaughtFlagBase.
 *
 * Onslaught levels with may have a UTOnslaughtFlagBase to spawn an orb for that team
 * they may also have additional flag bases placed near nodes that the orb will return to instead if it is closer
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtFlagBase_Content extends UTOnslaughtFlagBase;

var() CylinderComponent	CylinderComp;
var() CylinderComponent	CylinderComp2;

defaultproperties
{
   Begin Object Class=CylinderComponent Name=MyCylinder ObjName=MyCylinder Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=78.000000
      CollisionRadius=60.000000
      CollideActors=True
      BlockActors=True
      BlockZeroExtent=False
      Translation=(X=99.000000,Y=0.000000,Z=0.000000)
      Name="MyCylinder"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   CylinderComp=MyCylinder
   Begin Object Class=CylinderComponent Name=MyCylinder2 ObjName=MyCylinder2 Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=10.000000
      CollisionRadius=37.000000
      CollideActors=True
      BlockActors=True
      BlockZeroExtent=False
      Translation=(X=52.000000,Y=0.000000,Z=85.000000)
      Name="MyCylinder2"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   CylinderComp2=MyCylinder2
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.PowerCellDispenser.Mesh.SK_Pickups_Orb_Dispenser-Optimized'
      AnimTreeTemplate=AnimTree'PICKUPS.PowerCellDispenser.Anims.AT_Pickups_PowerCellDispenser'
      PhysicsAsset=PhysicsAsset'PICKUPS.PowerCellDispenser.Mesh.SK_Pickups_Orb_Dispenser-Optimized_Physics'
      AnimSets(0)=AnimSet'PICKUPS.PowerCellDispenser.Anims.Anim_Orb_Dispenser'
      bForceRefpose=1
      bUpdateSkelWhenNotRendered=False
      bHasPhysicsAssetInstance=True
      bCacheAnimSequenceNodes=False
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtFlagBase_Content:OnslaughtFlagBaseLightEnvironment'
      bUseAsOccluder=False
      bCastDynamicShadow=False
      CollideActors=True
      BlockActors=True
      BlockZeroExtent=True
      BlockNonZeroExtent=True
      BlockRigidBody=True
      Translation=(X=0.000000,Y=0.000000,Z=-64.000000)
      Name="SkeletalMeshComponent0"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=SkeletalMeshComponent0
   bEnabled=True
   Begin Object Class=ParticleSystemComponent Name=PSC ObjName=PSC Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Translation=(X=0.000000,Y=0.000000,Z=-60.000000)
      Name="PSC"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   BallEffect=PSC
   TeamEmitters(0)=ParticleSystem'PICKUPS.PowerCellDispenser.Effects.P_CellDispenser_Idle_Red'
   TeamEmitters(1)=ParticleSystem'PICKUPS.PowerCellDispenser.Effects.P_CellDispenser_Idle_Blue'
   TeamEmitters(2)=ParticleSystem'PICKUPS.PowerCellDispenser.Effects.P_CellDispenser_Idle_Neutral'
   BaseMaterials(0)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb_Dispenser_Red'
   BaseMaterials(1)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb_Dispenser_Blue'
   BaseMaterials(2)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb_Dispenser'
   BallMaterials(0)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb_Red'
   BallMaterials(1)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb_Blue'
   BallMaterials(2)=Material'PICKUPS.PowerCellDispenser.Materials.M_Pickups_Orb'
   CreateSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_OrbCreated'
   FlagClass=Class'UTGameContent.UTOnslaughtFlag_Content'
   bBlockedForVehicles=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtFlagBase:CollisionCylinder'
      CollisionHeight=60.000000
      CollisionRadius=48.000000
      BlockZeroExtent=False
      BlockNonZeroExtent=False
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtFlagBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   GoodSprite=None
   BadSprite=None
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtFlagBase:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtFlagBase:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtFlagBase:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtFlagBase:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Components(3)=PSC
   Begin Object Class=DynamicLightEnvironmentComponent Name=OnslaughtFlagBaseLightEnvironment ObjName=OnslaughtFlagBaseLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="OnslaughtFlagBaseLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(4)=OnslaughtFlagBaseLightEnvironment
   Components(5)=SkeletalMeshComponent0
   Components(6)=MyCylinder
   Components(7)=MyCylinder2
   bBlocksTeleport=True
   CollisionComponent=SkeletalMeshComponent0
   Name="Default__UTOnslaughtFlagBase_Content"
   ObjectArchetype=UTOnslaughtFlagBase'UTGame.Default__UTOnslaughtFlagBase'
}
