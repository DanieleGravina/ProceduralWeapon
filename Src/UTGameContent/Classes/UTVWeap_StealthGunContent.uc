/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_StealthGunContent extends UTVWeap_NightshadeGun
		HideDropDown;

defaultproperties
{
   DeployableList(0)=(DeployableClass=Class'UTGameContent.UTDeployableSpiderMineTrap',MaxCnt=2,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   DeployableList(1)=(DeployableClass=Class'UTGameContent.UTDeployableSlowVolume',MaxCnt=1,DropOffset=(X=500.000000,Y=200.000000,Z=100.000000))
   DeployableList(2)=(DeployableClass=Class'UTGameContent.UTDeployableEMPMine',MaxCnt=1,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   DeployableList(3)=(DeployableClass=Class'UTGameContent.UTDeployableEnergyShield',MaxCnt=1,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   AltFireModeChangeSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_SwitchDeployables_Cue'
   LinkFlexibility=0.500000
   LinkBreakDelay=0.500000
   IconCoords(0)=(U=930.000000,V=582.000000,UL=94.000000,VL=119.000000)
   IconCoords(1)=(U=890.000000,V=489.000000,UL=103.000000,VL=93.000000)
   IconCoords(2)=(U=774.000000,V=582.000000,UL=156.000000,VL=135.000000)
   IconCoords(3)=(U=890.000000,V=382.000000,UL=94.000000,VL=107.000000)
   DeployedItemSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_DropItem_Cue'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_StealthGunContent"
   ObjectArchetype=UTVWeap_NightshadeGun'UTGame.Default__UTVWeap_NightshadeGun'
}
