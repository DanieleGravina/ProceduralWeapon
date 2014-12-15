/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTSlowField_Content extends UTSlowField;

defaultproperties
{
   SlowFieldAmbientSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_PowerLoopCue'
   WarningSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_WarningCue'
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS_2.Deployables.Mesh.S_Deployables_XrayVolume_Cylinder'
      Materials(0)=Material'PICKUPS_2.Deployables.Materials.M_Deployables_SlowVolume_Cube_UT3G'
      bUseAsOccluder=False
      CastShadow=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-175.000000)
      Scale3D=(X=0.100000,Y=0.100000,Z=0.100000)
      AbsoluteRotation=True
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   SlowFieldMesh=StaticMeshComponent0
   PowerupOverSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_EndCue'
   IconCoords=(U=792.000000,V=41.000000,UL=43.000000,VL=58.000000)
   bRenderOverlays=True
   PickupMessage="CAMPO LENTO!"
   PickupSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_PickupCue'
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.UDamage.Mesh.S_Pickups_UDamage'
      Materials(0)=None
      Materials(1)=Material'PICKUPS_2.StasisField.Materials.M_Pickups2_StasisField'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Rotation=(Pitch=0,Yaw=0,Roll=-32768)
      Scale3D=(X=0.350000,Y=0.350000,Z=0.600000)
      Name="MeshComponentA"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=MeshComponentA
   PickupFactoryMesh=MeshComponentA
   Begin Object Class=UTParticleSystemComponent Name=PickupParticles ObjName=PickupParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS_2.Deployables.Effects.P_Pickups_SlowField_Idle'
      bAutoActivate=False
      Rotation=(Pitch=0,Yaw=0,Roll=-32768)
      Name="PickupParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DroppedPickupParticles=PickupParticles
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTSlowField:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTSlowField:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTSlowField:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTSlowField:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Name="Default__UTSlowField_Content"
   ObjectArchetype=UTSlowField'UTGame.Default__UTSlowField'
}
