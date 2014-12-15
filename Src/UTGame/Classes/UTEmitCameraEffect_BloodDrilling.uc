/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTEmitCameraEffect_BloodDrilling extends UTEmitCameraEffect;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmitCameraEffect:ParticleSystemComponent0'
      Template=ParticleSystem'CameraBlood.FX.P_SpiderMine_FaceDrilling_Blood'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmitCameraEffect:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTEmitCameraEffect:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTEmitCameraEffect:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=ParticleSystemComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'UTGame.Default__UTEmitCameraEffect:ArrowComponent0'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTEmitCameraEffect:ArrowComponent0'
   End Object
   Components(2)=ArrowComponent0
   Name="Default__UTEmitCameraEffect_BloodDrilling"
   ObjectArchetype=UTEmitCameraEffect'UTGame.Default__UTEmitCameraEffect'
}
