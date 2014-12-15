/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGreedFlag extends UTCTFFlag;

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local Controller C;

	Super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if ( Pawn(Other) != None )
	{
		C = Pawn(Other).Controller;
		if ( C != None && !WorldInfo.GRI.OnSameTeam(self, C) )
		{
			OpposingTeamTouch(C);
		}
	}
}

function bool ValidHolder(Actor Other)
{
	// Flags in the Greed gametype should only act as a base, and cannot be carried
	return false;
}

function SameTeamTouch(Controller C)
{
}

function OpposingTeamTouch(Controller C)
{
	UTGreedGame(WorldInfo.Game).ScoreCoinReturn(C);
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=TheFlagSkelMesh ObjName=TheFlagSkelMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTCTFFlag:TheFlagSkelMesh'
   End Object
   SkelMesh=TheFlagSkelMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=FlagLightEnvironment ObjName=FlagLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTCTFFlag:FlagLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTCTFFlag:FlagLightEnvironment'
   End Object
   LightEnvironment=FlagLightEnvironment
   Begin Object Class=PointLightComponent Name=FlagLightComponent ObjName=FlagLightComponent Archetype=PointLightComponent'UTGame.Default__UTCTFFlag:FlagLightComponent'
      ObjectArchetype=PointLightComponent'UTGame.Default__UTCTFFlag:FlagLightComponent'
   End Object
   FlagLight=FlagLightComponent
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTCTFFlag:CollisionCylinder'
      CollisionRadius=80.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTCTFFlag:CollisionCylinder'
   End Object
   Components(0)=CollisionCylinder
   Components(1)=FlagLightComponent
   Components(2)=FlagLightEnvironment
   Components(3)=TheFlagSkelMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTGreedFlag"
   ObjectArchetype=UTCTFFlag'UTGame.Default__UTCTFFlag'
}
