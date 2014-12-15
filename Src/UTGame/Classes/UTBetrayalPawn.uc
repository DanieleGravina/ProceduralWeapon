/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTBetrayalPawn extends UTPawn
	config(Game)
	native
	notplaceable;

var bool bTeamInvitation;

var int Count;

var SoundCue TeamInvitationSound, EndTeamSound;

/** cue used for TeamInvitations */
var soundcue AnnouncerSoundCue;	

/** currently playing TeamInvitation AudioComponent */
var AudioComponent CurrentAnnouncementComponent;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated native function byte GetTeamNum();

/**
 * Called when a pawn's weapon has fired and is responsibile for
 * delegating the creation off all of the different effects.
 *
 * bViaReplication denotes if this call in as the result of the
 * flashcount/flashlocation being replicated.  It's used filter out
 * when to make the effects.
 */
simulated function WeaponFired( bool bViaReplication, optional vector HitLocation)
{
	if (CurrentWeaponAttachment != None)
	{
		bTeamInvitation = (FiringMode == 1);

		if ( !IsFirstPerson() )
		{
			CurrentWeaponAttachment.ThirdPersonFireEffects(HitLocation);
		}
		else
		{
			CurrentWeaponAttachment.FirstPersonFireEffects(Weapon, HitLocation);
			if ( class'Engine'.static.IsSplitScreen() && CurrentWeaponAttachment.EffectIsRelevant(CurrentWeaponAttachment.Location,false,CurrentWeaponAttachment.MaxFireEffectDistance) )
			{
				// third person muzzle flash
				CurrentWeaponAttachment.CauseMuzzleFlash();
			}
		}

		if ( HitLocation != Vect(0,0,0) && (WorldInfo.NetMode == NM_ListenServer || WorldInfo.NetMode == NM_Standalone || bViaReplication) )
		{
			CurrentWeaponAttachment.PlayImpactEffects(HitLocation);
		}
		bTeamInvitation = false;
	}
}

defaultproperties
{
   AnnouncerSoundCue=SoundCue'A_Announcer_Reward_Cue.SoundCues.AnnouncerCue'
   bPostRenderOtherTeam=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Begin Object Class=ParticleSystemComponent Name=GooDeath ObjName=GooDeath Archetype=ParticleSystemComponent'UTGame.Default__UTPawn:GooDeath'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTPawn:GooDeath'
   End Object
   BioBurnAway=GooDeath
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeathVisionLightEnv ObjName=DeathVisionLightEnv Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:DeathVisionLightEnv'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:DeathVisionLightEnv'
   End Object
   FirstPersonDeathVisionLightEnvironment=DeathVisionLightEnv
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonArms ObjName=FirstPersonArms Archetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceA'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceA'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTBetrayalPawn:FirstPersonArms.MeshSequenceA'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms'
   End Object
   ArmsMesh(0)=FirstPersonArms
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonArms2 ObjName=FirstPersonArms2 Archetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms2'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceB ObjName=MeshSequenceB Archetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTBetrayalPawn:FirstPersonArms2.MeshSequenceB'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms2'
   End Object
   ArmsMesh(1)=FirstPersonArms2
   Begin Object Class=UTAmbientSoundComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent'
      ObjectArchetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent'
   End Object
   PawnAmbientSound=AmbientSoundComponent
   Begin Object Class=UTAmbientSoundComponent Name=AmbientSoundComponent2 ObjName=AmbientSoundComponent2 Archetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent2'
      ObjectArchetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent2'
   End Object
   WeaponAmbientSound=AmbientSoundComponent2
   Begin Object Class=SkeletalMeshComponent Name=OverlayMeshComponent0 ObjName=OverlayMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTPawn:OverlayMeshComponent0'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTPawn:OverlayMeshComponent0'
   End Object
   OverlayMesh=OverlayMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=XRayEffectLightEnv ObjName=XRayEffectLightEnv Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:XRayEffectLightEnv'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:XRayEffectLightEnv'
   End Object
   XRayEffectLightEnvironment=XRayEffectLightEnv
   Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent ObjName=WPawnSkeletalMeshComponent Archetype=SkeletalMeshComponent'UTGame.Default__UTPawn:WPawnSkeletalMeshComponent'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTPawn:WPawnSkeletalMeshComponent'
   End Object
   Mesh=WPawnSkeletalMeshComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTPawn:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTPawn:Arrow'
   End Object
   Components(1)=Arrow
   Components(2)=MyLightEnvironment
   Components(3)=WPawnSkeletalMeshComponent
   Components(4)=AmbientSoundComponent
   Components(5)=AmbientSoundComponent2
   CollisionComponent=CollisionCylinder
   Name="Default__UTBetrayalPawn"
   ObjectArchetype=UTPawn'UTGame.Default__UTPawn'
}
