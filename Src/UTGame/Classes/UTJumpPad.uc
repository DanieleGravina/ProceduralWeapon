/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================
// UTJumppad - bounces players/bots up
//
//=============================
class UTJumpPad extends NavigationPoint
	native
	placeable
	hidecategories(VehicleUsage);

var		vector				JumpVelocity;
var()	PathNode			JumpTarget;
var()	SoundCue			JumpSound;
var()	float				JumpTime;
var()	float				JumpAirControl;
var AudioComponent			JumpAmbientSound;
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	if ( (UTPawn(Other) == None) || (Other.Physics == PHYS_None) || UTPawn(Other).IsHero() )
		return;

	PendingTouch = Other.PendingTouch;
	Other.PendingTouch = self;
}

event PostTouch(Actor Other)
{
	local UTPawn P;

	P = UTPawn(Other);
	if (P == None || P.Physics == PHYS_None || P.DrivenVehicle != None)
	{
		return;
	}
	if ( P.bNotifyStopFalling )
	{
		P.StoppedFalling();
	}

	if ( UTBot(P.Controller) != None )
	{
		if ( Other.GetGravityZ() > WorldInfo.DefaultGravityZ )
			UTBot(P.Controller).Focus = UTBot(P.Controller).FaceActor(2);
		else
			P.Controller.Focus = JumpTarget;
		P.Controller.Movetarget = JumpTarget;
		if ( P.Physics != PHYS_Flying )
			P.Controller.MoveTimer = 2.0;
		P.DestinationOffset = 50;
	}
	if ( P.Physics == PHYS_Walking )
	{
		P.SetPhysics(PHYS_Falling);
		P.bReadyToDoubleJump = true;
	}
	P.Velocity = JumpVelocity;
	if ( (WorldInfo.WorldGravityZ != WorldInfo.DefaultGravityZ) && (Other.GetGravityZ() == WorldInfo.WorldGravityZ) )
	{
		P.Velocity *= sqrt(Other.GetGravityZ()/WorldInfo.DefaultGravityZ);
	}
	P.AirControl = JumpAirControl;
	P.Acceleration = vect(0,0,0);
	if ( JumpSound != None )
		P.PlaySound(JumpSound);
}

event bool SuggestMovePreparation(Pawn Other)
{
	local Vehicle V;

	V = Vehicle(Other);
	if (V != None)
	{
		V.DriverLeave(false);
	}

	return false;
}

defaultproperties
{
   JumpSound=SoundCue'A_Gameplay.JumpPad.Cue.A_Gameplay_JumpPad_Activate_Cue'
   JumpTime=2.000000
   JumpAirControl=0.050000
   Begin Object Class=AudioComponent Name=AmbientSound ObjName=AmbientSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.JumpPad.JumpPad_Ambient01Cue'
      bAutoPlay=True
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   JumpAmbientSound=AmbientSound
   bSpecialMove=True
   bDestinationOnly=True
   bBlockedForVehicles=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      CollideActors=True
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   GoodSprite=None
   BadSprite=None
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=DynamicLightEnvironmentComponent Name=JumpPadLightEnvironment ObjName=JumpPadLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="JumpPadLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(3)=JumpPadLightEnvironment
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.jump_pad.S_Pickups_Jump_Pad'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTJumpPad:JumpPadLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True)
      CollideActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-47.000000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(4)=StaticMeshComponent0
   Begin Object Class=UTParticleSystemComponent Name=ParticleSystemComponent1 ObjName=ParticleSystemComponent1 Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.jump_pad.P_Pickups_Jump_Pad_FX'
      Translation=(X=0.000000,Y=0.000000,Z=-35.000000)
      Name="ParticleSystemComponent1"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Components(5)=ParticleSystemComponent1
   Components(6)=AmbientSound
   bStatic=False
   bMovable=False
   bCollideActors=True
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTJumpPad"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
