/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDeployedActor extends Actor
	abstract
	native;

/** Who owns this */
var Controller	InstigatorController;

/** Owner team number */
var byte TeamNum;

/** The Mesh */
var MeshComponent Mesh;

/** Here on the hud to display it */
var vector HudLocation;

/** The deployable's light environment */
var DynamicLightEnvironmentComponent LightEnvironment;

var repnotify bool bDeployed;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
replication
{
	if (Role == ROLE_Authority && bNetDirty)
		TeamNum, bDeployed;
}

/** We use a delegate so that different types of creators can get the OnDestroyed event */
delegate OnDeployableUsedUp(actor ChildDeployable);

simulated function Destroyed()
{
	Super.Destroyed();

	if (Role == ROLE_Authority)
	{
		// Notify the actor that controls this
		OnDeployableUsedUp(self);
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Instigator != None)
	{
		InstigatorController = Instigator.Controller;
		TeamNum = Instigator.GetTeamNum();
	}
}

event BaseChange()
{
	if ( bDeployed && (Base == None) && !bDeleteMe )
	{
		Destroy();
	}
}

/**
 * HurtRadius()
 * Hurt locally authoritative actors within the radius.
 */
simulated function bool HurtRadius( float DamageAmount,
								    float InDamageRadius,
				    class<DamageType> DamageType,
									float Momentum,
									vector HurtOrigin,
									optional actor IgnoredActor,
									optional Controller InstigatedByController = Instigator != None ? Instigator.Controller : None,
									optional bool bDoFullDamage
									)
{
	if ( bHurtEntry )
		return false;

	if (InstigatedByController == None)
	{
		InstigatedByController = InstigatorController;
	}

	return Super.HurtRadius(DamageAmount, InDamageRadius, DamageType, Momentum, HurtOrigin, None, InstigatedByController, bDoFullDamage);
}

simulated event ReplicatedEvent(name VarName)
{
	if ( VarName == 'bDeployed' )
	{
		PerformDeploy();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function PerformDeploy();

simulated native function byte GetTeamNum();

/** function used to update where icon for this actor should be rendered on the HUD
 *  @param NewHUDLocation is a vector whose X and Y components are the X and Y components of this actor's icon's 2D position on the HUD
 */
simulated native function SetHUDLocation(vector NewHUDLocation);

function Reset()
{
	Destroy();
}

simulated event Attach(Actor Other)
{
}

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="DeployedLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Physics=PHYS_Falling
   RemoteRole=ROLE_SimulatedProxy
   bReplicateInstigator=True
   bCollideActors=True
   bCollideWorld=True
   bCollideComplex=True
   bBlockActors=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTDeployedActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
