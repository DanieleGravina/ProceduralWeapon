/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPawn_WeldingRobot extends UTPawn;


event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	// hack here so we don't have to modify Pawn's TakeDamage this late in the dev cycle.
	if( !AffectedByHitEffects() )
	{
		Momentum = vect(0,0,0);
	}

	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}



// this is the anim he has
//Robot_WeldingIdle

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPawn:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   SoundGroupClass=Class'UTGame.UTPawnSoundGroup_Liandri'
   Begin Object Class=ParticleSystemComponent Name=GooDeath ObjName=GooDeath Archetype=ParticleSystemComponent'UTGame.Default__UTPawn:GooDeath'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTPawn:GooDeath'
   End Object
   BioBurnAway=GooDeath
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonArms ObjName=FirstPersonArms Archetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceA'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceA'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTPawn_WeldingRobot:FirstPersonArms.MeshSequenceA'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms'
   End Object
   ArmsMesh(0)=FirstPersonArms
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonArms2 ObjName=FirstPersonArms2 Archetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms2'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceB ObjName=MeshSequenceB Archetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTPawn:MeshSequenceB'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTPawn_WeldingRobot:FirstPersonArms2.MeshSequenceB'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTPawn:FirstPersonArms2'
   End Object
   ArmsMesh(1)=FirstPersonArms2
   Begin Object Class=UTAmbientSoundComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent'
      ObjectArchetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent'
   End Object
   PawnAmbientSound=AmbientSoundComponent
   Begin Object Class=UTAmbientSoundComponent Name=AmbientSoundComponent2 ObjName=AmbientSoundComponent2 Archetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent2'
      ObjectArchetype=UTAmbientSoundComponent'UTGame.Default__UTPawn:AmbientSoundComponent2'
   End Object
   WeaponAmbientSound=AmbientSoundComponent2
   Begin Object Class=SkeletalMeshComponent Name=OverlayMeshComponent0 ObjName=OverlayMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTPawn:OverlayMeshComponent0'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTPawn:OverlayMeshComponent0'
   End Object
   OverlayMesh=OverlayMeshComponent0
   DefaultFamily=Class'UTGame.UTFamilyInfo_Liandri_Male'
   ControllerClass=Class'UTGameContent.UTPawn_WeldingRobotController'
   Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent ObjName=WPawnSkeletalMeshComponent Archetype=SkeletalMeshComponent'UTGame.Default__UTPawn:WPawnSkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'CH_Corrupt_Cine.Mesh.SK_CH_WeldingRobot'
      PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      AnimSets(1)=AnimSet'CH_Corrupt_Cine.Mesh.K_CH_WeldingRobot'
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTPawn:WPawnSkeletalMeshComponent'
   End Object
   Mesh=WPawnSkeletalMeshComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTPawn:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTPawn:Arrow'
   End Object
   Components(1)=Arrow
   Components(2)=MyLightEnvironment
   Components(3)=WPawnSkeletalMeshComponent
   Components(4)=AmbientSoundComponent
   Components(5)=AmbientSoundComponent2
   CollisionComponent=CollisionCylinder
   Name="Default__UTPawn_WeldingRobot"
   ObjectArchetype=UTPawn'UTGame.Default__UTPawn'
}
