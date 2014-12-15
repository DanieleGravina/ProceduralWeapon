/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_Redeemer extends UTProj_RedeemerBase;

defaultproperties
{
   ExplosionShake=CameraAnim'Camera_FX.WP_Redeemer.C_WP_Redeemer_Shake'
   ExplosionClass=Class'UTGameContent.UTEmit_SmallRedeemerExplosion'
   DistanceExplosionTemplates(0)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Far',MinDistance=2200.000000)
   DistanceExplosionTemplates(1)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Mid',MinDistance=1500.000000)
   DistanceExplosionTemplates(2)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Near')
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'WP_Redeemer.Mesh.S_WP_Redeemer_Missile_Open'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_Redeemer:RedeemerLightEnvironment'
      CullDistance=20000.000000
      CachedCullDistance=20000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      LightingChannels=(BSP=True,Static=True)
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=32.000000,Y=0.000000,Z=0.000000)
      Scale=3.000000
      Name="ProjectileMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   ProjMesh=ProjectileMesh
   AmbientSound=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_FlyLoop01Cue'
   ExplosionSound=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_ExplodeCue'
   ProjFlightTemplate=ParticleSystem'WP_Redeemer.Effects.P_WP_Redeemer_SmokeTrail'
   MyDamageType=Class'UTGameContent.UTDmgType_Redeemer'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_RedeemerBase:CollisionCylinder'
      Translation=(X=40.000000,Y=0.000000,Z=0.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_RedeemerBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=RedeemerLightEnvironment ObjName=RedeemerLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTProj_RedeemerBase:RedeemerLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTProj_RedeemerBase:RedeemerLightEnvironment'
   End Object
   Components(1)=RedeemerLightEnvironment
   Components(2)=ProjectileMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_Redeemer"
   ObjectArchetype=UTProj_RedeemerBase'UTGame.Default__UTProj_RedeemerBase'
}
