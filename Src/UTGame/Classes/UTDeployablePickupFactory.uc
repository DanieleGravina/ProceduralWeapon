/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDeployablePickupFactory extends UTPickupFactory;

var() class<UTDeployable> DeployablePickupClass;

var bool bDelayRespawn;

simulated function InitializePickup()
{
	InventoryType = DeployablePickupClass;

	Super.InitializePickup();

	bIsSuperItem = true;
}

simulated function SetPickupMesh()
{
	Super.SetPickupMesh();

	if ( PickupMesh != none )
	{
		DeployablePickupClass.static.InitPickupMesh(PickupMesh);
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'DeployablePickupClass')
	{
		if (InventoryType != DeployablePickupClass)
		{
			DeployablePickupClass = class<UTDeployable>(InventoryType);
			Super.ReplicatedEvent(VarName);
		}
	}
	else
	{

		Super.ReplicatedEvent(VarName);
	}
}

function PickedUpBy(Pawn P)
{
	local UTPlayerController PC;

	Super.PickedUpBy(P);
	if ( DeployablePickupClass.Default.bCanDestroyBarricades )
	{
		// notify any players that have this as their objective
		ForEach WorldInfo.AllControllers(class'UTPlayerController', PC)
		{
			if  ( (PC.LastAutoObjective == self) && (PC != P.Controller) )
			{
				PC.CheckAutoObjective(true);
			}
		}
	}
}

function SpawnCopyFor( Pawn Recipient )
{
	local Inventory Inv;
	local UTDeployable Deployable;

	Inv = Spawn(InventoryType);
	if ( Inv != None )
	{
		Recipient.MakeNoise(0.5);
		Inv.GiveTo(Recipient);
		Inv.AnnouncePickup(Recipient);
		Deployable = UTDeployable(Inv);
		if ( (Deployable != None) && Deployable.bDelayRespawn )
		{
			bDelayRespawn = true;
			Deployable.Factory = self;
		}
		else
		{
			bDelayRespawn = false;
		}
	}
}

function StartSleeping()
{
	if ( bDelayRespawn )
	{
		GotoState('WaitingForDeployable');
	}
	else
	{
		super.StartSleeping();
	}
}

/** called when the deployable spawned by this factory has been used up */
function DeployableUsed(actor ChildDeployable)
{
	//`warn("called when not waiting for deployable in state "$GetStateName());
}

state WaitingForDeployable
{
	ignores Touch;

	function StartSleeping() {}

	function BeginState(name PrevStateName)
	{
		SetPickupHidden();

		Super.BeginState(PrevStateName);
		bPulseBase=false;
		StartPulse( BaseDimEmissive );
	}

	function DeployableUsed(actor ChildDeployable)
	{
		// now start normal respawn process
		GotoState('Sleeping');
	}

	function bool ReadyToPickup(float MaxWait)
	{
		return false;
	}

Begin:
}

function OnToggle(SeqAct_Toggle InAction)
{
	if (InAction.InputLinks[1].bHasImpulse || InAction.InputLinks[2].bHasImpulse)
	{
		GotoState('SleepInfinite');
	}
}

state SleepInfinite extends Sleeping
{
	function PulseThresholdMet() {}

	function OnToggle(SeqAct_Toggle InAction)
	{
		if (InAction.InputLinks[0].bHasImpulse || InAction.InputLinks[2].bHasImpulse)
		{
			GotoState('SleepInfinite', 'Respawn');
		}
	}

Begin:
	while (true)
	{
		Sleep(100000.0);
	}
}

defaultproperties
{
   bRotatingPickup=True
   BaseBrightEmissive=(R=1.000000,G=25.000000,B=1.000000,A=1.000000)
   BaseDimEmissive=(R=0.250000,G=5.000000,B=0.250000,A=1.000000)
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   bIsSuperItem=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPickupFactory:CollisionCylinder'
      BlockZeroExtent=False
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTPickupFactory:BaseMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Base_Deployable.Mesh.S_Pickups_Base_Deployable'
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   bBlockActors=True
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTDeployablePickupFactory"
   ObjectArchetype=UTPickupFactory'UTGame.Default__UTPickupFactory'
}
