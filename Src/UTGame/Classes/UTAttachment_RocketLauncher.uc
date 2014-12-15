/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_RocketLauncher extends UTWeaponAttachment;

/** list of anims to play for loading the RL */
var array<name> LoadUpAnimList;

simulated function FireModeUpdated(byte FiringMode, bool bViaReplication)
{
	if (FiringMode == 1 && Instigator.FlashCount == 0)
	{
		UTAnimNodeSequence(Mesh.Animations).PlayAnimationSet(LoadUpAnimList, 0.5, false);
	}
	else
	{
		Mesh.StopAnim();
	}
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	Super.ThirdPersonFireEffects(HitLocation);

	Mesh.StopAnim();
}

/** 
*   Optimized equivalent of calling ThirdPersonFireEffects while in splitscreen
*/
simulated function SplitScreenEffects(vector HitLocation)
{
	Super.SplitScreenEffects(HitLocation);

	//Mesh.StopAnim();
}

simulated function FirstPersonFireEffects(Weapon PawnWeapon, vector HitLocation)
{
	Super.FirstPersonFireEffects(PawnWeapon, HitLocation);

	Mesh.StopAnim();
}

defaultproperties
{
   LoadUpAnimList(0)="WeaponAltFireQueue1"
   LoadUpAnimList(1)="WeaponAltFireQueue2"
   LoadUpAnimList(2)="WeaponAltFireQueue3"
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_3P'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_RocketLauncher:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_RocketLauncher.Anims.K_WP_RocketLauncher_3P'
      Translation=(X=1.000000,Y=-1.000000,Z=0.000000)
      Rotation=(Pitch=0,Yaw=0,Roll=1000)
      Scale=1.100000
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RockerLauncher_3P_Muzzle_Flash'
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   WeaponClass=Class'UTGame.UTWeap_RocketLauncher'
   FireAnim="WeaponFire"
   Name="Default__UTAttachment_RocketLauncher"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
