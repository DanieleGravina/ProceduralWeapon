/**
 * DemoPawn
 * Demo pawn demonstrating animating character.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class DemoPawn extends GamePawn
	config(Game);

var(Mesh) SkeletalMeshComponent 	HeadMesh;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	if ( HeadMesh != None )
		HeadMesh.SetShadowParent(Mesh);
	SetBaseEyeheight();
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	return false;
}

simulated function SetBaseEyeheight()
{
	local string MapName;

	// hack for old larger scale demo levels (PhysicsExpanded, EffectsDemo, CityStreet
	MapName = WorldInfo.GetLocalURL();

	// strip the UEDPIE_ from the filename, if it exists (meaning this is a Play in Editor game)
	if (Left(MapName, 7) ~= "UEDPIE_")
	{
		MapName = Right(MapName, Len(MapName) - 7);
	}
	if ( !bIsCrouched && ((Left(MapName,15) ~= "PhysicsExpanded") || (Left(MapName,11) ~= "EffectsDemo") || (Left(MapName,10) ~= "CityStreet"))  )
	{
		BaseEyeheight = 96;
	}
	else
	{
		super.SetBaseEyeheight();
	}
}

defaultproperties
{
   BaseEyeHeight=38.000000
   EyeHeight=38.000000
   Begin Object Class=SkeletalMeshComponent Name=DemoPawnSkeletalMeshComponent ObjName=DemoPawnSkeletalMeshComponent Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
      AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
      PhysicsAsset=PhysicsAsset'CH_AnimHuman.Mesh.SK_CH_BaseMale_Physics'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      bOwnerNoSee=True
      BlockRigidBody=True
      Translation=(X=0.000000,Y=0.000000,Z=8.000000)
      Name="DemoPawnSkeletalMeshComponent"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=DemoPawnSkeletalMeshComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'GameFramework.Default__GamePawn:CollisionCylinder'
      CollisionHeight=44.000000
      CollisionRadius=21.000000
      ObjectArchetype=CylinderComponent'GameFramework.Default__GamePawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'GameFramework.Default__GamePawn:Arrow'
      ObjectArchetype=ArrowComponent'GameFramework.Default__GamePawn:Arrow'
   End Object
   Components(1)=Arrow
   Components(2)=DemoPawnSkeletalMeshComponent
   CollisionComponent=CollisionCylinder
   Name="Default__DemoPawn"
   ObjectArchetype=GamePawn'GameFramework.Default__GamePawn'
}
