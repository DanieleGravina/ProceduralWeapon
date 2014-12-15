/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtFlag_Content extends UTOnslaughtFlag;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.PowerCell.Mesh.S_Pickups_PowerCell_Cell01'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtFlag_Content:OnslaughtFlagLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      CollideActors=False
      BlockRigidBody=False
      Scale=1.350000
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Mesh=StaticMeshComponent0
   FlagMaterials(0)=Material'PICKUPS.PowerCell.Materials.M_Pickups_Orb_Red'
   FlagMaterials(1)=Material'PICKUPS.PowerCell.Materials.M_Pickups_Orb_Blue'
   FlagEffect(0)=ParticleSystem'GP_Onslaught.Effects.P_Orb_Red'
   FlagEffect(1)=ParticleSystem'GP_Onslaught.Effects.P_Orb_Blue'
   Begin Object Class=ParticleSystemComponent Name=EffectComp ObjName=EffectComp Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Name="EffectComp"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   FlagEffectComp=EffectComp
   LightColors(0)=(B=0,G=64,R=255,A=0)
   LightColors(1)=(B=255,G=128,R=64,A=0)
   GraceDist=5000.000000
   GodBeamClass=Class'UTGameContent.UTOnslaughtGodBeam_Content'
   MaxSpringDistance=15.000000
   ReturnedEffectClasses(0)=Class'UTGameContent.UTEmit_OnslaughtOrbExplosion_Red'
   ReturnedEffectClasses(1)=Class'UTGameContent.UTEmit_OnslaughtOrbExplosion_Blue'
   NormalOrbScale=1.350000
   HomeOrbScale=1.000000
   HoverboardOrbScale=0.900000
   Prebuildtime=0.025000
   BuildTime=5.500000
   EnemyReturnPrebuildTime=5.000000
   bHome=True
   MaxDropTime=15.000000
   MapSize=0.750000
   IconCoords=(U=843.000000,V=0.000000,UL=50.000000,VL=48.000000)
   GameObjOffset3P=(X=-35.000000,Y=30.000000,Z=25.000000)
   GameObjOffset1P=(X=-35.000000,Y=30.000000,Z=25.000000)
   PickupSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_OrbPickedUp'
   DroppedSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_OrbDropped'
   ReturnedSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_OrbDischarged'
   Begin Object Class=PointLightComponent Name=FlagLightComponent ObjName=FlagLightComponent Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=250.000000
      Brightness=5.000000
      LightColor=(B=64,G=255,R=255,A=0)
      Name="FlagLightComponent"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   FlagLight=FlagLightComponent
   NeedToPickUpAnnouncements(0)=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabYourOrb',AnnouncementText="Prendi la Sfera Rossa!")
   NeedToPickUpAnnouncements(1)=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabYourOrb',AnnouncementText="Prendi la Sfera Blu!")
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtFlag:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtFlag:CollisionCylinder'
   End Object
   Components(0)=CollisionCylinder
   Components(1)=FlagLightComponent
   Begin Object Class=DynamicLightEnvironmentComponent Name=OnslaughtFlagLightEnvironment ObjName=OnslaughtFlagLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="OnslaughtFlagLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(2)=OnslaughtFlagLightEnvironment
   Components(3)=StaticMeshComponent0
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_OrbAmbient'
      bAutoPlay=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(4)=AmbientSoundComponent
   Components(5)=EffectComp
   bHardAttach=True
   bCollideActors=True
   NetPriority=3.000000
   CollisionComponent=CollisionCylinder
   RotationRate=(Pitch=12000,Yaw=14000,Roll=10000)
   MessageClass=Class'UTGameContent.UTOnslaughtOrbMessage'
   Name="Default__UTOnslaughtFlag_Content"
   ObjectArchetype=UTOnslaughtFlag'UTGame.Default__UTOnslaughtFlag'
}
