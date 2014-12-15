/**
 * used by SeqAct_DummyWeaponFire to hold the weapon 
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDummyPawn extends UTPawn;

/** pointer back to the Kismet action that created us */
var UTSeqAct_DummyWeaponFire FireAction;

simulated function PostBeginPlay()
{
	Super(Pawn).PostBeginPlay();

	UTInventoryManager(InvManager).bInfiniteAmmo = true;
}

simulated function WeaponFired( bool bViaReplication, optional vector HitLocation)
{
	// force update LastRenderTime so attachment doesn't cull effects due to its mesh being hidden
	LastRenderTime = WorldInfo.TimeSeconds;

	Super.WeaponFired(bViaReplication, HitLocation);

	FireAction.NotifyDummyFire();
}

simulated function SetPawnAmbientSound(SoundCue NewAmbientSound)
{
	if (!FireAction.bSuppressSounds)
	{
		Super.SetPawnAmbientSound(NewAmbientSound);
	}
}

simulated function SetWeaponAmbientSound(SoundCue NewAmbientSound)
{
	if (!FireAction.bSuppressSounds)
	{
		Super.SetWeaponAmbientSound(NewAmbientSound);
	}
}

simulated function rotator GetAdjustedAimFor(Weapon InWeapon, vector ProjStart)
{
	local rotator BaseRotation;

	if (FireAction.Target != None)
	{
		BaseRotation = rotator(FireAction.Target.Location - ProjStart);
	}
	else
	{
		BaseRotation = Rotation;
	}
	return (BaseRotation + (FireAction.MaxSpread * (1.0 - 2.0 * FRand())));
}

simulated function WeaponAttachmentChanged()
{
	if ((CurrentWeaponAttachment == None || CurrentWeaponAttachment.Class != CurrentWeaponAttachmentClass))
	{
		// Detach/Destroy the current attachment if we have one
		if (CurrentWeaponAttachment!=None)
		{
			CurrentWeaponAttachment.DetachFrom(Mesh);
			CurrentWeaponAttachment.Destroy();
		}

		// Create the new Attachment.
		if (CurrentWeaponAttachmentClass!=None)
		{
			CurrentWeaponAttachment = Spawn(CurrentWeaponAttachmentClass,self);
			CurrentWeaponAttachment.Instigator = self;
		}
		else
			CurrentWeaponAttachment = none;

		// If all is good, attach it to the Pawn's Mesh.
		if (CurrentWeaponAttachment != None)
		{
			CurrentWeaponAttachment.bSuppressSounds = FireAction.bSuppressSounds;
			CurrentWeaponAttachment.AttachTo(self);
			CurrentWeaponAttachment.SetDualWielding(bDualWielding);

			// hide the weapon attachment mesh, but leave effects visible
			CurrentWeaponAttachment.SetHidden(false);
			CurrentWeaponAttachment.Mesh.SetRotation(rot(0, -16384, 0)); // all are weapon attachments are sideways
			CurrentWeaponAttachment.AttachComponent(CurrentWeaponAttachment.Mesh);
			CurrentWeaponAttachment.Mesh.SetHidden(true);
		}
	}
}

simulated function vector GetWeaponStartTraceLocation(optional Weapon CurrentWeapon)
{
	return GetPawnViewLocation();
}

simulated function vector GetPawnViewLocation()
{
	if (CurrentWeaponAttachment != None && CurrentWeaponAttachment.MuzzleFlashPSC != None)
	{
		return CurrentWeaponAttachment.MuzzleFlashPSC.GetPosition();
	}
	else
	{
		return Super.GetPawnViewLocation();
	}
}

simulated event Tick(float DeltaTime)
{
	// move the weapon attachment to the right location each frame
	if (CurrentWeaponAttachment != None && FireAction.Origin != None && FireAction.Target != None)
	{
		CurrentWeaponAttachment.SetLocation(FireAction.Origin.Location);
		CurrentWeaponAttachment.SetRotation(rotator(FireAction.Target.Location - FireAction.Origin.Location));
	}
}

defaultproperties
{
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
      Animations=AnimNodeSequence'UTGame.Default__UTDummyPawn:FirstPersonArms.MeshSequenceA'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms'
   End Object
   ArmsMesh(0)=FirstPersonArms
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonArms2 ObjName=FirstPersonArms2 Archetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms2'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceB ObjName=MeshSequenceB Archetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTDummyPawn:FirstPersonArms2.MeshSequenceB'
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
   Mesh=None
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   RemoteRole=ROLE_None
   bGameRelevant=True
   bCollideActors=False
   CollisionComponent=None
   Name="Default__UTDummyPawn"
   ObjectArchetype=UTPawn'UTGame.Default__UTPawn'
}
