/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPaladinShield extends UTVehicleShield;

/** name of particle system variable for paladin shield strength*/
var name ShieldStrengthParam;

event BaseChange()
{
	local UTVehicle_Paladin Paladin;

	if (ShieldEffectComponent != None && !ShieldEffectComponent.bAttached)
	{
		Paladin = UTVehicle_Paladin(Base);
		if (Paladin != None)
		{
			Paladin.Mesh.AttachComponentToSocket(ShieldEffectComponent, 'ShieldGen');
		}
		else
		{
			AttachComponent(ShieldEffectComponent);
		}
	}
}

event Destroyed()
{
	local UTVehicle_Paladin Paladin;

	Super.Destroyed();

	if (ShieldEffectComponent != None && ShieldEffectComponent.bAttached)
	{
		Paladin = UTVehicle_Paladin(Base);
		if (Paladin != None)
		{
			Paladin.Mesh.DetachComponent(ShieldEffectComponent);
		}
	}
}

defaultproperties
{
   ShieldStrengthParam="ShieldAlpha"
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
      Template=ParticleSystem'VH_Paladin.Effects.P_VH_Paladin_ShieldEffect'
      bAutoActivate=False
      HiddenGame=True
      Translation=(X=-50.000000,Y=0.000000,Z=-20.000000)
      Name="ShieldEffect"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ShieldEffectComponent=ShieldEffect
   Components(0)=AmbientSoundComponent
   Begin Object Class=StaticMeshComponent Name=ShieldMesh ObjName=ShieldMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'VH_Paladin.Mesh.S_VH_Paladin_Shield_New'
      HiddenGame=True
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      BlockRigidBody=False
      Translation=(X=400.000000,Y=0.000000,Z=140.000000)
      Scale=2.200000
      Name="ShieldMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(1)=ShieldMesh
   CollisionComponent=ShieldMesh
   Name="Default__UTPaladinShield"
   ObjectArchetype=UTVehicleShield'UTGame.Default__UTVehicleShield'
}
