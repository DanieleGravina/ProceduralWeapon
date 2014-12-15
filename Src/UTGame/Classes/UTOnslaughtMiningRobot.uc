/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtMiningRobot extends GamePawn
	notplaceable
	native
	abstract;

var UTOnslaughtTarydiumProcessor Home;
var staticmeshcomponent CarriedOre;
var repnotify bool bIsCarryingOre;
var repnotify bool bIsWorking;
var soundcue ExplosionSound;
var particlesystem ExplosionTemplate;

var float OreQuantity;

var UTOnslaughtNodeObjective ControllingNode;

replication
{
	if (bNetDirty)
		bIsCarryingOre, bIsWorking;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	CarriedOre.SetHidden(true);
	SpawnDefaultController();
}

simulated native function byte GetTeamNum();

simulated event ReplicatedEvent(name VarName)
{
	if ( VarName == 'bIsCarryingOre' )
	{
		SetCarryingOre(bIsCarryingOre);
	}
	else if (VarName == 'bIsWorking')
	{
		if (bIsWorking)
		{
			StartWorking();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function SetCarryingOre(bool bNewValue)
{
	bIsWorking = false;
	bIsCarryingOre = bNewValue;
	CarriedOre.SetHidden(!bIsCarryingOre);
}

simulated function StartWorking()
{
	bIsWorking = true;
}

simulated function Destroyed()
{
	Super.Destroyed();

	if ( Home != None )
	{
		Home.MinerDestroyed();
	}

	// blow up
	if ( (WorldInfo.NetMode != NM_DedicatedServer) && (ExplosionTemplate != None) && EffectIsRelevant(Location,false,5000) )
	{
		WorldInfo.MyEmitterPool.SpawnEmitter(ExplosionTemplate, Location, Rotation);
	}

	if (ExplosionSound != None)
	{
		PlaySound(ExplosionSound, true);
	}
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	if ( Controller != None )
		Controller.Destroy();
	Destroy();
}

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'GameFramework.Default__GamePawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'GameFramework.Default__GamePawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'GameFramework.Default__GamePawn:Sprite'
      ObjectArchetype=SpriteComponent'GameFramework.Default__GamePawn:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'GameFramework.Default__GamePawn:Arrow'
      ObjectArchetype=ArrowComponent'GameFramework.Default__GamePawn:Arrow'
   End Object
   Components(2)=Arrow
   CollisionComponent=CollisionCylinder
   Name="Default__UTOnslaughtMiningRobot"
   ObjectArchetype=GamePawn'GameFramework.Default__GamePawn'
}
