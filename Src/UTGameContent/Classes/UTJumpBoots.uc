/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
/** jump boots drastically increase a player's double jump velocity */
class UTJumpBoots extends UTInventory;

/** the Z velocity boost to give the owner's double jumps */
var float MultiJumpBoost;
/** the number of jumps that the owner can do before the boots run out */
var repnotify databinding byte Charges;
/** sound to play when the boots are used */
var SoundCue ActivateSound;
/** message to send to the owner when the boots run out */
var databinding	localized string RanOutText;

replication
{
	if (bNetOwner && bNetDirty && Role==ROLE_Authority)
		Charges;
}

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	Super.GivenTo(NewOwner, bDoNotActivate);
	AdjustPawn(UTPawn(NewOwner), false);
}

function ItemRemovedFromInvManager()
{
	AdjustPawn(UTPawn(Owner), true);
}

simulated function ReplicatedEvent(name VarName)
{
	if (VarName == 'Charges')
	{
		UTPawn(Owner).JumpBootCharge = Charges;
	}

	Super.ReplicatedEvent(VarName);
}


reliable client function ClientGivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	Super.ClientGivenTo(NewOwner, bDoNotActivate);
	if (Role < ROLE_Authority)
	{
		AdjustPawn(UTPawn(NewOwner), false);
	}
}

reliable client function ClientLostItem()
{
	local UTPawn P;

	P = UTPawn(Owner);
	if (P != None)
	{
		if (Role < ROLE_Authority)
		{
			AdjustPawn(P, true);
		}
		P.JumpBootCharge = 0;
	}

	Super.ClientLostItem();
}

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if (P != None)
	{
		if (bRemoveBonus)
		{
			P.MultiJumpBoost -= MultiJumpBoost;
			P.MaxFallSpeed -= MultiJumpBoost;
			P.JumpBootCharge = 0;
			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if (P.Controller != None)
			{
				P.Controller.HighJumpNodeCostModifier -= 1000;
			}
		}
		else
		{
			P.MultiJumpBoost += MultiJumpBoost;
			P.MaxFallSpeed += MultiJumpBoost;
			P.JumpBootCharge = Charges;
			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if (P.Controller != None)
			{
				P.Controller.HighJumpNodeCostModifier += 1000;
			}
		}
	}
}

simulated function OwnerEvent(name EventName)
{
	if (Role == ROLE_Authority)
	{
		if (EventName == 'MultiJump')
		{
			Charges--;
			UTPawn(Owner).JumpBootCharge = Charges;
			Spawn(class'UTJumpBootEffect', Owner,, Owner.Location, Owner.Rotation);
			Owner.PlaySound(ActivateSound, false, true, false);
		}
		else if (EventName == 'Landed' && Charges <= 0)
		{
			Destroy();
		}
	}
	else if (EventName == 'MultiJump')
	{
		Owner.PlaySound(ActivateSound, false, true, false);
	}
}

function bool DenyPickupQuery(class<Inventory> ItemClass, Actor Pickup)
{
	if (ItemClass == Class)
	{
		Charges = default.Charges;
		UTPawn(Owner).JumpBootCharge = Charges;
		Pickup.PickedUpBy(Instigator);
		AnnouncePickup(Instigator);
		return true;
	}

	return false;
}

function DropFrom(vector StartLocation, vector StartVelocity)
{
	if (Charges <= 0)
	{
		Destroy();
	}
	else
	{
		Super.DropFrom(StartLocation, StartVelocity);
	}
}

static function float BotDesireability(Actor PickupHolder, Pawn P, Controller C)
{
	local UTJumpBoots AlreadyHas;

	AlreadyHas = UTJumpBoots(P.FindInventoryType(default.Class));
	if (AlreadyHas != None)
	{
		return (default.MaxDesireability / (1 + AlreadyHas.Charges));
	}

	return default.MaxDesireability;
}

static function float DetourWeight(Pawn Other, float PathWeight)
{
	return (default.MaxDesireability / PathWeight);
}

defaultproperties
{
   MultiJumpBoost=750.000000
   Charges=3
   ActivateSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_JumpBoots_JumpCue'
   RanOutText="Gli Stivali Anti-Gravità sono esauriti."
   bRenderOverlays=True
   bReceiveOwnerEvents=True
   bDropOnDeath=True
   RespawnTime=30.000000
   MaxDesireability=1.000000
   PickupMessage="Stivali Anti-Gravità"
   PickupSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_JumpBoots_PickupCue'
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.JumpBoots.Mesh.S_UN_Pickups_Jumpboots002'
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
      Scale=1.700000
      Name="StaticMeshComponent1"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=StaticMeshComponent1
   PickupFactoryMesh=StaticMeshComponent1
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTInventory:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTInventory:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTJumpBoots"
   ObjectArchetype=UTInventory'UTGame.Default__UTInventory'
}
