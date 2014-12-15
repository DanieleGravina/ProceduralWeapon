/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Manta_Content extends UTVehicle_Manta;

simulated function InitializeEffects()
{
	Super.InitializeEffects();

	// we need to do this here as we have a bunch of code that correctly spawns on demand but these are a special case
	// of needing to exist when ever there is a manta
	if( VehicleEffects[FanEffectIndex].EffectRef == None )
	{
		CreateVehicleEffect( FanEffectIndex );
	}

	// immediately start and stop the fan effect, causing the blade particle to be left there unmoving so it's not missing
	//@note: requires a nonzero WarmupTime in the particle system itself
	if (FanEffectIndex >= 0 && FanEffectIndex < VehicleEffects.Length && VehicleEffects[FanEffectIndex].EffectRef != None)
	{
		VehicleEffects[FanEffectIndex].EffectRef.ActivateSystem();
		VehicleEffects[FanEffectIndex].EffectRef.DeactivateSystem();
	}
}

simulated event MantaJumpEffect()
{
	PlaySound(JumpSound, true);
	VehicleEvent('BoostStart');
}

simulated event MantaDuckEffect()
{
	if (bHoldingDuck)
	{
		PlaySound(DuckSound, true);
		VehicleEvent('CrushStart');
	}
	else
	{
		VehicleEvent('CrushStop');
	}
}

simulated function SetVehicleEffectParms(name TriggerName, ParticleSystemComponent PSC)
{
	if (TriggerName == 'MantaOnFire')
	{
		PSC.SetFloatParameter('smokeamount', 0.95);
		PSC.SetFloatParameter('fireamount', 0.95);
	}
	else
	{
		Super.SetVehicleEffectParms(TriggerName, PSC);
	}
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	// manta is fragile so it takes momentum even from weapons that don't usually impart it
	if ( (DamageType == class'UTDmgType_Enforcer') && !IsZero(HitLocation) )
	{
		Momentum = (Location - HitLocation) * float(Damage) * 20.0;
	}
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}

function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
	VehicleEvent('MantaNormal');
	return Super.Died(Killer,DamageType,HitLocation);
}

simulated function DrivingStatusChanged()
{
	if ( !bDriving )
	{
		VehicleEvent('CrushStop');
	}
	Super.DrivingStatusChanged();
}

simulated function BlowupVehicle()
{
	if(WorldInfo.Netmode != NM_DEDICATEDSERVER && VehicleEffects[11].EffectRef != none)
	{
		VehicleEffects[11].EffectRef.SetHidden(true); // special case to get rid of the blades
	}
	super.BlowUpVehicle();
}

defaultproperties
{
   JumpSound=SoundCue'A_Vehicle_Manta.Sounds.A_Vehicle_Manta_JumpCue'
   DuckSound=SoundCue'A_Vehicle_Manta.Sounds.A_Vehicle_Manta_CrouchCue'
   FanEffectIndex=11
   FanEffectParameterName="MantaFanSpin"
   FlameJetEffectParameterName="Jet"
   GroundEffectIndices(0)=12
   GroundEffectIndices(1)=13
   WaterGroundEffect=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.PS_Manta_Water_Effects'
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Manta:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Manta:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_MantaGun',GunSocket=("Gun_Socket_01","Gun_Socket_02"),WeaponEffects=((SocketName="Gun_Socket_01",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=3.000000,Y=6.000000,Z=6.000000)),(SocketName="Gun_Socket_02",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=3.000000,Y=6.000000,Z=6.000000))),TurretControls=("gun_rotate_lt","gun_rotate_rt"),CameraTag="ViewSocket",CameraBaseOffset=(X=-20.000000,Y=0.000000,Z=10.000000),CameraOffset=-180.000000,bSeatVisible=True,SeatOffset=(X=-30.000000,Y=0.000000,Z=-5.000000),DriverDamageMult=0.750000,SeatIconPOS=(X=0.460000,Y=0.450000))
   VehicleEffects(0)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Exhaust_Smoke',EffectSocket="Tailpipe_1")
   VehicleEffects(1)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Exhaust_Smoke',EffectSocket="Tailpipe_2")
   VehicleEffects(2)=(EffectStartTag="BoostStart",EffectEndTag="BoostStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Up_Boost_Jump',EffectSocket="Wing_Lft_Socket")
   VehicleEffects(3)=(EffectStartTag="BoostStart",EffectEndTag="BoostStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Up_Boost_Jump',EffectSocket="Wing_Rt_Socket")
   VehicleEffects(4)=(EffectStartTag="CrushStart",EffectEndTag="CrushStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Down_Boost',EffectSocket="Wing_Lft_Socket")
   VehicleEffects(5)=(EffectStartTag="CrushStart",EffectEndTag="CrushStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Down_Boost',EffectSocket="Wing_Rt_Socket")
   VehicleEffects(6)=(EffectStartTag="MantaWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Gun_MuzzleFlash',EffectSocket="Gun_Socket_02")
   VehicleEffects(7)=(EffectStartTag="MantaWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Gun_MuzzleFlash',EffectSocket="Gun_Socket_01")
   VehicleEffects(8)=(bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Up_Boost',EffectSocket="Wing_Lft_Socket")
   VehicleEffects(9)=(bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Up_Boost',EffectSocket="Wing_Rt_Socket")
   VehicleEffects(10)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Manta',EffectSocket="DamageSmoke01")
   VehicleEffects(11)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.P_FX_Manta_Blades_Blurred',EffectSocket="BladeSocket")
   VehicleEffects(12)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Ground_FX',EffectSocket="Wing_Lft_Socket")
   VehicleEffects(13)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Ground_FX',EffectSocket="Wing_Rt_Socket")
   VehicleEffects(14)=(EffectStartTag="MantaOnFire",EffectEndTag="MantaNormal",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="Wing_Lft_Socket")
   VehicleEffects(15)=(EffectStartTag="MantaOnFire",EffectEndTag="MantaNormal",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="Wing_Rt_Socket")
   VehicleEffects(16)=(EffectStartTag="MantaOnFire",EffectEndTag="MantaNormal",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="Gun_Socket_01")
   VehicleEffects(17)=(EffectStartTag="MantaOnFire",EffectEndTag="MantaNormal",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="Gun_Socket_02")
   VehicleEffects(18)=(EffectStartTag="MantaOnFire",EffectEndTag="MantaNormal",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="ExhaustPort")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=1.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.500000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=1.500000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Front",InfluenceBone="Damage_LtCanard",Health=70,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_Right",InfluenceBone="Damage_RtRotor",Health=70,DamagePropNames=("Damage3"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_Left",InfluenceBone="Damage_LtRotor",Health=70,DamagePropNames=("Damage3"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_Rear",InfluenceBone="Hatch",Health=70,DamagePropNames=("Damage1"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Manta.Materials.MI_VH_Manta_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Manta.Materials.MI_VH_Manta_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Explode'
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   IconCoords=(U=859.000000,V=0.000000,UL=36.000000,VL=27.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Manta.Materials.MI_VH_Manta_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Manta.Materials.MI_VH_Manta_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Manta.Materials.MITV_VH_Manta_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Manta.Materials.MITV_VH_Manta_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_Reaper.BotStatus.A_BotStatus_Reaper_EnemyManta'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyManta'
   HudCoords=(U=228.000000,V=143.000000,UL=-119.000000,VL=106.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Manta:SimObject'
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Manta:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:RThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:RThruster'
   End Object
   Wheels(0)=RThruster
   Begin Object Class=UTHoverWheel Name=LThruster ObjName=LThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:LThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:LThruster'
   End Object
   Wheels(1)=LThruster
   Begin Object Class=UTHoverWheel Name=FThruster ObjName=FThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:FThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Manta:FThruster'
   End Object
   Wheels(2)=FThruster
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_4 ObjName=MyStayUprightSetup_4 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Manta:MyStayUprightSetup_4'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Manta:MyStayUprightSetup_4'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Manta_Content:MyStayUprightSetup_4'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_4 ObjName=MyStayUprightConstraintInstance_4 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Manta:MyStayUprightConstraintInstance_4'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Manta:MyStayUprightConstraintInstance_4'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Manta_Content:MyStayUprightConstraintInstance_4'
   Begin Object Class=AudioComponent Name=MantaEngineSound ObjName=MantaEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_EngineLoop'
      Name="MantaEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=MantaEngineSound
   CollisionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Stop'
   EngineStartOffsetSecs=0.500000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Manta:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Manta.Mesh.SK_VH_Manta'
      AnimTreeTemplate=AnimTree'VH_Manta.Anims.AT_Manta'
      PhysicsAsset=PhysicsAsset'VH_Manta.Mesh.SK_VH_Manta_Physics'
      MorphSets(0)=MorphTargetSet'VH_Manta.Mesh.VH_Manta_MorphTargets'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Manta:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Manta:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=100.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Manta:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=MantaEngineSound
   Components(5)=BaseScrapeSound
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Manta_Content"
   ObjectArchetype=UTVehicle_Manta'UTGame.Default__UTVehicle_Manta'
}
