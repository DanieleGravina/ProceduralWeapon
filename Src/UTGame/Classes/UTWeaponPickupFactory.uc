/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeaponPickupFactory extends UTPickupFactory
	native;

var() class<UTWeapon> WeaponPickupClass;
var bool bWeaponStay;
var bool bVerifiedWeaponStay;

/** The glow that emits from the base while the weapon is available */
var ParticleSystemComponent BaseGlow;
/** Used to scale weapon pickup drawscale */
var float WeaponPickupScaling;

var array<PawnToucher> Customers;

/** clientside flag - whether the locker should be displayed as active and having weapons available */
var bool bIsActive;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function InitializePickup()
{
	local int i;

	InventoryType = WeaponPickupClass;
	if ( InventoryType == None )
	{
		GotoState('Disabled');
		return;
	}

	PivotTranslation = WeaponPickupClass.Default.PivotTranslation;

	SetWeaponStay();

	// set up location messages
	if ( WeaponPickupClass.default.bHasLocationSpeech )
	{
		bHasLocationSpeech = true;
		for ( i=0; i<WeaponPickupClass.default.LocationSpeech.Length; i++ )
		{
			LocationSpeech[i] = WeaponPickupClass.default.LocationSpeech[i];
		}
	}

	Super.InitializePickup();
}

simulated function SetPickupVisible()
{
	BaseGlow.SetActive(true);
	Super.SetPickupVisible();
}
simulated function SetPickupHidden()
{
	BaseGlow.DeactivateSystem();
	Super.SetPickupHidden();
}

simulated function SetPickupMesh()
{
	Super.SetPickupMesh();
	if ( PickupMesh != none )
	{
		PickupMesh.SetScale(PickupMesh.Scale * WeaponPickupScaling);
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'InventoryType')
	{
		if (InventoryType != WeaponPickupClass)
		{
			WeaponPickupClass = class<UTWeapon>(InventoryType);
			Super.ReplicatedEvent(VarName);
		}
	}
	else
	{

		Super.ReplicatedEvent(VarName);
	}
}

function bool CheckForErrors()
{
	if ( Super.CheckForErrors() )
		return true;

	if ( WeaponPickupClass == None )
	{
		LogInternal(self$" no weapon pickup class");
		return true;
	}
	else if (ClassIsChildOf(WeaponPickupClass, class'UTDeployable'))
	{
		LogInternal(self @ "cannot hold deployables");
		return true;
	}

	return false;
}

/**
 * If our charge is not a super weapon and weaponstay is on, set weapon stay
 */
function SetWeaponStay()
{
	if ( WeaponPickupClass.Default.bSuperWeapon )
	{
		bWeaponStay = false;
	}
	else if ( (UTGame(WorldInfo.Game) != None) && !UTGame(WorldInfo.Game).bWeaponStay )
	{
		bWeaponStay = false;
	}
}

simulated function CheckWeaponStay()
{
	local class<UTGame> UTGameClass;
	
	if ( !bWeaponStay )
	{
		bVerifiedWeaponStay = true;
	}
	else if ( WeaponPickupClass.Default.bSuperWeapon )
	{
		bWeaponStay = false;
		bVerifiedWeaponStay = true;
	}
	else if (  Worldinfo.GRI != None )
	{
		UTGameClass = class<UTGame>(WorldInfo.GRI.GameClass);
		if ( UTGameClass != None ) 
		{
			bWeaponStay = UTGameClass.default.bWeaponStay;
			bVerifiedWeaponStay = true;
		}
	}
}

function StartSleeping()
{
	if ( !bVerifiedWeaponStay )
	{
		CheckWeaponStay();
	}
	
	if (!bWeaponStay)
	    GotoState('Sleeping');
}

function bool AllowRepeatPickup()
{
    return true;
}

function bool AddCustomer(Pawn P)
{
	local int			i;
	local PawnToucher	PT;

	if ( UTInventoryManager(P.InvManager) == None )
		return false;

	if ( Customers.Length > 0 )
		for ( i=0; i<Customers.Length; i++ )
		{
			if ( Customers[i].NextTouchTime < WorldInfo.TimeSeconds )
			{
				if ( Customers[i].P == P )
				{
					Customers[i].NextTouchTime = WorldInfo.TimeSeconds + 30;
					return true;
				}
				Customers.Remove(i,1);
				i--;
			}
			else if ( Customers[i].P == P )
			{
				return false;
			}
		}

	PT.P = P;
	PT.NextTouchTime = WorldInfo.TimeSeconds + 30;
	Customers[Customers.Length] = PT;
	return true;
}

function bool HasCustomer(Pawn P)
{
	local int i;
	local bool bFoundCustomer;

	if ( Customers.Length > 0 )
	{
		for ( i=0; i<Customers.Length; i++ )
		{
			bFoundCustomer = (Customers[i].P == P);
			if ( Customers[i].NextTouchTime < WorldInfo.TimeSeconds )
			{
				Customers.Remove(i,1);
				i--;
				if ( bFoundCustomer )
					return false;
			}
			else if ( bFoundCustomer )
				return true;
		}
	}
	return false;
}
function bool AllowPickup(UTBot Bot)
{
    return false; 
}

function PickedUpBy(Pawn P)
{
	local UTPlayerController PC;

	if ( !bVerifiedWeaponStay )
	{
		CheckWeaponStay();
	}
	
	if ( bWeaponStay )
	{
		AddCustomer(P);
		if ( (P.Controller != None) && P.Controller.IsLocalPlayerController() )
		{
			ShowHidden();
			SetTimer(30,false,'ShowActive');
		}
	}
	Super.PickedUpBy(P);
	if ( WeaponPickupClass.Default.bCanDestroyBarricades )
	{
		// notify any players that have this as their objective
		ForEach WorldInfo.AllControllers(class'UTPlayerController', PC)
		{
			if ( (PC.LastAutoObjective == self) && (PC != P.Controller) )
			{
				PC.CheckAutoObjective(true);
			}
		}
	}
}

function SpawnCopyFor( Pawn Recipient )
{
	local Inventory Inv;
	if ( UTInventoryManager(Recipient.InvManager)!=None )
	{
		Inv = UTInventoryManager(Recipient.InvManager).HasInventoryOfClass(WeaponPickupClass);
		if ( UTWeapon(Inv)!=none )
		{
			UTWeapon(Inv).AddAmmo(WeaponPickupClass.Default.AmmoCount);
			UTWeapon(Inv).AnnouncePickup(Recipient);
			return;
		}
	}
	Recipient.MakeNoise(0.2);
	super.SpawnCopyFor(Recipient);
}

simulated function ShowActive();

simulated function ShowHidden()
{
	BaseGlow.DeactivateSystem();
	if ( PickupMesh != None )
		PickupMesh.SetHidden(true);
	bIsActive = false;
}

simulated function NotifyLocalPlayerDead(PlayerController PC);

auto state Pickup
{
	function bool AllowPickup(UTBot Bot)
	{
		if ( !bVerifiedWeaponStay )
		{
			CheckWeaponStay();
		}
	
		return !bWeaponStay || !HasCustomer(Bot.Pawn);
	}

	simulated function ShowActive()
	{
		BaseGlow.SetActive(true);
		bIsActive = true;
		if ( PickupMesh != None )
			PickupMesh.SetHidden(false);
	}

	simulated function NotifyLocalPlayerDead(PlayerController PC)
	{
		if ( !bVerifiedWeaponStay )
		{
			CheckWeaponStay();
		}
	
		if ( bWeaponStay )
		{
			ShowActive();
		}
	}

	// When touched by an actor.
	simulated event Touch( actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
	{
		local Pawn Recipient;
		local Controller PickupController;

		if ( !bVerifiedWeaponStay )
		{
			CheckWeaponStay();
		}
	
		if ( !bWeaponStay )
		{
			super.Touch(Other, OtherComp, HitLocation, HitNormal);
			return;
		}
		// If touched by a player pawn, let him pick this up.
		Recipient = Pawn(Other);
		if( (Recipient != None) && !HasCustomer(Recipient) && ValidTouch(Recipient) )
		{	
			if ( bIsActive )
			{
				PickupController = Recipient.Controller;
				if ( (PickupController == None) && (Recipient.DrivenVehicle != None) )
				{
					PickupController = Recipient.DrivenVehicle.Controller;
				}
				if ( (PickupController != None) && PickupController.IsLocalPlayerController() )
				{
					ShowHidden();
					SetTimer(30,false,'ShowActive');
				}
			}
			if ( Role == ROLE_Authority )
			{
				if ( !AddCustomer(Recipient) )
					return;
				GiveTo(Recipient);
			}
		}
	}

	/*
	 Validate touch (if valid return true to let other pick me up and trigger event).
	*/
	simulated function bool ValidTouch( Pawn Other )
	{
		if ( Role == ROLE_Authority )
		{
			return Super.ValidTouch(Other);
		}

		// make sure its a live player
		if (Other == None || !Other.bCanPickupInventory || Other.Controller == None || !FastTrace(Other.Location, Location) )
		{
			return false;
		}
		return true;
	}

	simulated event BeginState(name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);

		ShowActive();
	}
}

defaultproperties
{
   bWeaponStay=True
   Begin Object Class=ParticleSystemComponent Name=GlowEffect ObjName=GlowEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.WeaponBase.Effects.P_Pickups_WeaponBase_Glow'
      SecondsBeforeInactive=1.000000
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      Name="GlowEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   BaseGlow=GlowEffect
   WeaponPickupScaling=1.200000
   bRotatingPickup=True
   bDoVisibilityFadeIn=False
   RespawnSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Respawn_Cue'
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
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
      StaticMesh=StaticMesh'PICKUPS.WeaponBase.S_Pickups_WeaponBase'
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=GlowEffect
   bBlockActors=True
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTWeaponPickupFactory"
   ObjectArchetype=UTPickupFactory'UTGame.Default__UTPickupFactory'
}
