/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_MantaGun extends UTVehicleWeapon
	HideDropDown;

function float SuggestAttackStyle()
{
	local UTBot B;
	
	B = UTBot(Instigator.Controller);
	if ( (Pawn(Instigator.Controller.Focus) == None) || (B == None) || (B.Skill < 3) )
	{
		return -0.2;
	}
	
	return 0.2;
}

defaultproperties
{
   FireTriggerTags(0)="MantaWeapon01"
   FireTriggerTags(1)="MantaWeapon02"
   VehicleClass=Class'UTGameContent.UTVehicle_Manta_Content'
   bFastRepeater=True
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Fire'
   aimerror=750.000000
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_None
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_MantaBolt'
   FireInterval(0)=0.200000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Manta"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_MantaGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
