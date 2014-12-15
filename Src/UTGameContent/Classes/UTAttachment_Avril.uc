/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_Avril extends UTWeaponAttachment;

/** component for the laser effect */
var ParticleSystemComponent LaserEffect;

simulated function AttachTo(UTPawn OwnerPawn)
{
	if (LaserEffect != None)
	{
		Mesh.AttachComponentToSocket(LaserEffect, 'MuzzleFlashSocket');
	}

	Super.AttachTo(OwnerPawn);
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	if (IsZero(HitLocation))
	{
		// fired rocket
		Mesh.PlayAnim('WeaponReload', (WeaponClass != None) ? WeaponClass.default.FireInterval[0] : 0.0);
		Super.ThirdPersonFireEffects(HitLocation);
	}
	else
	{
		// firing targeting laser
		LaserEffect.SetActive(true);
		LaserEffect.SetVectorParameter('BeamEnd', HitLocation);
	}
}

simulated function StopThirdPersonFireEffects()
{
	Super.StopThirdPersonFireEffects();

	if (Instigator == None || IsZero(Instigator.FlashLocation))
	{
		// turned off targeting laser
		LaserEffect.DeactivateSystem();
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=LaserComp ObjName=LaserComp Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_AVRiL.Particles.P_WP_AVRiL_TargetBeam'
      bAutoActivate=False
      bUpdateComponentInTick=True
      TickGroup=TG_PostAsyncWork
      Name="LaserComp"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LaserEffect=LaserComp
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_AVRiL.Mesh.SK_WP_Avril_3P_Mid'
      Animations=UTAnimNodeSequence'UTGameContent.Default__UTAttachment_Avril:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_AVRiL.Anims.K_WP_Avril_3P_Base'
      CullDistance=5000.000000
      Translation=(X=0.000000,Y=1.000000,Z=1.000000)
      Rotation=(Pitch=0,Yaw=0,Roll=-599)
      Scale=1.100000
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   WeaponClass=Class'UTGameContent.UTWeap_Avril_Content'
   WeapAnimType=EWAT_Stinger
   Name="Default__UTAttachment_Avril"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
