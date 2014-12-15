/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_SpiderMine extends UTProj_SpiderMineBase;

simulated function bool ProjectileHurtRadius( float DamageAmount, float InDamageRadius, class<DamageType> DamageType, float Momentum,
						vector HurtOrigin, vector HitNormal, optional class<DamageType> ImpactedActorDamageType )
{
	// override ImpactedActorDamageType with special damagetype that does the 1P death effect
	if (ImpactedActorDamageType == None)
	{
		ImpactedActorDamageType = class'UTDmgType_SpiderMineDirectHit';
	}
	return Super.ProjectileHurtRadius(DamageAmount, InDamageRadius, DamageType, Momentum, HurtOrigin, HitNormal, ImpactedActorDamageType);
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Spider_3P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTProj_SpiderMine:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Spider_3P'
      bUpdateSkelWhenNotRendered=False
      Materials(0)=Material'PICKUPS.Deployables.Materials.M_Deployables_Spider_VRed'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_SpiderMine:MyLightEnvironment'
      CullDistance=6000.000000
      CachedCullDistance=6000.000000
      bUseAsOccluder=False
      Translation=(X=0.000000,Y=0.000000,Z=-11.000000)
      Name="MeshComponentA"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=MeshComponentA
   Begin Object Class=AudioComponent Name=AmbientAudio ObjName=AmbientAudio Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_WalkLoopCue'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientAudio"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   WalkingSoundComponent=AmbientAudio
   Begin Object Class=AudioComponent Name=AttackScreech ObjName=AttackScreech Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_AttackScreechCue'
      bStopWhenOwnerDestroyed=True
      Name="AttackScreech"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AttackScreechSoundComponent=AttackScreech
   ExplosionSound=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMines_ExplodesCue'
   ProjExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'
   ExplosionLightClass=Class'UTGame.UTRocketExplosionLight'
   MyDamageType=Class'UTGameContent.UTDmgType_SpiderMine'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_SpiderMineBase:CollisionCylinder'
      CollisionHeight=10.000000
      CollisionRadius=10.000000
      CollideActors=True
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_SpiderMineBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      AmbientGlow=(R=0.400000,G=0.400000,B=0.400000,A=1.000000)
      ModShadowFadeoutTime=1.000000
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(1)=MyLightEnvironment
   Components(2)=MeshComponentA
   Components(3)=AmbientAudio
   Components(4)=AttackScreech
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SpiderMine"
   ObjectArchetype=UTProj_SpiderMineBase'UTGame.Default__UTProj_SpiderMineBase'
}
