/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTAttachment_Translocator extends UTWeaponAttachment;

var MaterialInterface TeamSkins[2];

simulated function SetSkin(Material NewMaterial)
{
	local int TeamIndex;

	if ( NewMaterial == None ) 	// Clear the materials
	{
		TeamIndex = Instigator.GetTeamNum();
		if ( TeamIndex == 255 )
			TeamIndex = 0;
		Mesh.SetMaterial(0,TeamSkins[TeamIndex]);
	}
	else
	{
		Super.SetSkin(NewMaterial);
	}
}

simulated function AttachTo(UTPawn OwnerPawn)
{
	Mesh.PlayAnim('WeaponIdle',, true);

	Super.AttachTo(OwnerPawn);
}

defaultproperties
{
   TeamSkins(0)=Material'WP_Translocator.Materials.M_WP_Translocator_1P'
   TeamSkins(1)=Material'WP_Translocator.Materials.M_WP_Translocator_1PBlue'
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_Translocator.Mesh.SK_WP_Translocator_3P_Mid'
      Animations=UTAnimNodeSequence'UTGameContent.Default__UTAttachment_Translocator:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Translocator.Anims.K_WP_Translocator_3P_Base'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   WeaponClass=Class'UTGameContent.UTWeap_Translocator_Content'
   WeapAnimType=EWAT_Pistol
   Name="Default__UTAttachment_Translocator"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
