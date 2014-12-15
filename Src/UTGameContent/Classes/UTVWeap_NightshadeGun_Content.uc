/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_NightshadeGun_Content extends UTVWeap_StealthGunContent
		HideDropDown;

defaultproperties
{
   VehicleHitEffect=(ParticleTemplate=ParticleSystem'VH_Nightshade.Effects.P_VH_Nightshade_Beam_Impact')
   VehicleClass=Class'UTGameContent.UTVehicle_NightShade_Content'
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_NightshadeBeam'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_StealthGunContent:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_StealthGunContent:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_StealthGunContent:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_StealthGunContent:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_NightshadeGun_Content"
   ObjectArchetype=UTVWeap_StealthGunContent'UTGameContent.Default__UTVWeap_StealthGunContent'
}
