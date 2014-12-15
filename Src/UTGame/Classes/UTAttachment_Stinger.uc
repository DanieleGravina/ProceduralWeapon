/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_Stinger extends UTWeaponAttachment
	dependson(UTEmitter);

var ParticleSystemComponent Tracer;

var array<DistanceBasedParticleTemplate> PrimaryImpactTemplates;

simulated function SpawnTracer(vector EffectLocation,vector HitLocation)
{
	if (UTPawn(Owner).FiringMode == 0)
	{
		Tracer.SetTranslation(EffectLocation);
		Tracer.SetVectorParameter('LinkBeamEnd', HitLocation);
		Tracer.SetRotation(rotator(HitLocation - EffectLocation));
		Tracer.ActivateSystem();
	}
}

simulated function FirstPersonFireEffects(Weapon PawnWeapon, vector HitLocation)
{
	super.FirstPersonFireEffects(PawnWeapon, HitLocation);
	SpawnTracer(UTWeapon(PawnWeapon).GetEffectLocation(),HitLocation);
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	Super.ThirdPersonFireEffects(HitLocation);
	SpawnTracer(GetEffectLocation(), HitLocation);
}

simulated function StopThirdPersonFireEffects()
{
	Super.StopThirdPersonFireEffects();

	Tracer.DeactivateSystem();
}

simulated function PlayImpactEffects(vector HitLocation)
{
	DefaultImpactEffect.ParticleTemplate = class'UTEmitter'.static.GetTemplateForDistance(PrimaryImpactTemplates, HitLocation, WorldInfo);

	Super.PlayImpactEffects(HitLocation);
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=TracerComp ObjName=TracerComp Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_Stinger.Particles.P_WP_Stinger_tracer_constant'
      bAutoActivate=False
      AbsoluteTranslation=True
      AbsoluteRotation=True
      Name="TracerComp"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   Tracer=TracerComp
   PrimaryImpactTemplates(0)=(Template=ParticleSystem'WP_Stinger.Particles.P_WP_Stinger_Surface_Impact_Far',MinDistance=2250.000000)
   PrimaryImpactTemplates(1)=(Template=ParticleSystem'WP_Stinger.Particles.P_WP_Stinger_Surface_Impact_Mid',MinDistance=600.000000)
   PrimaryImpactTemplates(2)=(Template=ParticleSystem'WP_Stinger.Particles.P_WP_Stinger_Surface_Impact_Near')
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_Stinger.Mesh.SK_WP_Stinger_3P_Mid'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_Stinger:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Stinger.Anims.K_WP_Stinger_3P_Base'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MF"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_Stinger.Particles.P_Stinger_3P_MF_Primary'
   MuzzleFlashAltPSCTemplate=ParticleSystem'WP_Stinger.Particles.P_Stinger_3P_MF_Alt_Fire'
   bMakeSplash=True
   MuzzleFlashLightClass=Class'UTGame.UTStingerMuzzleFlashLight'
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_FireImpactCue')
   BulletWhip=SoundCue'A_Weapon.Enforcers.Cue.A_Weapon_Enforcers_BulletWhizz_Cue'
   WeaponClass=Class'UTGame.UTWeap_Stinger'
   WeapAnimType=EWAT_Stinger
   FireAnim="WeaponFire"
   Components(0)=TracerComp
   Name="Default__UTAttachment_Stinger"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
