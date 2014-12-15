/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_HealthVial extends UTHealthPickupFactory
	native;

/** list of adjacent vials; used to adjust AI ratings for vial groups */
var array<UTPickupFactory_HealthVial> AdjacentVials;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == ROLE_Authority)
	{
		if (AdjacentVials.length == 0)
		{
			FindAdjacentVials(AdjacentVials, self);
			MaxDesireability += 0.5 * MaxDesireability * AdjacentVials.length;
		}
	}
}

/** adds all adjacent vials to the given array
 * recursive, so it detects strung out vial groups and such
 */
function FindAdjacentVials(out array<UTPickupFactory_HealthVial> InAdjacentVials, UTPickupFactory_HealthVial InitialCaller)
{
	local int i;
	local UTPickupFactory_HealthVial OtherVial;

	for (i = 0; i < PathList.length; i++)
	{
		if (PathList[i] != None && PathList[i].Distance < 150 && AdvancedReachSpec(PathList[i]) == None)
		{
			OtherVial = UTPickupFactory_HealthVial(PathList[i].End.Nav);
			if (OtherVial != None && OtherVial != InitialCaller && InAdjacentVials.Find(OtherVial) == INDEX_NONE)
			{
				InAdjacentVials.AddItem(OtherVial);
				OtherVial.FindAdjacentVials(InAdjacentVials, InitialCaller);
			}
		}
	}
}

/**
 * Give the benefit of this pickup to the recipient
 */
function SpawnCopyFor( Pawn Recipient )
{
	// Give health to recipient
	Recipient.Health += HealAmount(Recipient);

	Recipient.MakeNoise(0.1);
	PlaySound( PickupSound );

	if ( PlayerController(Recipient.Controller) != None )
	{
		PlayerController(Recipient.Controller).ReceiveLocalizedMessage(MessageClass,,,,class);
	}

	// not sure why this didn't call the super, but I need the pickflags to update and it looks like that stat would never update
	if ( UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo) != None )
	{
		UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo).IncrementPickupStat(GetPickupStatName());
	}
}

function float BotDesireability(Pawn P, Controller C)
{
	local int OldHealingAmount, i;
	local float Desire;

	OldHealingAmount = HealingAmount;

	// add rating for adjacent vials that bot can also use
	for (i = 0; i < AdjacentVials.length; i++)
	{
		if (AdjacentVials[i].ReadyToPickup(0.0))
		{
			HealingAmount += AdjacentVials[i].HealingAmount;
		}
	}

	Desire = Super.BotDesireability(P, C);
	HealingAmount = OldHealingAmount;

	return Desire;
}

auto state Pickup
{
	/* DetourWeight()
	value of this path to take a quick detour (usually 0, used when on route to distant objective, but want to grab inventory for example)
	*/
	function float DetourWeight(Pawn Other,float PathWeight)
	{
		if ( PathWeight > 500 )
			return 0;

		return Super.DetourWeight(Other, PathWeight);
	}
}

defaultproperties
{
   HealingAmount=5
   bSuperHeal=True
   PickupSound=SoundCue'A_Pickups.Health.Cue.A_Pickups_Health_Small_Cue_Modulated'
   PickupMessage="Fiala di energia"
   bRotatingPickup=True
   bFloatingPickup=True
   bRandomStart=True
   YawRotationRate=32000.000000
   BobOffset=5.000000
   BobSpeed=4.000000
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   MaxDesireability=0.300000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTHealthPickupFactory:CollisionCylinder'
      CollisionHeight=20.000000
      CollisionRadius=30.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTHealthPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTHealthPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTHealthPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:BaseMeshComp'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Begin Object Class=StaticMeshComponent Name=HealthPickUpMesh ObjName=HealthPickUpMesh Archetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
      StaticMesh=StaticMesh'PICKUPS.Health_Small.Mesh.S_Pickups_Health_Small'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
   End Object
   Components(4)=HealthPickUpMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_HealthVial"
   ObjectArchetype=UTHealthPickupFactory'UTGame.Default__UTHealthPickupFactory'
}
