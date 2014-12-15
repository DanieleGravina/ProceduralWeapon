/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_StealthBender_Content extends UTVehicle_StealthBender;

/** MIs for the turret **/
var MaterialInterface BurnOutTurret[2];


simulated function SetBurnOut()
{
	local int TeamNum;

	TeamNum = GetTeamNum();

	if( TeamNum > 1 )
	{
		TeamNum = 0;
	}

	// set our specific turret BurnOut Material
	if (BurnOutTurret[TeamNum] != None)
	{
		Mesh.SetMaterial( 1, BurnOutTurret[TeamNum] );
	}

	// sets the MIC
	super.SetBurnOut();
}

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_StealthBender:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_StealthBender:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Begin Object Class=UTVehicleSimHellbender Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_StealthBender:SimObject'
      ObjectArchetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_StealthBender:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleHellbenderWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RRWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LRWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:RFWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_StealthBender:LFWheel'
   End Object
   Wheels(3)=LFWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_7 ObjName=MyStayUprightSetup_7 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_StealthBender:MyStayUprightSetup_7'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_StealthBender:MyStayUprightSetup_7'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_StealthBender_Content:MyStayUprightSetup_7'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_7 ObjName=MyStayUprightConstraintInstance_7 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_StealthBender:MyStayUprightConstraintInstance_7'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_StealthBender:MyStayUprightConstraintInstance_7'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_StealthBender_Content:MyStayUprightConstraintInstance_7'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_StealthBender:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_StealthBender:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_StealthBender:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_StealthBender:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_StealthBender_Content"
   ObjectArchetype=UTVehicle_StealthBender'UTGame.Default__UTVehicle_StealthBender'
}
