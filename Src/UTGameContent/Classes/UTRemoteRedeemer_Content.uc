/**
* Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
*/
class UTRemoteRedeemer_Content extends UTRemoteRedeemer
	notplaceable;

defaultproperties
{
   Begin Object Class=UTParticleSystemComponent Name=TrailComponent ObjName=TrailComponent Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      bOwnerNoSee=True
      Name="TrailComponent"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Trail=TrailComponent
   RedeemerProjClass=Class'UTGameContent.UTProj_Redeemer'
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   PawnAmbientSound=AmbientSoundComponent
   CameraEffect=PostProcessChain'UN_LensTypes.RedeemerPostProcess'
   TeamCameraMaterials(0)=MaterialInstanceConstant'UN_LensTypes.Materials.MI_FX_RedeemerCam_Red'
   TeamCameraMaterials(1)=MaterialInstanceConstant'UN_LensTypes.Materials.MI_FX_RedeemerCam_Blue'
   bAttachDriver=False
   DriverDamageMult=1.000000
   bSimulateGravity=False
   bDirectHitWall=True
   bSpecialHUD=True
   bCanUse=False
   AirSpeed=1000.000000
   AccelRate=2000.000000
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   LandMovementState="PlayerFlying"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTRemoteRedeemer:CollisionCylinder'
      CollisionHeight=12.000000
      CollisionRadius=20.000000
      BlockActors=False
      Translation=(X=40.000000,Y=0.000000,Z=0.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTRemoteRedeemer:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=AmbientSoundComponent
   Begin Object Class=StaticMeshComponent Name=WRocketMesh ObjName=WRocketMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'WP_AVRiL.Mesh.S_WP_AVRiL_Missile'
      CullDistance=20000.000000
      CachedCullDistance=20000.000000
      bOwnerNoSee=True
      bUseAsOccluder=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=32.000000,Y=0.000000,Z=0.000000)
      Scale=3.000000
      Name="WRocketMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(2)=WRocketMesh
   Components(3)=TrailComponent
   Physics=PHYS_Flying
   bNetInitialRotation=True
   bCanTeleport=False
   bCollideActors=False
   bBlockActors=False
   NetPriority=3.000000
   CollisionComponent=CollisionCylinder
   Name="Default__UTRemoteRedeemer_Content"
   ObjectArchetype=UTRemoteRedeemer'UTGame.Default__UTRemoteRedeemer'
}
