/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_DarkWalker_Content extends UTVehicle_DarkWalker;

/** dynamic light which moves around following primary fire beam impact point */
var UTDarkWalkerBeamLight BeamLight;

var float HornImpulseMag;
var float VehicleHornModifier;
var ParticleSystemComponent DarkwalkerHornEffect;
var repnotify bool bSpeakerReady;
var float SpeakerRadius;
var float SpeakerRechargeTime;
var SoundCue HornAttackSound;


replication
{
	if (!bNetOwner)
		bSpeakerReady;
}

event MantaDuckEffect()
{
	if (bHoldingDuck)
	{
		VehicleEvent('CrushStart');
	}
	else
	{
		VehicleEvent('CrushStop');
	}
}

function DriverLeft()
{
	Super.DriverLeft();

	if (Role == ROLE_Authority && UTVWeap_DarkWalkerTurret(Seats[0].Gun) != none)
	{
		UTVWeap_DarkWalkerTurret(Seats[0].Gun).StopBeamFiring();
	}
}

/** Overloaded so we can attach the muzzle flash light to a custom socket */
simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	Super.CauseMuzzleFlashLight(SeatIndex);

	if ( (SeatIndex == 0) && Seats[SeatIndex].MuzzleFlashLight != none )
	{
		Mesh.DetachComponent(Seats[SeatIndex].MuzzleFlashLight);
		Mesh.AttachComponentToSocket(Seats[SeatIndex].MuzzleFlashLight, 'PrimaryMuzzleFlash');
	}
}

simulated function SpawnImpactEmitter(vector HitLocation, vector HitNormal, const out MaterialImpactEffect ImpactEffect, int SeatIndex)
{
	Super.SpawnImpactEmitter(HitLocation, HitNormal, ImpactEffect, SeatIndex);

	if ( SeatIndex == 0 )
	{
		if (BeamLight == None || BeamLight.bDeleteMe)
		{
			BeamLight = Spawn(class'UTDarkWalkerBeamLight');
			BeamLight.AmbientSound.Play();
		}
		BeamLight.SetLocation(HitLocation + HitNormal*128);
	}
}

simulated function KillBeamEmitter()
{
	Super.KillBeamEmitter();

	if (BeamLight != None)
	{
		BeamLight.Destroy();
	}
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (BeamLight != None)
	{
		BeamLight.Destroy();
	}
}

simulated function SetBeamEmitterHidden(bool bHide)
{
	Super.SetBeamEmitterHidden(bHide);

	if (bHide && BeamLight != None)
	{
		BeamLight.AmbientSound.Stop();
		BeamLight.Destroy();
	}
}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		if (bSpeakerReady)
		{
			PlayHornAttack();
		}
		return true;
	}

	return false;
}

function byte ChooseFireMode()
{
	if (Controller != None && Controller.Enemy != None && bSpeakerReady && VSize2D(Controller.Enemy.Location - Location) <= SpeakerRadius)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

function bool NeedToTurn(vector Targ)
{
	// speaker fire is a radius, so if bot wants to do that, don't need to turn
	return (ChooseFireMode() == 1) ? false : Super.NeedToTurn(Targ);
}

simulated function PlayHornAttack()
{
	local Pawn HitPawn;
	local vector HornImpulse, HitLocation, HitNormal;
	local Pawn BoardPawn;
	local UTVehicle_Scavenger UTScav;
	local UTPawn OldDriver;
	local UTVehicle UTV;

	bSpeakerReady = false;

	if (Trace(HitLocation, HitNormal, Location - vect(0,0,600), Location) != None)
	{
		DarkwalkerHornEffect.SetTranslation(HitLocation - Location);
	}
	else
	{
		HitLocation = Location;
		HitLocation.Z -= 400;
		DarkwalkerHornEffect.SetTranslation(vect(0,0,-400));
	}
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		PlaySound(HornAttackSound, true);
		DarkwalkerHornEffect.ActivateSystem();
	}

	if (Role == ROLE_Authority)
	{
		MakeNoise(1.0);

		foreach OverlappingActors(class 'Pawn', HitPawn, SpeakerRadius, HitLocation)
		{
			if ( (HitPawn.Mesh != None) && !WorldInfo.GRI.OnSameTeam(HitPawn, self))
			{
				// throw him outwards also
				HornImpulse = HitPawn.Location - HitLocation;
				HornImpulse.Z = 0;
				HornImpulse = HornImpulseMag * Normal(HornImpulse);
				HornImpulse.Z = 250.0;

				if (HitPawn.Physics != PHYS_RigidBody && HitPawn.IsA('UTPawn'))
				{
					HitPawn.Velocity += HornImpulse;
					UTPawn(HitPawn).ForceRagdoll();
					UTPawn(HitPawn).FeignDeathStartTime = WorldInfo.TimeSeconds + 1.5;
					HitPawn.LastHitBy = Controller;
				}
				else if( UTVehicle_Hoverboard(HitPawn) != none)
				{
					HitPawn.Velocity += HornImpulse;
					BoardPawn = UTVehicle_Hoverboard(HitPawn).Driver; // just in case the board gets destroyed from the ragdoll
					UTVehicle_Hoverboard(HitPawn).RagdollDriver();
					HitPawn = BoardPawn;
					HitPawn.LastHitBy = Controller;
				}
				else if ( HitPawn.Physics == PHYS_RigidBody )
				{
					UTV = UTVehicle(HitPawn);
					if(UTV != none)
					{
						// Special case for scavenger - force into ball mode for a bit.
						UTScav = UTVehicle_Scavenger(UTV);
						if(UTScav != None && UTScav.bDriving)
						{
							UTScav.BallStatus.bIsInBallMode = TRUE;
							UTScav.BallStatus.bBoostOnTransition = FALSE;
							UTScav.NextBallTransitionTime = WorldInfo.TimeSeconds + 2.0; // Stop player from putting legs out for 2 secs.
							UTScav.BallModeTransition();
						}
						// See if darkwalker forces this player out of vehicle.
						else if(UTV.bRagdollDriverOnDarkwalkerHorn)
						{
							OldDriver = UTPawn(UTV.Driver);
							if (OldDriver != None)
							{
								UTV.DriverLeave(true);
								OldDriver.Velocity += HornImpulse;
								OldDriver.ForceRagdoll();
								OldDriver.FeignDeathStartTime = WorldInfo.TimeSeconds + 1.5;
								OldDriver.LastHitBy = Controller;
							}
						}

						HitPawn.Mesh.AddImpulse(HornImpulse*VehicleHornModifier, HitLocation);
					}
					else
					{
						HitPawn.Mesh.AddImpulse(HornImpulse, HitLocation,, true);
					}
				}
			}
		}
	}
	SetTimer(SpeakerRechargeTime, false, 'ClearHornTimer');
}

simulated function ClearHornTimer()
{
	bSpeakerReady = true;
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bSpeakerReady')
	{
		if (!bSpeakerReady)
		{
			PlayHornAttack();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function TeamChanged()
{
	local MaterialInterface NewMaterial;

	if( Team < PowerOrbTeamMaterials.length )
	{
		NewMaterial = PowerOrbTeamMaterials[Team];
	}
	else
	{
		NewMaterial = PowerOrbTeamMaterials[0];
	}

	if (NewMaterial != None)
	{
		Mesh.SetMaterial(1, NewMaterial);

		if (DamageMaterialInstance[1] != None)
		{
			DamageMaterialInstance[1].SetParent(NewMaterial);
		}
	}

	Super.TeamChanged();
}

defaultproperties
{
   HornImpulseMag=1250.000000
   VehicleHornModifier=5.300000
   Begin Object Class=ParticleSystemComponent Name=HornEffect ObjName=HornEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_HornEffect'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Translation=(X=0.000000,Y=0.000000,Z=-400.000000)
      Name="HornEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   DarkwalkerHornEffect=HornEffect
   bSpeakerReady=True
   SpeakerRadius=750.000000
   SpeakerRechargeTime=7.000000
   HornAttackSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_HornCue'
   BeamTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_MainGun_Beam'
   BeamSockets(0)="MainGun_00"
   BeamSockets(1)="MainGun_01"
   EndPointParamName="LinkBeamEnd"
   Begin Object Class=AudioComponent Name=BeamAmbientSoundComponent ObjName=BeamAmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="BeamAmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BeamAmbientSound=BeamAmbientSoundComponent
   BeamFireSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FireBeamCue'
   Begin Object Class=AudioComponent Name=WarningSound ObjName=WarningSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_Darkwalker_WarningConeLoop'
      Name="WarningSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   WarningConeSound=WarningSound
   ConeParam="ConeScore"
   PowerOrbTeamMaterials(0)=Material'VH_DarkWalker.Materials.M_VH_Darkwalker_EnergyCore_Glow'
   PowerOrbTeamMaterials(1)=Material'VH_DarkWalker.Materials.M_VH_Darkwalker_EnergyCore_Glow_Blue'
   PowerOrbBurnoutTeamMaterials(0)=MaterialInstanceTimeVarying'VH_DarkWalker.Materials.MITV_VH_Darkwalker_EnergyCore_Glow_BO'
   PowerOrbBurnoutTeamMaterials(1)=MaterialInstanceTimeVarying'VH_DarkWalker.Materials.MITV_VH_Darkwalker_EnergyCore_Glow_Blue_BO'
   Begin Object Class=RB_Handle Name=RB_BodyHandle ObjName=RB_BodyHandle Archetype=RB_Handle'UTGame.Default__UTVehicle_DarkWalker:RB_BodyHandle'
      ObjectArchetype=RB_Handle'UTGame.Default__UTVehicle_DarkWalker:RB_BodyHandle'
   End Object
   BodyHandle=RB_BodyHandle
   BodyType=Class'UTGameContent.UTWalkerBody_DarkWalker'
   BodyAttachSocketName="PowerBallSocket"
   bHasEnemyVehicleSound=True
   AIPurpose=AIP_Any
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_DarkWalker:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_DarkWalker:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_ManTheDarkwalker')
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_DarkWalkerTurret',GunSocket=("MainGun_Fire"),GunPivotPoints=("PrimaryTurretPitch"),WeaponEffects=((SocketName="MainGun_00",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000)),(SocketName="MainGun_01",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000))),TurretControls=("MainGunPitch"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=40.000000,Y=0.000000,Z=0.000000),CameraSafeOffset=(X=0.000000,Y=0.000000,Z=200.000000),CameraOffset=-280.000000,MuzzleFlashLightClass=Class'UTGameContent.UTDarkWalkerMuzzleFlashLight',SeatIconPOS=(X=0.460000,Y=0.200000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_DarkWalkerPassGun',GunSocket=("TurretBarrel_00","TurretBarrel_01","TurretBarrel_02","TurretBarrel_03"),GunPivotPoints=("SecondaryTurretYaw"),TurretVarPrefix="Turret",WeaponEffects=((SocketName="TurretBarrel_00",Offset=(X=-35.000000,Y=0.000000,Z=-12.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000)),(SocketName="TurretBarrel_01",Offset=(X=-35.000000,Y=0.000000,Z=-12.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000))),TurretControls=("TurretYaw","TurretPitch"),CameraTag="TurretViewSocket",CameraSafeOffset=(X=0.000000,Y=0.000000,Z=200.000000),bSeatVisible=True,SeatBone="SecondaryTurretYaw",SeatOffset=(X=162.000000,Y=0.000000,Z=-81.000000),SeatIconPOS=(X=0.460000,Y=0.500000))
   VehicleEffects(0)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_MuzzleFlash',EffectSocket="MainGun_00")
   VehicleEffects(1)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_MuzzleFlash',EffectSocket="MainGun_01")
   VehicleEffects(2)=(EffectStartTag="TurretWeapon03",EffectEndTag="STOP_TurretWeapon00",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Secondary_MuzzleFlash',EffectSocket="TurretBarrel_00")
   VehicleEffects(3)=(EffectStartTag="TurretWeapon00",EffectEndTag="STOP_TurretWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Secondary_MuzzleFlash',EffectSocket="TurretBarrel_01")
   VehicleEffects(4)=(EffectStartTag="TurretWeapon01",EffectEndTag="STOP_TurretWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Secondary_MuzzleFlash',EffectSocket="TurretBarrel_02")
   VehicleEffects(5)=(EffectStartTag="TurretWeapon02",EffectEndTag="STOP_TurretWeapon03",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Secondary_MuzzleFlash',EffectSocket="TurretBarrel_03")
   VehicleEffects(6)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_AimBeam',EffectSocket="Lt_AimBeamSocket")
   VehicleEffects(7)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_AimBeam',EffectSocket="Rt_AimBeamSocket")
   VehicleEffects(8)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_PowerBall',EffectTemplate_Blue=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_PowerBall_Blue',EffectSocket="PowerBallSocket")
   VehicleEffects(9)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_DarkWalker',EffectSocket="DamageSmoke01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=2.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.600000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=2.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_DamageFront",InfluenceBone="head",Health=300,DamagePropNames=("Damage3"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_DamageRear",InfluenceBone="RtUpperTailFin",Health=300,DamagePropNames=("Damage2"))
   DamageMorphTargets(2)=(InfluenceBone="LtPanel_Damage",Health=250,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(InfluenceBone="RtPanel_Damage",Health=250,DamagePropNames=("Damage1"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_DarkWalker.Materials.MI_VH_Darkwalker_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_DarkWalker.Materials.MI_VH_Darkwalker_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_DarkWalker_Death_Main')
   BigExplosionSocket="PowerBallSocket"
   ExplosionSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_ExplosionCue'
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   FlagBone="head"
   IconCoords=(U=907.000000,V=36.000000,UL=26.000000,VL=37.000000)
   PassengerTeamBeaconOffset=(X=-150.000000,Y=0.000000,Z=0.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_DarkWalker.Materials.MI_VH_Darkwalker_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_DarkWalker.Materials.MI_VH_Darkwalker_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_DarkWalker.Materials.MITV_VH_Darkwalker_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_DarkWalker.Materials.MITV_VH_Darkwalker_Blue_BO'
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyDarkwalker'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyDarkwalker'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyDarkwalker'
   VehicleDestroyedSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyDarkwalkerDestroyed'
   VehicleDestroyedSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyDarkwalkerDestroyed'
   VehicleDestroyedSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyDarkwalkerDestroyed'
   HudCoords=(U=644.000000,UL=-98.000000,VL=129.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicle_DarkWalker:SimObject'
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicle_DarkWalker:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_DarkWalker:RThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_DarkWalker:RThruster'
   End Object
   Wheels(0)=RThruster
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_13 ObjName=MyStayUprightSetup_13 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightSetup_13'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightSetup_13'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_DarkWalker_Content:MyStayUprightSetup_13'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_13 ObjName=MyStayUprightConstraintInstance_13 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightConstraintInstance_13'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightConstraintInstance_13'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_DarkWalker_Content:MyStayUprightConstraintInstance_13'
   Begin Object Class=AudioComponent Name=MantaEngineSound ObjName=MantaEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_EngineLoopCue'
      Name="MantaEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=MantaEngineSound
   CollisionSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_CollideCue'
   EnterVehicleSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_StartCue'
   ExitVehicleSound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_StopCue'
   TargetLocationAdjustment=(X=0.000000,Y=0.000000,Z=150.000000)
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_DarkWalker:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso'
      AnimTreeTemplate=AnimTree'VH_DarkWalker.Anims.AT_VH_DarkWalker'
      PhysicsAsset=PhysicsAsset'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso_Physics'
      AnimSets(0)=AnimSet'VH_DarkWalker.Anims.K_VH_DarkWalker'
      MorphSets(0)=MorphTargetSet'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso_MorphTargets'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_DarkWalker:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_DarkWalker:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=140.000000
      Translation=(X=0.000000,Y=0.000000,Z=50.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_DarkWalker:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=RB_BodyHandle
   Components(4)=SimObject
   Components(5)=WarningSound
   Components(6)=HornEffect
   Components(7)=MantaEngineSound
   Components(8)=BaseScrapeSound
   Components(9)=BeamAmbientSoundComponent
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_DarkWalker_Content"
   ObjectArchetype=UTVehicle_DarkWalker'UTGame.Default__UTVehicle_DarkWalker'
}
