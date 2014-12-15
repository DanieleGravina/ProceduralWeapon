/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtNodeEnhancement extends UTGameObjective
	native
	abstract;

var() UTOnslaughtNodeObjective ControllingNode;	/** Level designer can set, or it is auto-assigned to nearest bunker */

replication
{
	if (bNetInitial)
		ControllingNode;
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( (Role == ROLE_Authority) && (ControllingNode != None) )
	{
		SetControllingNode(ControllingNode);
	}
}

simulated function string GetLocationStringFor(PlayerReplicationInfo PRI)
{
	if ( ControllingNode != None )
	{
		return ControllingNode.GetLocationStringFor(PRI);
	}
	return LocationPrefix$GetHumanReadableName()$LocationPostfix;
}

function SetControllingNode(UTOnslaughtNodeObjective NewControllingNode)
{
	ControllingNode = NewControllingNode;
	ControllingNode.Enhancements[ControllingNode.Enhancements.Length] = self;
}

simulated function UpdateTeamEffects();

function Activate()
{
	DefenderTeamIndex = GetTeamNum();
	UpdateTeamEffects();
}

function Deactivate()
{
	DefenderTeamIndex = 2;
	UpdateTeamEffects();
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'DefenderTeamIndex')
	{
		UpdateTeamEffects();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

function TarydiumBoost(float Quantity);

simulated native function byte GetTeamNum();

defaultproperties
{
   HudMaterial=None
   IconHudTexture=None
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTGameObjective:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTGameObjective:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTGameObjective:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTGameObjective:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTGameObjective:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTGameObjective:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTGameObjective:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTGameObjective:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTGameObjective:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTGameObjective:PathRenderer'
   End Object
   Components(4)=PathRenderer
   RemoteRole=ROLE_SimulatedProxy
   bStatic=False
   bAlwaysRelevant=True
   bMovable=False
   bCollideActors=True
   bCollideWorld=True
   bBlockActors=True
   CollisionComponent=CollisionCylinder
   Name="Default__UTOnslaughtNodeEnhancement"
   ObjectArchetype=UTGameObjective'UTGame.Default__UTGameObjective'
}
