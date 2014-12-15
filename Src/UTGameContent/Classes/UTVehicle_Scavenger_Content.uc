/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Scavenger_Content extends UTVehicle_Scavenger;

event ScavengerJumpEffect()
{
	PlaySound(JumpSound, true);
	VehicleEvent('BoostStart');
}

event ScavengerDuckEffect()
{
	if (bHoldingDuck)
	{
		if (DuckSound != None)
		{
			PlaySound(DuckSound);
		}
		VehicleEvent('CrushStart');
	}
	else
	{
		VehicleEvent('CrushStop');
	}
}

/**
 * Create all of the vehicle weapons
 */
function InitializeSeats()
{
	super.InitializeSeats();

	UTVWeap_ScavengerGun(Seats[0].Gun).MyScavenger = self;
}

defaultproperties
{
   SpinAttackTotalTime=1.600000
   JumpSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Jump_Cue'
   DuckSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Land_Cue'
   BounceSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BallCollide_Cue'
   LandSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Land_Cue'
   Begin Object Class=AudioComponent Name=BladeSpinningSoundComponent ObjName=BladeSpinningSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BladesSpin_Cue'
      bStopWhenOwnerDestroyed=True
      Name="BladeSpinningSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BladesSpinningAC=BladeSpinningSoundComponent
   Begin Object Class=AudioComponent Name=BladesRetractSoundComponent ObjName=BladesRetractSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BladesRetract01_Cue'
      bStopWhenOwnerDestroyed=True
      Name="BladesRetractSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BladesRetractAC=BladesRetractSoundComponent
   BladesHitFleshSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BladesImpactFlesh_Cue'
   BladesHitSurfaceSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BladesImpactSurface_Cue'
   ArmRetractSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_ArmsRetract_Cue'
   ArmExtendSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_ArmsExtend_Cue'
   Begin Object Class=AudioComponent Name=BallRollSound ObjName=BallRollSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_BallRoll_Cue'
      Name="BallRollSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BallAudio=BallRollSound
   ShieldTeamMaterials(0)=Material'VH_Scavenger.Materials.M_VH_Scavenger_Shield'
   ShieldTeamMaterials(1)=Material'VH_Scavenger.Materials.M_VH_Scavenger_Shield_Blue'
   ShieldBurnoutTeamMaterials(0)=MaterialInstanceTimeVarying'VH_Scavenger.Materials.MITV_VH_Scavenger_Shield_BO'
   ShieldBurnoutTeamMaterials(1)=MaterialInstanceTimeVarying'VH_Scavenger.Materials.MITV_VH_Scavenger_Shield_Blue_BO'
   Begin Object Class=AudioComponent Name=TireSound ObjName=TireSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue'
      Name="TireSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   RollAudioComp=TireSound
   RollSoundList(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue')
   RollSoundList(1)=(MaterialType="Foliage",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireFoliage01Cue')
   RollSoundList(2)=(MaterialType="Grass",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireGrass01Cue')
   RollSoundList(3)=(MaterialType="Metal",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMetal01Cue')
   RollSoundList(4)=(MaterialType="Mud",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMud01Cue')
   RollSoundList(5)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireSnow01Cue')
   RollSoundList(6)=(MaterialType="Stone",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireStone01Cue')
   RollSoundList(7)=(MaterialType="Wood",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWood01Cue')
   Begin Object Class=ParticleSystemComponent Name=ImpactPart ObjName=ImpactPart Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Shield_Impact'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Name="ImpactPart"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   ImpactParticle=ImpactPart
   BallCollisionDamageType=Class'UTGameContent.UTDmgType_ScavengerBallCollision'
   Begin Object Class=ParticleSystemComponent Name=BoostingSystem ObjName=BoostingSystem Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Boost'
      bAutoActivate=False
      Name="BoostingSystem"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   BallBoostEffect=BoostingSystem
   BallBoostEffectTemplate(0)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Boost'
   BallBoostEffectTemplate(1)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Boost_Blue'
   Begin Object Class=ParticleSystemComponent Name=BallHitEffect ObjName=BallHitEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Hit'
      bAutoActivate=False
      AbsoluteRotation=True
      AbsoluteScale=True
      TickGroup=TG_PostAsyncWork
      Name="BallHitEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   BallHitComponent=BallHitEffect
   BallHitEffectTemplate(0)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Hit'
   BallHitEffectTemplate(1)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Ball_Hit_Blue'
   Begin Object Class=RB_Handle Name=RB_BodyHandle ObjName=RB_BodyHandle Archetype=RB_Handle'UTGame.Default__UTVehicle_Scavenger:RB_BodyHandle'
      ObjectArchetype=RB_Handle'UTGame.Default__UTVehicle_Scavenger:RB_BodyHandle'
   End Object
   BodyHandle=RB_BodyHandle
   BodyType=Class'UTGameContent.UTWalkerBody_Scavenger_Content'
   BodyAttachSocketName="LegsAttach"
   bCameraNeverHidesVehicle=True
   bAllowTowFromAllDirections=True
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Scavenger:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Scavenger:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_ScavengerGun',GunSocket=("Gun_Socket_01","Gun_Socket_02"),CameraTag="SphereCenter",CameraOffset=-400.000000,bSeatVisible=True,SeatOffset=(X=-28.000000,Y=0.000000,Z=26.000000),SeatSocket="LegsAttach",SeatIconPOS=(X=0.455000,Y=0.460000))
   VehicleEffects(0)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Thruster_Left',EffectTemplate_Blue=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Thruster_Left_Blue',EffectSocket="LeftThruster")
   VehicleEffects(1)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Thruster_Right',EffectTemplate_Blue=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Thruster_Right_Blue',EffectSocket="RightThruster")
   VehicleEffects(2)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Powerball',EffectTemplate_Blue=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Powerball_Blue',EffectSocket="PowerBall")
   VehicleEffects(3)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Scavenger',EffectSocket="DamageSmoke_01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=0.600000)
   DamageMorphTargets(0)=(InfluenceBone="BodyRoot",Health=120,DamagePropNames=("Damage1"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Scavenger.Materials.MI_VH_Scavenger_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Scavenger.Materials.MI_VH_Scavenger_Blue'
   VehiclePieceClass=Class'UTGameContent.UTGib_VehiclePiece_Necris'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Collide_Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   DrivingAnim="Scavenger_Idle_Sitting"
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   IconCoords=(U=934.000000,V=47.000000,UL=30.000000,VL=29.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Scavenger.Materials.MI_VH_Scavenger_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Scavenger.Materials.MI_VH_Scavenger_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Scavenger.Materials.MITV_VH_Scavenger_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Scavenger.Materials.MITV_VH_Scavenger_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyScavenger'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyScavenger'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyScavenger'
   HudCoords=(U=393.000000,UL=-124.000000,VL=105.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Scavenger:SimObject'
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Scavenger:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Scavenger:RThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Scavenger:RThruster'
   End Object
   Wheels(0)=RThruster
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_14 ObjName=MyStayUprightSetup_14 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Scavenger:MyStayUprightSetup_14'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Scavenger:MyStayUprightSetup_14'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Scavenger_Content:MyStayUprightSetup_14'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_14 ObjName=MyStayUprightConstraintInstance_14 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Scavenger:MyStayUprightConstraintInstance_14'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Scavenger:MyStayUprightConstraintInstance_14'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Scavenger_Content:MyStayUprightConstraintInstance_14'
   Begin Object Class=AudioComponent Name=MantaEngineSound ObjName=MantaEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_OrbEngine_Cue'
      Name="MantaEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=MantaEngineSound
   CollisionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Enter_Cue'
   ExitVehicleSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Exit_Cue'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Scavenger:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Scavenger.Mesh.SK_VH_Scavenger_Torso'
      AnimTreeTemplate=AnimTree'VH_Scavenger.Anim.AT_VH_Scavenger_Body'
      PhysicsAsset=PhysicsAsset'VH_Scavenger.Mesh.SK_VH_Scavenger_Torso_Physics_Final'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Scavenger:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Scavenger:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=100.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Scavenger:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=RB_BodyHandle
   Components(4)=SimObject
   Components(5)=ImpactPart
   Components(6)=BoostingSystem
   Components(7)=MantaEngineSound
   Components(8)=BallRollSound
   Components(9)=BaseScrapeSound
   Components(10)=BladeSpinningSoundComponent
   Components(11)=BladesRetractSoundComponent
   Components(12)=TireSound
   DrawScale=0.500000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Scavenger_Content"
   ObjectArchetype=UTVehicle_Scavenger'UTGame.Default__UTVehicle_Scavenger'
}
