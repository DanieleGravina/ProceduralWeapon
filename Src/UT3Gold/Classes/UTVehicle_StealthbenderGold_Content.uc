/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_StealthBenderGold_Content extends UTVehicle_StealthBender;

/** MIs for the turret **/
var MaterialInterface BurnOutTurret[2];

simulated function PostBeginPlay()
{
	local UTSkelControl_TurretConstrained TurretConstraint;

	Super.PostBeginPlay();

	//adjust the constraints from content 
	TurretConstraint = Seats[0].TurretControllers[0];
	TurretConstraint.MinAngle.PitchConstraint = -15;
	TurretConstraint.Steps[0].MinAngle.PitchConstraint = -15;
}

simulated function SetBurnOut()
{
	local int TeamNum;

	TeamNum = GetTeamNum();

	if( TeamNum > 1 )
	{
		TeamNum = 0;
	}

	// set our specific turret BurnOut Material
	if (BurnOutTurret[TeamNum] != None)
	{
		Mesh.SetMaterial( 1, BurnOutTurret[TeamNum] );
	}

	// sets the MIC
	super.SetBurnOut();							
}

/** Draws a single weapon selection tile in the HUD
 *  Uses UT3G texture for new deployables
 */
function DrawWeaponTile(Canvas Canvas, Texture2D IconTexture, UTVWeap_NightshadeGun Gun, int WeaponIndex, float OffsetSizeX, float OffsetSizeY)
{
	// For the XRay Volume and Link Generator, use the UT3g HUD icon texture
	if ( WeaponIndex == 1 || WeaponIndex == 3 )
	{
		Super.DrawWeaponTile(Canvas, HUDIconsUT3G, Gun, WeaponIndex, OffsetSizeX, OffsetSizeY);
	}
	else
	{
		Super.DrawWeaponTile(Canvas, IconTexture, Gun, WeaponIndex, OffsetSizeX, OffsetSizeY);
	}
}

defaultproperties
{
   BurnOutTurret(0)=MaterialInstanceTimeVarying'VH_StealthBender.Materials.MITV_VH_Stealthbender_Red_BO'
   BurnOutTurret(1)=MaterialInstanceTimeVarying'VH_StealthBender.Materials.MITV_VH_Stealthbender_Blue_BO'
   SecondaryTeamSkins(0)=MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_Stealthbender_Red'
   SecondaryTeamSkins(1)=MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_Stealthbender_Blue'
   TurretName="DeployYaw"
   Begin Object Class=AudioComponent Name=StealthBenderStealthResSound ObjName=StealthBenderStealthResSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.Portal.Portal_WalkThrough01Cue'
      bStopWhenOwnerDestroyed=True
      Name="StealthBenderStealthResSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   StealthResSound=StealthBenderStealthResSound
   ExhaustEffectName="ExhaustVel"
   CloakedSkin=Material'VH_StealthBender.Materials.M_VH_StealthBender_Skin'
   SkinTranslucencyName="skintranslucency"
   TeamSkinParamName="SkinColor"
   HitEffectName="HitEffect"
   OverlayColorName="Veh_OverlayColor"
   DeployablePositionOffsets(0)=(X=10.000000,Y=0.000000,Z=-15.000000)
   DeployablePositionOffsets(1)=(X=10.000000,Y=0.000000,Z=-15.000000)
   DeployablePositionOffsets(2)=(X=5.000000,Y=0.000000,Z=-5.000000)
   DeployablePositionOffsets(3)=(X=5.000000,Y=0.000000,Z=-10.000000)
   BeamTemplate=ParticleSystem'VH_StealthBender.Effects.P_VH_StealthBender_Beam'
   BeamSockets="GunnerFireSocket"
   EndPointParamName="LinkBeamEnd"
   Begin Object Class=AudioComponent Name=BeamAmbientSoundComponent ObjName=BeamAmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="BeamAmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BeamAmbientSound=BeamAmbientSoundComponent
   BeamFireSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_FireLoop01_Cue'
   BeamStartSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_FireStart01_Cue'
   BeamStopSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_FireStop01_Cue'
   LinkBeamColors(0)=(B=64,G=64,R=255,A=255)
   LinkBeamColors(1)=(B=255,G=64,R=64,A=255)
   LinkBeamColors(2)=(B=32,G=255,R=32,A=255)
   Begin Object Class=AudioComponent Name=ArmSound ObjName=ArmSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_ArmsMove01_Cue'
      Name="ArmSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretArmMoveSound=ArmSound
   DeployTime=1.300000
   UnDeployTime=1.300000
   GetInAnim(0)="GetIn"
   GetOutAnim(0)="GetOut"
   IdleAnim(0)="InActiveIdle"
   IdleAnim(1)="Idle"
   DeployAnim(0)="ArmExtend"
   DeployAnim(1)="ArmRetract"
   DeploySound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_ArmsExtend01_Cue'
   UndeploySound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_ArmsRetract01_Cue'
   ToolTipIconCoords=(U=359.000000,V=241.000000,UL=126.000000,VL=58.000000)
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_StealthBender:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_StealthBender:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_ManTheStealthbender')
   Seats(0)=(GunClass=Class'UT3Gold.UTVWeap_StealthBenderGold_Content',GunSocket=("GunnerFireSocket"),WeaponEffects=((SocketName="GunnerFireSocket",Offset=(X=-35.000000,Y=0.000000,Z=0.000000),Scale3D=(X=4.000000,Y=6.500000,Z=6.500000))),TurretControls=("GunnerConstraint","DeployYaw"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=-90.000000,Y=0.000000,Z=20.000000),CameraOffset=-400.000000,SeatIconPOS=(X=0.420000,Y=0.480000))
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_StealthBender',EffectSocket="DamageSmoke_01")
   VehicleEffects(1)=(EffectStartTag="ShockTurretFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_DriverPrimMuzzleFlash',EffectSocket="GunnerFireSocket")
   VehicleEffects(2)=(EffectStartTag="ShockTurretAltFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_DriverAltMuzzleFlash',EffectSocket="GunnerFireSocket")
   TeamMaterials(0)=MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_StealthBenderMain_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_StealthBenderMain_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_Explode'
   Begin Object Class=AudioComponent Name=ScorpionTireSound ObjName=ScorpionTireSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue'
      Name="ScorpionTireSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TireAudioComp=ScorpionTireSound
   TireSoundList(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue')
   TireSoundList(1)=(MaterialType="Foliage",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireFoliage01Cue')
   TireSoundList(2)=(MaterialType="Grass",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireGrass01Cue')
   TireSoundList(3)=(MaterialType="Metal",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMetal01Cue')
   TireSoundList(4)=(MaterialType="Mud",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMud01Cue')
   TireSoundList(5)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireSnow01Cue')
   TireSoundList(6)=(MaterialType="Stone",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireStone01Cue')
   TireSoundList(7)=(MaterialType="Wood",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWood01Cue')
   TireSoundList(8)=(MaterialType="Water",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWater01Cue')
   IconCoords=(U=886.000000,V=35.000000,UL=19.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_StealthBenderMain_Spawn_Red',MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_StealthBender.Materials.MI_VH_StealthBenderMain_Spawn_Blue',MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_StealthBender.Materials.MITV_VH_StealthBenderMain_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_StealthBender.Materials.MITV_VH_StealthBenderMain_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Hellbender_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dirt_Effects.P_Hellbender_Wheel_Dirt')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Hellbender_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Hellbender_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyStealthbender'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyStealthbender'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyStealthbender'
   HudCoords=(U=826.000000,UL=-81.000000,VL=115.000000)
   Begin Object Class=UTVehicleSimHellbender Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_StealthBender:SimObject'
      ObjectArchetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_StealthBender:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleHellbenderWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RRWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LRWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RFWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LFWheel'
   End Object
   Wheels(3)=LFWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_7 ObjName=MyStayUprightSetup_7 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_StealthBender:MyStayUprightSetup_7'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_StealthBender:MyStayUprightSetup_7'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UT3Gold.Default__UTVehicle_StealthBenderGold_Content:MyStayUprightSetup_7'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_7 ObjName=MyStayUprightConstraintInstance_7 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_StealthBender:MyStayUprightConstraintInstance_7'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_StealthBender:MyStayUprightConstraintInstance_7'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UT3Gold.Default__UTVehicle_StealthBenderGold_Content:MyStayUprightConstraintInstance_7'
   Begin Object Class=AudioComponent Name=HellBenderEngineSound ObjName=HellBenderEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_EngineLoop01_Cue'
      Name="HellBenderEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=HellBenderEngineSound
   CollisionSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_Impact_Cue'
   EnterVehicleSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_EngineStart01_Cue'
   ExitVehicleSound=SoundCue'A_Vehicle_Stealthbender.Stealthbender.A_Vehicle_Stealthbender_EngineStop01_Cue'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_StealthBender:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_StealthBender.Mesh.SK_VH_StealthBender'
      AnimTreeTemplate=AnimTree'VH_StealthBender.Anims.AT_VH_StealthBender'
      PhysicsAsset=PhysicsAsset'VH_StealthBender.Mesh.SK_VH_Stealthbender_Physics'
      AnimSets(0)=AnimSet'VH_StealthBender.Anims.K_VH_StealthBender'
      Materials(0)=MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Red'
      Materials(1)=Material'VH_StealthBender.Materials.M_VH_Stealthbender'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_StealthBender:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_StealthBender:CollisionCylinder'
      CollisionHeight=65.000000
      CollisionRadius=140.000000
      Translation=(X=0.000000,Y=0.000000,Z=-15.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_StealthBender:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=ArmSound
   Components(5)=BeamAmbientSoundComponent
   Components(6)=ScorpionTireSound
   Components(7)=HellBenderEngineSound
   Components(8)=StealthBenderStealthResSound
   DrawScale=1.200000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_StealthBenderGold_Content"
   ObjectArchetype=UTVehicle_StealthBender'UTGame.Default__UTVehicle_StealthBender'
}
