/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTFlockSpawner_Human extends FlockTest_Spawner
	placeable;

defaultproperties
{
   ActionDuration=(Distribution=DistributionActionDuration)
   ActionInterval=(Distribution=DistributionActionInterval)
   TargetActionInterval=(Distribution=DistributionTargetActionInterval)
   ActionAnimNames(0)="idle_ready_rif"
   TargetActionAnimNames(0)="fire_straight_rif"
   FlockMeshes(0)=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
   FlockAnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
   WalkAnimName="crouch_fwd_rif"
   RunAnimName="run_fwd_rif"
   FlockAnimTree=AnimTree'CH_AnimHuman_Tree.AT_CH_Flock_Human'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__FlockTest_Spawner:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__FlockTest_Spawner:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTFlockSpawner_Human"
   ObjectArchetype=FlockTest_Spawner'UTGame.Default__FlockTest_Spawner'
}
