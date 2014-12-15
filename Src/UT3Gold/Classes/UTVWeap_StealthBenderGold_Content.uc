/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_StealthBenderGold_Content extends UTVWeap_NightshadeGun
		HideDropDown;


function byte BestMode()
{
	local UTBot B;
	local int SelectedDeployable;
	local UTGameObjective O;

//0 spider
//1 xray
//2 emp
//3 link
	SelectedDeployable = (FRand() < 0.5) ? 0 : 2;
	B = UTBot(Instigator.Controller);
	if ( B != None )
	{
		if ( (B.Squad.SquadObjective != None) && (FRand() < 0.5) )
		{
			if ( B.IsDefending() )
			{
				SelectedDeployable = (FRand() < 0.5) ? 1 : 3;
			}
			else
			{
				// consider dropping a deployable if near a relevant objective
				foreach WorldInfo.RadiusNavigationPoints(class'UTGameObjective', O, Location, 1500.0)
				{
					SelectedDeployable = (FRand() < 0.5) ? 1 : 3;
					if ( O.IsActive() && WorldInfo.GRI.OnSameTeam(B,O) && FastTrace(O.Location, Location) )
					{
						SelectedDeployable = (FRand() < 0.5) ? 1 : 3;
						break;
					}
				}
			}
		}
	}
	if ( !SelectWeapon(SelectedDeployable) )
	{
		if ( !SelectWeapon(0) )
			if ( !SelectWeapon(2) )
				if ( !SelectWeapon(1) )
					SelectWeapon(3);
	}

	return 0;
}

defaultproperties
{
   DeployableList(0)=(DeployableClass=Class'UTGameContent.UTDeployableSpiderMineTrap',MaxCnt=2,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   DeployableList(1)=(DeployableClass=Class'UT3Gold.UTDeployableXRayVolume',MaxCnt=1,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   DeployableList(2)=(DeployableClass=Class'UTGameContent.UTDeployableEMPMine',MaxCnt=1,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   DeployableList(3)=(DeployableClass=Class'UT3Gold.UTDeployableLinkGenerator',MaxCnt=1,DropOffset=(X=30.000000,Y=0.000000,Z=0.000000))
   AltFireModeChangeSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_SwitchDeployables_Cue'
   LinkFlexibility=0.500000
   LinkBreakDelay=0.500000
   IconCoords(0)=(U=930.000000,V=582.000000,UL=94.000000,VL=119.000000)
   IconCoords(1)=(U=5.000000,V=147.000000,UL=97.000000,VL=94.000000)
   IconCoords(2)=(U=774.000000,V=582.000000,UL=156.000000,VL=135.000000)
   IconCoords(3)=(U=5.000000,V=241.000000,UL=97.000000,VL=139.000000)
   DeployedItemSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_DropItem_Cue'
   VehicleHitEffect=(ParticleTemplate=ParticleSystem'VH_StealthBender.Effects.P_VH_StealthBender_Beam_Impact')
   VehicleClass=Class'UT3Gold.UTVehicle_StealthbenderGold_Content'
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_StealthbenderBeam'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="StealthBender"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_NightshadeGun:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_StealthBenderGold_Content"
   ObjectArchetype=UTVWeap_NightshadeGun'UTGame.Default__UTVWeap_NightshadeGun'
}
