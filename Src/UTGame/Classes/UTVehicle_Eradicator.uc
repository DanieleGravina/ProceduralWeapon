/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Eradicator extends UTVehicle
	native(Vehicle)
	abstract;

/** These values are used in positioning the weapons */
var repnotify	rotator	GunnerWeaponRotation;
var	repnotify	vector	GunnerFlashLocation;
var	repnotify	byte	GunnerFlashCount;
var repnotify	byte	GunnerFiringMode;

/** Coordinates for the Camera Fire tooltip textures */
var UIRoot.TextureCoordinates CameraFireToolTipIconCoords;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if (bNetDirty)
		GunnerFlashLocation;
	if (!IsSeatControllerReplicationViewer(0) || bDemoRecording)
		GunnerFlashCount, GunnerFiringMode, GunnerWeaponRotation;
}

native simulated function vector GetTargetLocation(optional Actor RequestedBy, optional bool bRequestAlternateLoc);

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	
	if ( !bDeleteMe )
	{
		SetTimer(2.0, false, 'FixPosition');
	}
}

function FixPosition()
{
	SetPhysics(PHYS_None);
}

function bool OpenPositionFor(Pawn P)
{
	// ignore extra seat because driver controls it as well
	return !Occupied();
}

function SetTeamNum(byte T)
{
	if (Controller != None && Controller.GetTeamNum() != T)
	{
		DriverLeave(true);
	}

	// restore health and return to initial position when changing hands
	if (T != GetTeamNum())
	{
		Health = HealthMax;
	}

	Super.SetTeamNum(T);
}

/**
*	Because WeaponRotation is used to drive seat 1 - it will be replicated when you are in the big turret because bNetOwner is FALSE.
*	We don't want it replicated though, so we discard it when we receive it.
*/
simulated event ReplicatedEvent(name VarName)
{
	if ( VarName == 'WeaponRotation' && Seats[0].SeatPawn != None && Seats[0].SeatPawn.Controller != None )
	{
		return;
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
	local PlayerController PC;
	local UTVWeap_SPMACannon Gun;

	super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);

	PC = PlayerController(Seats[0].SeatPawn.Controller);
	Gun = UTVWeap_SPMACannon(Seats[0].Gun);
	if ( PC != none && Gun != None )
	{
		if ( Gun.RemoteCamera == None )
		{
			Hud.DrawToolTip(Canvas, PC, "GBA_Fire", Canvas.ClipX * 0.5, Canvas.ClipY * 0.92, CameraFireToolTipIconCoords.U, CameraFireToolTipIconCoords.V, CameraFireToolTipIconCoords.UL, CameraFireToolTipIconCoords.VL, Canvas.ClipY / 768);
		}
	}
}

//=================================
// AI Interface

function bool ImportantVehicle()
{
	return true;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

function bool CanDeployedAttack(Actor Other)
{
	local UTVWeap_SPMACannon Gun;
	
	Gun = UTVWeap_SPMACannon(Seats[0].Gun);
	if ( Gun != None )
	{
		return Gun.CanAttack(Other);
	}
	else
	{
		return CanAttack(Other);
	}
}

function DriverLeft()
{
	local UTVWeap_SPMACannon Gun;

	Super.DriverLeft();

	Gun = UTVWeap_SPMACannon(Seats[0].Gun);
	if (Gun != None && Gun.RemoteCamera != None )
	{
		Gun.RemoteCamera.Disconnect();
	}
}

function bool IsArtillery()
{
	return true;
}

function PassengerLeave(int SeatIndex)
{
	local UTVWeap_SPMACannon Gun;

	Super.PassengerLeave(SeatIndex);

	Gun = UTVWeap_SPMACannon(Seats[0].Gun);

	if ( Gun != none && Gun.RemoteCamera != none )
	{
		Gun.RemoteCamera.Disconnect();
	}
}

defaultproperties
{
   bEnteringUnlocks=False
   AIPurpose=AIP_Any
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   MaxDesireability=0.600000
   HornIndex=1
   HUDExtent=140.000000
   ChargeBarPosY=7.000000
   SeatCameraScale=2.500000
   COMOffset=(X=0.000000,Y=0.000000,Z=-100.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Eradicator:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Eradicator:MyStayUprightConstraintInstance'
   bTurnInPlace=True
   bSeparateTurretFocus=True
   MomentumMult=0.300000
   bStationary=True
   NonPreferredVehiclePathMultiplier=2.000000
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   Health=800
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   bHasAlternateTargetLocation=True
   bHardAttach=True
   bBlocksNavigation=True
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Eradicator"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
