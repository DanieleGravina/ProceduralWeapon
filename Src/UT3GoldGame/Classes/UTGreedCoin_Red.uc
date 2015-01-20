/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGreedCoin_Red extends UTGreedCoin;

simulated function PostBeginPlay()
{
	local MaterialInstanceConstant CoinMaterialInstance;

	Super.PostBeginPlay();

	CoinMaterialInstance = StaticMeshComponent(PickupMesh).CreateAndSetMaterialInstanceConstant(0);
	CoinMaterialInstance.SetVectorParameterValue('Skull_Color', SkullColor);
}

defaultproperties
{
   Value=20
   TrailTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_DecoyFlare'
   CoinIconCoords=(U=744.000000,V=0.000000,UL=35.000000,VL=55.000000)
   BounceSound=SoundCue'A_Gameplay_UT3G.Greed.A_Gameplay_UT3G_Greed_SkullImpact01_Cue'
   PickUpWaveForm=ForceFeedbackWaveform'UT3GoldGame.Default__UTGreedCoin_Red:ForceFeedbackWaveformPickUp'
   SkullColor=(R=64.000000,G=4.000000,B=2.000000,A=1.000000)
   MaxDesireability=1.000000
   PickupSound=SoundCue'A_Gameplay_UT3G.Greed.A_Gameplay_UT3G_Greed_SkullPickup01_Cue'
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Extras.Mesh.S_GP_Extras_Skull01'
      Materials(0)=Material'GP_Extras.Materials.M_GP_Extras_Skull01'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockRigidBody=False
      bDisableAllRigidBody=True
      ScriptRigidBodyCollisionThreshold=5.000000
      Name="MeshComponentA"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   PickupMesh=MeshComponentA
   Begin Object Class=DynamicLightEnvironmentComponent Name=DroppedPickupLightEnvironment ObjName=DroppedPickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGreedCoin:DroppedPickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGreedCoin:DroppedPickupLightEnvironment'
   End Object
   MyLightEnvironment=DroppedPickupLightEnvironment
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTGreedCoin:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTGreedCoin:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTGreedCoin:CollisionCylinder'
      CollisionHeight=35.000000
      CollisionRadius=100.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTGreedCoin:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Components(2)=DroppedPickupLightEnvironment
   Components(3)=MeshComponentA
   LifeSpan=240.000000
   DrawScale=7.500000
   CollisionComponent=CollisionCylinder
   Name="Default__UTGreedCoin_Red"
   ObjectArchetype=UTGreedCoin'UTGame.Default__UTGreedCoin'
}