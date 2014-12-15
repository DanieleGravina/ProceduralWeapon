//=============================================================================
// ForcedDirVolume
// used to force UTVehicles [of a certain class if wanted] in a certain direction
//
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class ForcedDirVolume extends PhysicsVolume
	placeable
	native;

var() bool bAllowBackwards; // allows negative forces, thus trapping vehicles on a line instead of in a direction
var() class<UTVehicle> TypeToForce;
var() bool bIgnoreHoverboards;
var() const ArrowComponent Arrow;
var() bool bDenyExit; // if the vehicle is being effected by a force volume, the player cannot exit the vehicle.
var() bool bBlockPawns;
var() bool bBlockSpectators;
var() bool bDontBlockRedeemers;
var vector ArrowDirection;
var array<UTVehicle> TouchingVehicles;
var	float	VehiclePushMag;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function PostBeginPlay()
{
	local string MapName;

	super.PostBeginPlay();
	
	if ( !bBlockSpectators && (BrushComponent != None) )
	{
		BrushComponent.SetTraceBlocking(false,true);
	}
	if ( Name == 'ForcedDirVolume_0' )
	{
		// hack don't block redeemers in islander
		MapName = WorldInfo.GetMapName();
		if ( Left(MapName, 8) ~= "ISLANDER" )
		{
			bDontBlockRedeemers = true;
		}
	}
	else if ( Name == 'ForcedDirVolume_16' )
	{
		// hack block raptors from core in confrontation
		MapName = WorldInfo.GetMapName();
		if ( Left(MapName, 13) ~= "CONFRONTATION" )
		{
			VehiclePushMag = 4000.0;
			TypeToForce = class'UTVehicle';
		}
	}
	else if ( Name == 'ForcedDirVolume_17' )
	{
		// hack block raptors from core in confrontation
		MapName = WorldInfo.GetMapName();
		if ( Left(MapName, 13) ~= "CONFRONTATION" )
		{
			VehiclePushMag = 4000.0;
			TypeToForce = class'UTVehicle';
		}
	}
}

event ActorEnteredVolume(Actor Other)
{
	if ( PlayerController(Other) != None )
	{
		Other.FellOutOfWorld(None);
	}
}

simulated event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UTVehicle V;

	Super.Touch(Other, OtherComp, HitLocation, HitNormal);

	V = UTVehicle(Other);
	if ((V != None) && ClassIsChildOf(V.Class, TypeToForce) && V.OnTouchForcedDirVolume(self))
	{
		TouchingVehicles.AddItem(V);
		if (bDenyExit)
		{
			V.bAllowedExit = false;
		}
	}
	else if ( UTRemoteRedeemer(Other) != None )
	{
		if ( !bDontBlockRedeemers )
		{
		UTRemoteRedeemer(Other).ForcedDirectionVolume = self;
	}
	}
	else if ( (UTProj_SPMACamera(Other) != None) && (Other.Role == ROLE_Authority) )
	{
		if ( !UTProj_SPMACamera(Other).bDeployed )
			UTProj_SPMACamera(Other).Deploy();
	}
}

simulated event UnTouch(Actor Other)
{
	local bool bInAnotherVolume;
	local ForcedDirVolume AnotherVolume;

	if (ClassIsChildOf(Other.class, TypeToForce))
	{
		TouchingVehicles.RemoveItem(UTVehicle(Other));
		if (bDenyExit)
		{
			foreach Other.TouchingActors(class'ForcedDirVolume', AnotherVolume)
			{
				if (AnotherVolume.bDenyExit)
				{
					bInAnotherVolume = true;
					break;
				}
			}
			if (!bInAnotherVolume)
			{
				UTVehicle(Other).bAllowedExit = UTVehicle(Other).default.bAllowedExit;
			}
		}
	}
}

simulated function bool StopsProjectile(Projectile P)
{
	return false;
}

defaultproperties
{
   bBlockSpectators=True
   TypeToForce=Class'UTGame.UTVehicle'
   Begin Object Class=ArrowComponent Name=AC ObjName=AC Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=150,G=100,R=150,A=255)
      ArrowSize=5.000000
      AbsoluteRotation=True
      Name="AC"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Arrow=AC
   VehiclePushMag=1100.000000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
      BlockActors=True
      BlockRigidBody=True
      RBChannel=RBCC_Untitled4
      ObjectArchetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   Components(1)=AC
   bStatic=False
   bPushedByEncroachers=False
   bMovable=False
   bBlockActors=True
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__ForcedDirVolume"
   ObjectArchetype=PhysicsVolume'Engine.Default__PhysicsVolume'
}
