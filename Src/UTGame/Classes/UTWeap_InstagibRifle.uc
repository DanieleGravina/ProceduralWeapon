/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_InstagibRifle extends UTWeapon
	HideDropDown;

var array<MaterialInterface> TeamSkins;
var array<ParticleSystem> TeamMuzzleFlashes;

var bool bBetrayalMode;

//-----------------------------------------------------------------
// AI Interface

function float GetAIRating()
{
	return AIRating;
}

function float RangedAttackTime()
{
	return 0;
}

simulated function SetSkin(Material NewMaterial)
{
	local int TeamIndex;

	if ( NewMaterial == None ) 	// Clear the materials
	{
		if ( Instigator != None )
		{
			TeamIndex = Instigator.GetTeamNum();
		}
		if (TeamIndex > TeamSkins.length)
		{
			TeamIndex = 0;
		}
		Mesh.SetMaterial(0,TeamSkins[TeamIndex]);
	}
	else
	{
		Super.SetSkin(NewMaterial);
	}
}

simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional name SocketName)
{
	local int TeamIndex;

	TeamIndex = Instigator.GetTeamNum();
	if (TeamIndex > TeamMuzzleFlashes.length)
	{
		TeamIndex = 0;
	}
	MuzzleFlashPSCTemplate = TeamMuzzleFlashes[TeamIndex];

	Super.AttachWeaponTo(MeshCpnt, SocketName);
}

simulated function ProcessInstantHit( byte FiringMode, ImpactInfo Impact )
{
	local Pawn HitPawn;
	local UTBetrayalPRI HitPRI, InstigatorPRI;

	if ( bBetrayalMode && (Instigator != None) && (Role == ROLE_Authority) )
	{
		InstigatorPRI = UTBetrayalPRI(Instigator.PlayerReplicationInfo);
		if ( InstigatorPRI != None )
		{
			HitPawn = Pawn(Impact.HitActor);
			if ( HitPawn != None )
			{
				HitPRI = UTBetrayalPRI(HitPawn.PlayerReplicationInfo);
				if ( HitPRI != None )
				{
					if ( WorldInfo.GRI.OnSameTeam(InstigatorPRI, HitPRI) )
					{
						if ( FiringMode == 1 )
						{
							if ( UTGame(WorldInfo.Game) != None )
							{
								UTGame(WorldInfo.Game).ShotTeammate(InstigatorPRI, HitPRI, Instigator, HitPawn);
							}
							super.ProcessInstantHit(0, Impact);
						}
					}
					else if ( FiringMode == 0 )
					{
						super.ProcessInstantHit(0, Impact);
					}
				}
				return;
			}
			else
			{
				// bots don't like being shot at by teammates
				if ( (PlayerController(Instigator.Controller) != None) 
					&& (Instigator.Controller.ShotTarget != None)
					&& (UTBot(Instigator.Controller.ShotTarget.Controller) != None)
					&& WorldInfo.GRI.OnSameTeam(Instigator, Instigator.Controller.ShotTarget) 
					&& (UTBetrayalPRI(Instigator.PlayerReplicationInfo).CurrentTeam.TeamPot >= Min(6, WorldInfo.Game.GoalScore - Max(Instigator.PlayerReplicationInfo.Score, Instigator.Controller.ShotTarget.PlayerReplicationInfo.Score))) )
				{
					//`log(Instigator.Controller.ShotTarget.Controller.PlayerReplicationInfo.PlayerName$" betray shooter");
					UTBot(Instigator.Controller.ShotTarget.Controller).bBetrayTeam = true;
				}
			}
		}
	}
	super.ProcessInstantHit(FiringMode, Impact);
}

function byte BestMode()
{
	// if ( WorldInfo.GRI.OnSameTeam(Instigator.Controller.Enemy, Instigator) && !UTBot(Instigator.Controller).bBetrayTeam ) `log("Shooting teammate without betrayal");
	return WorldInfo.GRI.OnSameTeam(Instigator.Controller.Enemy, Instigator) ? 1 : 0;
}

defaultproperties
{
   TeamSkins(0)=Material'WP_ShockRifle.Materials.M_WP_ShockRifle_Instagib_Red'
   TeamSkins(1)=Material'WP_ShockRifle.Materials.M_WP_ShockRifle_Instagib_Blue'
   TeamMuzzleFlashes(0)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_MF_Red'
   TeamMuzzleFlashes(1)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_MF_Blue'
   bExportMenuData=False
   bSniping=True
   bTargetFrictionEnabled=True
   bTargetAdhesionEnabled=True
   ShotCost(0)=0
   ShotCost(1)=0
   IconX=400
   IconY=129
   IconWidth=22
   IconHeight=48
   IconCoordinates=(U=722.000000,V=479.000000,UL=166.000000,VL=42.000000)
   CrossHairCoordinates=(U=256.000000,V=0.000000)
   InventoryGroup=12
   AmmoDisplayType=EAWDS_None
   AttachmentClass=Class'UTGame.UTAttachment_InstagibRifle'
   GroupWeight=0.500000
   WeaponFireAnim(0)="WeaponFireInstiGib"
   WeaponFireAnim(1)="WeaponFireInstiGib"
   WeaponFireSnd(0)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_InstagibFireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_InstagibFireCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_LowerCue'
   WeaponEquipSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_RaiseCue'
   WeaponColor=(B=255,G=0,R=160,A=255)
   MuzzleFlashSocket="MF"
   PlayerViewOffset=(X=17.000000,Y=10.000000,Z=-8.000000)
   CurrentRating=1.000000
   FireInterval(0)=1.100000
   FireInterval(1)=1.100000
   InstantHitDamage(0)=1000.000000
   InstantHitDamage(1)=1000.000000
   InstantHitMomentum(0)=100000.000000
   InstantHitDamageTypes(0)=Class'UTGame.UTDmgType_Instagib'
   InstantHitDamageTypes(1)=Class'UTGame.UTDmgType_Instagib'
   FireOffset=(X=20.000000,Y=5.000000,Z=0.000000)
   bCanThrow=False
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTWeap_InstagibRifle:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
      Rotation=(Pitch=0,Yaw=-16384,Roll=0)
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Priority=4.300000
   AIRating=1.000000
   ItemName="Fucile Instagib"
   PickupMessage="Fucile Instagib"
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Shock_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_InstagibRifle"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
