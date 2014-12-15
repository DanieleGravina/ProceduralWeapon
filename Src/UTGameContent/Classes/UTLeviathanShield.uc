/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTLeviathanShield extends UTVehicleShield;

simulated event BaseChange();

defaultproperties
{
   ActivatedSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ShieldActivate'
   DeactivatedSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ShieldOff'
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ShieldAmbient'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AmbientComponent=AmbientSoundComponent
   Begin Object Class=UTParticleSystemComponent Name=ShieldEffect ObjName=ShieldEffect Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_ShieldEffect'
      bAutoActivate=False
      HiddenGame=True
      Translation=(X=15.000000,Y=50.000000,Z=25.000000)
      Name="ShieldEffect"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ShieldEffectComponent=ShieldEffect
   bIgnoreFlaggedProjectiles=True
   Components(0)=AmbientSoundComponent
   Begin Object Class=StaticMeshComponent Name=ShieldMesh ObjName=ShieldMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'VH_Leviathan.Mesh.S_VH_Leviathan_Shield_Collision'
      HiddenGame=True
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=240.000000,Y=-180.000000,Z=220.000000)
      Name="ShieldMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(1)=ShieldMesh
   CollisionComponent=ShieldMesh
   Name="Default__UTLeviathanShield"
   ObjectArchetype=UTVehicleShield'UTGame.Default__UTVehicleShield'
}
