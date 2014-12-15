/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTVehicle_Paladin extends UTVehicle;

/** actor used for the shield */
var UTPaladinShield ShockShield;
/** indicates whether or not the shield is currently active */
var repnotify bool bShieldActive;
/** used for replicating shield hits to make it flash on clients */
var repnotify byte ShieldHitCount;
/** replicates shield health to non owning clients for effects (0 to 1 float compressed to byte)*/
var repnotify byte ShieldHealthPct;

/** time between combo proximity explosion shots */
var float ComboFireInterval;
var float LastComboTime;
/** combo explosion damage properties */
var int ComboExplosionDamage;
var float ComboExplosionRadius, ComboExplosionMomentum;
/** combo explosion effects */
var ParticleSystem ComboExplosionTemplate;
var SoundCue ComboExplosionSound;
/** used to trigger combo effects on clients */
var repnotify byte ComboFlashCount;
/** camera anim played when doing the combo (firing player only) */
var CameraAnim ComboShake;

replication
{
	if (bNetDirty)
		bShieldActive, ShieldHitCount, ComboFlashCount;
	if (bShieldActive && !bNetOwner)
		ShieldHealthPct;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ShockShield = Spawn(class'UTPaladinShield', self);
	ShockShield.SetBase(self,, Mesh, 'Shield_Pitch');
}

function bool ImportantVehicle()
{
	return true;
}

function IncomingMissile(Projectile P)
{
	local AIController C;

	C = AIController(Controller);
	if (C != None && C.Skill >= 2.0)
	{
		UTVWeap_PaladinGun(Weapon).ShieldAgainstIncoming(P);
	}
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	UTVWeap_PaladinGun(Weapon).ShieldAgainstIncoming();
	return false;
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local vector ShieldHitLocation, ShieldHitNormal;

	if ( Role < ROLE_Authority )
		return;

	// don't take damage if the shield is active and it hit the shield component or skipped it for some reason but should have hit it
	if ( ShockShield == None || !(bShieldActive && ShockShield.bFullyActive ) ||
		( HitInfo.HitComponent != ShockShield.CollisionComponent && ( IsZero(Momentum) || HitLocation == Location || DamageType == None
								|| !ClassIsChildOf(DamageType, class'UTDamageType')
								|| !TraceComponent(ShieldHitLocation, ShieldHitNormal, ShockShield.CollisionComponent, HitLocation, HitLocation - 2000.f * Normal(Momentum)) ) ) )
	{
		// Don't take self inflicted damage from proximity explosion
		if (DamageType != class'UTDmgType_PaladinProximityExplosion' || EventInstigator != Controller)
		{
			Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		}
	}
	else if ( !WorldInfo.GRI.OnSameTeam(self, EventInstigator) )
	{
		UTVWeap_PaladinGun(Weapon).NotifyShieldHit(Damage);
		ShieldHit();
	}
}

simulated function SetShieldActive(int SeatIndex, bool bNowActive)
{
	if (SeatIndex == 0)
	{
		bShieldActive = bNowActive;
		if (ShockShield != None)
		{
			ShockShield.SetActive(bNowActive);
		}
		if (!bNowActive)
		{
			ComboFlashCount = 0;
		}
	}
}

simulated function ShieldHit()
{
	// FIXME: play effects
	ShieldHitCount++;
}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
	if (bShieldActive && FireModeNum == 0)
	{
		if (Role == ROLE_Authority && WorldInfo.TimeSeconds - LastComboTime >= ComboFireInterval)
		{
			ComboExplosion();
		}
		return true;
	}
	else
	{
		return false;
	}
}

simulated function ComboExplosion()
{
	local ParticleSystemComponent ProjExplosion;
	local UTPlayerController PC;

	LastComboTime = WorldInfo.TimeSeconds;

	HurtRadius(ComboExplosionDamage, ComboExplosionRadius, class'UTDmgType_PaladinProximityExplosion', ComboExplosionMomentum, Location, self);

	// play explosion effects
	PlaySound(ComboExplosionSound, true);
	if (WorldInfo.NetMode != NM_DedicatedServer && ComboExplosionTemplate != None && EffectIsRelevant(Location, false))
	{
		ProjExplosion = WorldInfo.MyEmitterPool.SpawnEmitter(ComboExplosionTemplate, Location, Rotation);
		ProjExplosion.SetScale(3.25);
	}
	PC = UTPlayerController(Controller);
	if (PC != None && PC.IsLocalPlayerController())
	{
		PC.PlayCameraAnim(ComboShake);
	}

	if (Role == ROLE_Authority)
	{
		ComboFlashCount++;
	}
}

simulated function ShieldHealthUpdated()
{
	if (ShockShield != None)
	{
		ShockShield.ShieldEffectComponent.SetFloatParameter(ShockShield.ShieldStrengthParam, ByteToFloat(ShieldHealthPct));
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bShieldActive')
	{
		SetShieldActive(0, bShieldActive);
	}
	else if (VarName == 'ShieldHitCount')
	{
		ShieldHit();
	}
	else if (VarName == 'ComboFlashCount')
	{
		if (ComboFlashCount != 0)
		{
			ComboExplosion();
		}
	}
	else if (VarName == 'ShieldHealthPct')
	{
		ShieldHealthUpdated();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function BlowupVehicle()
{
	if (ShockShield != None)
	{
		ShockShield.Destroy();
	}

	Super.BlowupVehicle();
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (ShockShield != None)
	{
		ShockShield.Destroy();
	}
}

/** @return whether the shield should be forced off because there's a wall in the way */
function bool IsShieldObstructed()
{
	local vector SocketLocation;
	local rotator SocketRotation;

	// check if center of shield is on the other side of a wall
	Mesh.GetSocketWorldLocationAndRotation('ShieldGen', SocketLocation, SocketRotation);
	return !FastTrace(SocketLocation + vector(SocketRotation) * 500.0, SocketLocation,, true);
}

/**
 * No muzzle flashlight on shield
 */
simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	if ( bShieldActive )
		return;

	Super.CauseMuzzleFlashLight(SeatIndex);
}

function bool TooCloseToAttack(Actor Other)
{
	// never too close to hit Pawns because we can use the proximity blast
	return (Pawn(Other) == None && Super.TooCloseToAttack(Other));
}

defaultproperties
{
   ComboFireInterval=2.350000
   ComboExplosionDamage=200
   ComboExplosionRadius=900.000000
   ComboExplosionMomentum=150000.000000
   ComboExplosionTemplate=ParticleSystem'VH_Paladin.Particles.P_VH_Paladin_ProximityExplosion'
   ComboExplosionSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ComboExplosion'
   ComboShake=CameraAnim'VH_Paladin.Effects.PP_Paladin_Burst'
   bStickDeflectionThrottle=True
   bLookSteerOnSimpleControls=True
   bHasTurretExplosion=True
   bHasEnemyVehicleSound=True
   AIPurpose=AIP_Any
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   MaxDesireability=0.600000
   ObjectiveGetOutDist=1500.000000
   HornIndex=1
   LeftStickDirDeadZone=0.100000
   ConsoleSteerScale=1.000000
   HUDExtent=140.000000
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_PaladinGun',GunSocket=("GunSocket"),GunPivotPoints=("Turret_Yaw"),WeaponEffects=((SocketName="GunSocket",Offset=(X=-80.000000,Y=0.000000,Z=0.000000),Scale3D=(X=10.000000,Y=11.000000,Z=11.000000))),TurretControls=("Turret_Yaw","Turret_Pitch","Shield_Pitch"),CameraTag="ViewSocket",CameraOffset=-400.000000,MuzzleFlashLightClass=Class'UTGame.UTShockComboExplosionLight',SeatIconPOS=(X=0.430000,Y=0.480000))
   VehicleEffects(0)=(EffectStartTag="PrimaryFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Paladin.Effects.P_VH_Paladin_Muzzleflash',EffectSocket="GunSocket")
   VehicleEffects(1)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Paladin',EffectSocket="DamageSmoke_01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=2.500000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.500000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=3.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeWPaladinFront",InfluenceBone="LtFrontBumper",Health=310,DamagePropNames=("Damage2","Damage3"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeWPaladinSide",InfluenceBone="Body",Health=310,DamagePropNames=("Damage2","Damage1","Damage3"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeWPaladinRear",InfluenceBone="LtRearBumper",Health=310,DamagePropNames=("Damage2","Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Paladin.Materials.MI_VH_Paladin_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Paladin.Materials.MI_VH_Paladin_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   DestroyedTurretTemplate=StaticMesh'VH_Paladin.Mesh.S_VH_Paladin_Top'
   TurretExplosiveForce=5000.000000
   ExplosionSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_Explode'
   TireSoundList(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue')
   TireSoundList(1)=(MaterialType="Foliage",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireFoliage01Cue')
   TireSoundList(2)=(MaterialType="Grass",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireGrass01Cue')
   TireSoundList(3)=(MaterialType="Metal",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMetal01Cue')
   TireSoundList(4)=(MaterialType="Mud",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMud01Cue')
   TireSoundList(5)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireSnow01Cue')
   TireSoundList(6)=(MaterialType="Stone",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireStone01Cue')
   TireSoundList(7)=(MaterialType="Wood",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWood01Cue')
   TireSoundList(8)=(MaterialType="Water",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWater01Cue')
   FlagOffset=(X=0.000000,Y=0.000000,Z=30.000000)
   FlagBone="RtAntenna03"
   IconCoords=(U=965.000000,V=0.000000,UL=22.000000,VL=36.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Paladin.Materials.MI_VH_Paladin_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Paladin.Materials.MI_VH_Paladin_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Paladin.Materials.MITV_VH_Paladin_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Paladin.Materials.MITV_VH_Paladin_Blue_BO'
   LookForwardDist=70.000000
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Paladin_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dirt_Effects.P_Hellbender_Wheel_Dirt')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Paladin_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Paladin_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyPaladin'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyPaladin'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyPaladin'
   HudCoords=(U=653.000000,V=129.000000,UL=-80.000000,VL=126.000000)
   Begin Object Class=UTVehicleSimCar Name=SimObject ObjName=SimObject Archetype=UTVehicleSimCar'UTGame.Default__UTVehicleSimCar'
      TorqueVSpeedCurve=(Points=((InVal=-300.000000),(OutVal=100.000000),(InVal=1000.000000)))
      EngineRPMCurve=(Points=((InVal=-500.000000,OutVal=2500.000000),(OutVal=500.000000),(InVal=599.000000,OutVal=5000.000000),(InVal=600.000000,OutVal=3000.000000),(InVal=949.000000,OutVal=5000.000000),(InVal=950.000000,OutVal=3000.000000),(InVal=1100.000000,OutVal=5000.000000)))
      LSDFactor=1.000000
      HardTurnMotorTorque=1.000000
      FrontalCollisionGripFactor=0.180000
      ChassisTorqueScale=0.100000
      MaxSteerAngleCurve=(Points=((OutVal=20.000000),(InVal=700.000000,OutVal=15.000000)))
      SteerSpeed=90.000000
      EngineBrakeFactor=0.100000
      MaxBrakeTorque=75.000000
      StopThreshold=100.000000
      WheelSuspensionStiffness=500.000000
      WheelSuspensionDamping=6.000000
      WheelInertia=0.750000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicleSimCar'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=-1.000000
      SkelControlName="RtTire04"
      BoneName="RtTire04"
      BoneOffset=(X=0.000000,Y=35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Right
      Name="RRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleWheel Name=RMRWheel ObjName=RMRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=-0.500000
      SkelControlName="RtTire03"
      BoneName="RtTire03"
      BoneOffset=(X=0.000000,Y=35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Right
      Name="RMRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(1)=RMRWheel
   Begin Object Class=UTVehicleWheel Name=RMFWheel ObjName=RMFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=0.500000
      SkelControlName="RtTire02"
      BoneName="RtTire02"
      BoneOffset=(X=0.000000,Y=35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Right
      Name="RMFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(2)=RMFWheel
   Begin Object Class=UTVehicleWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=1.000000
      SkelControlName="RtTire01"
      BoneName="RtTire01"
      BoneOffset=(X=0.000000,Y=35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Right
      Name="RFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(3)=RFWheel
   Begin Object Class=UTVehicleWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=-1.000000
      SkelControlName="LtTire04"
      BoneName="LtTire04"
      BoneOffset=(X=0.000000,Y=-35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Left
      Name="LRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(4)=LRWheel
   Begin Object Class=UTVehicleWheel Name=LMRWheel ObjName=LMRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=-0.500000
      SkelControlName="LtTire03"
      BoneName="LtTire03"
      BoneOffset=(X=0.000000,Y=-35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Left
      Name="LMRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(5)=LMRWheel
   Begin Object Class=UTVehicleWheel Name=LMFWheel ObjName=LMFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=0.500000
      SkelControlName="LtTire02"
      BoneName="LtTire02"
      BoneOffset=(X=0.000000,Y=-35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Left
      Name="LMFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(6)=LMFWheel
   Begin Object Class=UTVehicleWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bPoweredWheel=True
      SteerFactor=1.000000
      SkelControlName="LtTire01"
      BoneName="LtTire01"
      BoneOffset=(X=0.000000,Y=-35.000000,Z=0.000000)
      WheelRadius=40.000000
      SuspensionTravel=60.000000
      Side=SIDE_Left
      Name="LFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(7)=LFWheel
   COMOffset=(X=0.000000,Y=0.000000,Z=-100.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Paladin:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Paladin:MyStayUprightConstraintInstance'
   MaxSpeed=1200.000000
   Begin Object Class=AudioComponent Name=PaladinEngineSound ObjName=PaladinEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_EngineLoop'
      Name="PaladinEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=PaladinEngineSound
   CollisionSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_Stop'
   bSeparateTurretFocus=True
   MomentumMult=0.800000
   NonPreferredVehiclePathMultiplier=3.000000
   GroundSpeed=700.000000
   AirSpeed=1000.000000
   BaseEyeHeight=40.000000
   EyeHeight=40.000000
   Health=800
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Paladin.Mesh.SK_VH_Paladin'
      AnimTreeTemplate=AnimTree'VH_Paladin.Anims.AT_VH_Paladin'
      PhysicsAsset=PhysicsAsset'VH_Paladin.Mesh.SK_VH_Paladin_Physics'
      AnimSets(0)=AnimSet'VH_Paladin.Anims.VH_Paladin_Anims'
      MorphSets(0)=MorphTargetSet'VH_Paladin.Mesh.VH_Paladin_MorphTargets'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      Translation=(X=0.000000,Y=0.000000,Z=100.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=PaladinEngineSound
   DrawScale=1.350000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Paladin"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
