/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_Redeemer_Content extends UTWeap_Redeemer;

simulated function PreloadTextures(bool bForcePreload)
{
	local array<Texture> Textures;
	local Texture2D CurrentTexture;
	local int i, j;

	Super.PreloadTextures(bForcePreload);

	if (WarheadClass != None)
	{
		for (i = 0; i < WarheadClass.default.TeamCameraMaterials.length; i++)
		{
			if (WarheadClass.default.TeamCameraMaterials[i] != None)
			{
				Textures = WarheadClass.default.TeamCameraMaterials[i].GetMaterial().GetTextures();
				for (j = 0; j < Textures.Length; j++)
				{
					CurrentTexture = Texture2D(Textures[j]);
					if (CurrentTexture != None)
					{
						CurrentTexture.bForceMiplevelsToBeResident = bForcePreload;
					}
				}
			}
		}
	}
}

defaultproperties
{
   WarHeadClass=Class'UTGameContent.UTRemoteRedeemer_Content'
   FlickerParamName="Redeemer_Power"
   RedRedeemerClass=Class'UTGameContent.UTProj_RedeemerRed'
   bSuperWeapon=True
   bNeverForwardPendingFire=True
   bSplashJump=True
   bRecommendSplashDamage=True
   bHasLocationSpeech=True
   AmmoCount=1
   LockerAmmoCount=1
   IconCoordinates=(U=453.000000,V=384.000000,UL=147.000000,VL=82.000000)
   CrossHairCoordinates=(U=320.000000)
   InventoryGroup=10
   AttachmentClass=Class'UTGameContent.UTAttachment_Redeemer'
   PivotTranslation=(X=0.000000,Y=0.000000,Z=0.000000)
   GroupWeight=0.500000
   ArmsAnimSet=AnimSet'WP_Redeemer.Anims.K_WP_Redeemer_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_FireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_FireCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_Lower01Cue'
   WeaponEquipSnd=SoundCue'A_Weapon_Redeemer.Redeemer.A_Weapon_Redeemer_Raise01Cue'
   WeaponColor=(B=0,G=0,R=255,A=255)
   MuzzleFlashPSCTemplate=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_MF'
   MuzzleFlashColor=(B=64,G=64,R=200,A=255)
   CurrentRating=1.500000
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheRedeemer')
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheRedeemer'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheRedeemer'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheRedeemer'
   ShouldFireOnRelease(1)=1
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_Redeemer'
   WeaponProjectiles(1)=Class'UTGameContent.UTProj_Redeemer'
   FireInterval(0)=0.900000
   FireInterval(1)=0.950000
   EquipTime=2.000000
   PutDownTime=1.600000
   FireOffset=(X=15.000000,Y=5.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Redeemer:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'WP_Redeemer.Mesh.SK_WP_Redeemer_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTWeap_Redeemer_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Redeemer.Anims.K_WP_Redeemer_1P_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Redeemer:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   AIRating=1.500000
   bDelayedSpawn=True
   RespawnTime=120.000000
   MaxDesireability=1.500000
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Redeemer_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Redeemer:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_Redeemer.Mesh.SK_WP_Redeemer_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Redeemer:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_Redeemer_Content"
   ObjectArchetype=UTWeap_Redeemer'UTGame.Default__UTWeap_Redeemer'
}
