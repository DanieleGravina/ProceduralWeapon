/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory extends PickupFactory
	abstract
	native
	nativereplication
	hidecategories(Display,Collision,PickupFactory);

var		bool			bRotatingPickup;	// if true, the pickup mesh rotates
var		float			YawRotationRate;
var		Controller		TeamOwner[4];		// AI controller currently going after this pickup (for team coordination)

/**  pickup base mesh */
var transient StaticMeshComponent BaseMesh;

/** Used to pulse the emissive on the base */
var MaterialInstanceConstant BaseMaterialInstance;

/** The baseline material colors */
var LinearColor BaseBrightEmissive;		// When the pickup is on the base
var LinearColor	BaseDimEmissive;		// When the pickup isn't on the base

/** When set to true, this base will begin pulsing it's emissive */
var repnotify bool bPulseBase;

/** How fast does the base pulse */
var float BasePulseRate;

/** How much time left in the current pulse */
var float BasePulseTime;

/** This pickup base will begin pulsing when there are PulseThreshold seconds left
    before respawn. */
var float PulseThreshold;

/** The TargetEmissive Color */
var LinearColor BaseTargetEmissive;
var LinearColor BaseEmissive;

/** This material instance parameter for adjusting the emissive */
var name BaseMaterialParamName;

// Used when floating
var	bool	bFloatingPickup;	// if true, the pickup mesh floats (bobs) slightly
var(floating)	bool	bRandomStart;		// if true, this pickup will start at a random height
var				float 	BobTimer;			// Tracks the bob time.  Used to create the position
var				float 	BobOffset;			// How far to bob.  It will go from +/- this number
var				float 	BobSpeed;			// How fast should it bob
var				float	BobBaseOffset;		// The base offset (Translation.Y) cached

/** sound played when the pickup becomes available */
var SoundCue RespawnSound;

/** Sound played on base while available to pickup*/
var AudioComponent PickupReadySound;

/** The pickup's light environment */
var DynamicLightEnvironmentComponent LightEnvironment;

/** In disabled state */
var repnotify bool bIsDisabled;

/** whether this pickup is updating */
var bool bUpdatingPickup;

/** Translation of pivot point */
var vector PivotTranslation;

/** Name used for the stats system */
var name PickupStatName;

/**
 * This determines whether this health pickup fades in or not.
 *
 * NOTE:  need to move this up to the highest pickup factory so all items will fade in
 **/
var bool bDoVisibilityFadeIn;
var name VisibilityParamName;

/** holds the pickups material so parameters can be set **/
var MaterialInstanceConstant MIC_Visibility;
/** holds the pickups 2nd material so parameters can be set **/
var MaterialInstanceConstant MIC_VisibilitySecondMaterial;

var repnotify bool bIsRespawning;

var ParticleSystemComponent Glow; // the glowing effect that comes from the base on spawn
var name GlowEmissiveParam;

var bool bHasLocationSpeech;

var Array<SoundNodeWave> LocationSpeech;

var float LastSeekNotificationTime;

var	ForceFeedbackWaveform	PickUpWaveForm;

var bool bTrackPickup;
var int PickupIndex;


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if ( bNetDirty && (Role == Role_Authority) )
		bPulseBase,bIsRespawning;
	if (bNetInitial && ROLE==ROLE_Authority )
		bIsDisabled;
}

simulated function PostBeginPlay()
{
	if ( bIsDisabled )
	{
		return;
	}

	Super.PostBeginPlay();

	bUpdatingPickup = (WorldInfo.NetMode != NM_DedicatedServer) && (bRotatingPickup || bFloatingPickup);
	if(Glow != none)
	{
		Glow.SetFloatParameter('LightStrength',0.0f);
		Glow.SetActive(true);
	}

	// Grab a reference to the material so we can adjust the parameter.  This adjustment occurs natively
	// in TickSpecial()
	if ( WorldInfo.NetMode != NM_DedicatedServer && BaseMesh != none && BaseMaterialParamName != '' )
	{
		BaseMaterialInstance = BaseMesh.CreateAndSetMaterialInstanceConstant(0);

		BaseTargetEmissive = bPickupHidden ? BaseDimEmissive : BaseBrightEmissive;
		BaseEmissive = BaseTargetEmissive;

		BaseMaterialInstance.SetVectorParameterValue( BaseMaterialParamName, BaseEmissive );
	}

	if(!bIsSuperItem && PickupReadySound != none)
	{
		PickupReadySound.Play();
	}

	// increase pickup radius on console
	if ( WorldInfo.bUseConsoleInput )
	{
		SetCollisionSize(1.5*CylinderComponent.CollisionRadius, CylinderComponent.CollisionHeight);
	}

	if ( bTrackPickup == true && WorldInfo.NetMode != NM_Client)
	{
		PickupIndex = UTGame(WorldInfo.Game).GetNextPickupIndex();
		//`log("Assigning PickupIndex "$PickupIndex$" to "$self);
	}
}

simulated function SetResOut()
{
	if (bDoVisibilityFadeIn && MIC_Visibility != None)
	{
		MIC_Visibility.SetScalarParameterValue(VisibilityParamName, 1.f);
	}
}

simulated function DisablePickup()
{
	bIsDisabled = true;
	GotoState('Disabled');
}

simulated function ShutDown()
{
	DisablePickup();
}

/**
  * Look for changes in bPulseBase or bPickupHidden and set the TargetEmissive accordingly
  */
simulated function ReplicatedEvent(name VarName)
{
	if ( VarName == 'bIsDisabled' )
	{
		Global.SetInitialState();
	}
	else
	{
		if(VarName == 'bPickupHidden' && bPickupHidden)
		{
			setResOut();
		}
		if ( VarName == 'bPulseBase' || VarName == 'bPickupHidden' )
		{
			StartPulse((bPickupHidden && !bPulseBase) ? BaseDimEmissive : BaseBrightEmissive);
		}
		if(VarName == 'bIsRespawning' )
		{
			if(bIsRespawning)
			{
				RespawnEffect();
			}
		}
		Super.ReplicatedEvent(VarName);
	}
}

/**
  * Returns true if Bot should wait for me
  */
function bool ShouldCamp(UTBot B, float MaxWait)
{
	return ( ReadyToPickup(MaxWait) && (B.RatePickup(self, InventoryType) > 0) && !ReadyToPickup(0) );
}

/* UpdateHUD()
Called for the HUD of the player that picked it up
*/
simulated static function UpdateHUD(UTHUD H)
{
	H.LastPickupTime = H.WorldInfo.TimeSeconds;
}

simulated function RespawnEffect()
{
	bIsRespawning = true;
	PlaySound(RespawnSound, true);
	if (PickupMesh != None)
	{
		PickupMesh.SetHidden(false);
	}
}

/* epic ===============================================
* ::StopsProjectile()
*
* returns true if Projectiles should call ProcessTouch() when they touch this actor
*/
simulated function bool StopsProjectile(Projectile P)
{
	local Actor HitActor;
	local vector HitNormal, HitLocation;

	if ( (P.CylinderComponent.CollisionRadius > 0) || (P.CylinderComponent.CollisionHeight > 0) )
	{
		// only collide if zero extent trace would also collide
		HitActor = Trace(HitLocation, HitNormal, P.Location, P.Location - 100*Normal(P.Velocity), true, vect(0, 0, 0));
		if ( HitActor != self )
			return false;
	}

	return bProjTarget || bBlockActors;
}


/**
 * Pulse to the Brightest point
 */
simulated function StartPulse(LinearColor TargetEmissive)
{
	if ( WorldInfo.NetMode != NM_DedicatedServer && BaseMesh != none && BaseMaterialParamName != '' )
	{
		BaseTargetEmissive = TargetEmissive;
		if ( BasePulseTime <= 0.0 )
		{
			BasePulseTime = BasePulseRate;
		}
		else
		{
			BasePulseTime = BasePulseRate - BasePulseTime;
		}
	}
}

auto state Pickup
{
	function BeginState(Name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);

		bPulseBase = false;
		StartPulse( BaseBrightEmissive );
    }
	simulated function EndState(Name NextStateName)
	{
		Super.EndState(NextStateName);
		bIsRespawning = false;
		SetResOut();
	}

}

State Sleeping
{
	function BeginState(Name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);

		bPulseBase = false;
		StartPulse( BaseDimEmissive );
		SetTimer( GetReSpawnTime() - PulseThreshold, false, 'PulseThresholdMet');
	}

	function EndState(Name NextStateName)
	{
		Super.EndState(NextStateName);
		ClearTimer('PulseThresholdMet');
	}

	function PulseThresholdMet()
	{
		bPulseBase = true;
		StartPulse(BaseBrightEmissive);
	}
}

simulated function SetPickupMesh()
{
	Super.SetPickupMesh();

	InitPickupMeshEffects();

}

/**
 * Stats
 */
function name GetPickupStatName()
{
/*	local UTItemPickupFactory myType;

	//TEMP
	MyType = UTItemPickupFactory(self);
	if (MyType != none)
	{
		//A non inventory things (like Ammo/Health/Powerup)
		`log("Pickedup:"@class.name);
	}
	else
	{
		//Actual inventory (like weapons)
		`log("Pickedup Inv:"@InventoryType.name);
	}
	//ENDTEMP
*/
	if ( Default.PickupStatName != '' )
	{
		//`log("Returning:"@Default.PickupStatName);
		return Default.PickupStatName;
	}

	return 'INVALID_PICKUPSTAT';
}

/** split out from SetPickupMesh() for subclasses that don't want to do the base PickupFactory implementation */
simulated event InitPickupMeshEffects()
{
	if ( PickupMesh != none )
	{
		PickupMesh.SetLightEnvironment(LightEnvironment);

		// Create a material instance for the pickup
		if (bDoVisibilityFadeIn && MeshComponent(PickupMesh) != None)
		{
			MIC_Visibility = MeshComponent(PickupMesh).CreateAndSetMaterialInstanceConstant(0);
			MIC_Visibility.SetScalarParameterValue(VisibilityParamName, bIsSuperItem ? 1.f : 0.f);
		}

		BobBaseOffset = PickupMesh.Translation.Y;
		if ( bRandomStart )
		{
			BobTimer = 1000 * frand();
		}
	}
}

simulated function SetPickupVisible()
{
	if(PickupReadySound != none)
	{
		PickupReadySound.Play();
	}

	if(Glow != none)
	{
		Glow.SetFloatParameter('LightStrength', 1.0f);
	}

	Super.SetPickupVisible();
}

simulated function SetPickupHidden()
{
	if(PickupReadySound != none)
	{
		PickupReadySound.Stop();
	}

	if(Glow != none)
	{
		Glow.SetFloatParameter('LightStrength',0.0f);
	}

	// need to hide also for low end video cards
	Super.SetPickupHidden();
}

simulated event SetInitialState()
{
	bScriptInitialized = true;

	if ( bIsDisabled )
	{
		GotoState('Disabled');
	}
	else
	{
		super.SetInitialState();
	}
}

function PickedUpBy(Pawn P)
{
	local UTBot B;
	local PlayerController PC;

	Super.PickedUpBy(P);

	// clear bot NoVehicleGoal so if it got out of vehicle to get a pickup it will consider getting back in now
	B = UTBot(P.Controller);
	if (B != None && B.NoVehicleGoal == self)
	{
		B.NoVehicleGoal = None;
	}

	PC = PlayerController(P.Controller);
	if(PC != None)
   	{
      		UTPlayerReplicationInfo(P.PlayerReplicationInfo).UpdatePickupFlags(PickupIndex);
   	}
}

State Disabled
{
	function float BotDesireability(Pawn P, Controller C)
	{
		return 0;
	}
}

defaultproperties
{
   bDoVisibilityFadeIn=True
   YawRotationRate=32768.000000
   BaseBrightEmissive=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   BaseDimEmissive=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   BasePulseRate=0.500000
   PulseThreshold=5.000000
   BaseTargetEmissive=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   BaseEmissive=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   BaseMaterialParamName="BaseEmissiveControl"
   RespawnSound=SoundCue'A_Pickups.Generic.Cue.A_Pickups_Generic_ItemRespawn_Cue'
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      AmbientGlow=(R=0.300000,G=0.300000,B=0.300000,A=1.000000)
      bCastShadows=False
      bDynamic=False
      Name="PickupLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   LightEnvironment=PickupLightEnvironment
   VisibilityParamName="ResIn"
   GlowEmissiveParam="LightStrength"
   PickUpWaveForm=ForceFeedbackWaveform'UTGame.Default__UTPickupFactory:ForceFeedbackWaveformPickUp'
   PickupIndex=-1
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__PickupFactory:CollisionCylinder'
      CollisionHeight=44.000000
      ObjectArchetype=CylinderComponent'Engine.Default__PickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   GoodSprite=None
   BadSprite=None
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__PickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__PickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
      CullDistance=7000.000000
      CachedCullDistance=7000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True)
      CollideActors=False
      Name="BaseMeshComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(3)=BaseMeshComp
   bMovable=False
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory"
   ObjectArchetype=PickupFactory'Engine.Default__PickupFactory'
}
