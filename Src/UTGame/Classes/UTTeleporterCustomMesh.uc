/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** version of Teleporter that has a custom mesh/material */
class UTTeleporterCustomMesh extends Teleporter;

var() StaticMeshComponent Mesh;

/** Sound to be played when someone teleports in*/
var SoundCue TeleportingSound;

var UTPawn LastPawn;
var float LastTime;

simulated event bool Accept( actor Incoming, Actor Source )
{
	local UTPlayerReplicationInfo PRI;

	PRI = (Pawn(Incoming) != None) ? UTPlayerReplicationInfo(Pawn(Incoming).PlayerReplicationInfo) : None;
	if ( (PRI != None) && (UTOnslaughtFlag(PRI.GetFlag()) != None) )
	{
		PRI.GetFlag().Drop();
	}

	if (Super.Accept(Incoming,Source))
	{
		PlaySound(TeleportingSound);
		if ( UTPawn(Incoming) != None )
		{
			LastPawn = UTPawn(Incoming);
			LastTime = WorldInfo.TimeSeconds;
		}
		return true;
	}
	else
	{
		return false;
	}
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	if ( (Other == LastPawn) && (WorldInfo.TimeSeconds - LastTime < 0.2) )
	{
		return;
	}
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=PortalMesh ObjName=PortalMesh Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'EditorMeshes.TexPropPlane'
      Materials(0)=Material'EngineMaterials.ScreenMaterial'
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=125.000000)
      Name="PortalMesh"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Mesh=PortalMesh
   TeleportingSound=SoundCue'A_Gameplay.Portal.Portal_WalkThrough01Cue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Teleporter:CollisionCylinder'
      CollisionHeight=30.000000
      CollisionRadius=50.000000
      CollideActors=False
      ObjectArchetype=CylinderComponent'Engine.Default__Teleporter:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Teleporter:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Teleporter:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__Teleporter:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__Teleporter:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__Teleporter:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__Teleporter:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__Teleporter:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__Teleporter:PathRenderer'
   End Object
   Components(4)=PathRenderer
   Components(5)=PortalMesh
   CollisionComponent=PortalMesh
   Name="Default__UTTeleporterCustomMesh"
   ObjectArchetype=Teleporter'Engine.Default__Teleporter'
}
