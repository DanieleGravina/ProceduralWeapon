/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CoverLink extends NavigationPoint
	native
	placeable;

// Initial flanking dot prod value
const COVERLINK_ExposureDot		= 0.4f;
// Considered vulnerable at edge slot if past this dot prod
const COVERLINK_EdgeCheckDot	= 0.25f;
const COVERLINK_EdgeExposureDot	= 0.85f;
// Navigation points within this range are considered dangerous to travel through
const COVERLINK_DangerDist		= 1536.f;

struct native CoverReference extends NavReference
{
	/** Slot referenced in the link */
	var() int SlotIdx;
	/** Direction, used for swat/slip */
	var() int Direction;
};

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Utility struct for referencing cover link slots. */
struct native CoverInfo
{
	var() editconst CoverLink Link;
	var() editconst int SlotIdx;

	structcpptext
	{
		UBOOL operator==(const FCoverInfo &Other)
		{
			return (this->Link == Other.Link && this->SlotIdx == Other.SlotIdx);
		}
	}
};

struct native TargetInfo
{
	var Actor	Target;
	var int		SlotIdx;	// Used if Target is a CoverLink
	var int		Direction;	// -1 -> Left, 0 -> Center, +1 -> Right
};

/** Utility struct to reference a position in cover */
struct native CovPosInfo
{
	/** CoverLink holding cover position */
	var CoverLink	Link;
	/** Index of left bounding slot */
	var	int			LtSlotIdx;
	/** Index of right bounding slot */
	var int			RtSlotIdx;
	/** Pct of distance Location is, between left and right slots */
	var float		LtToRtPct;
	/** Location in cover */
	var	vector		Location;
	/** Normal vector, used to define direction. Pointing from Location away from Wall. */
	var vector		Normal;
	/** Tangent vector, gives alignement of cover. With multiple slots cover, this gives the direction from Left to Right slots. */
	var vector		Tangent;

	structdefaultproperties
	{
		LtSlotIdx=-1
		RtSlotIdx=-1
		LtToRtPct=+0.f
	}
};


/**
 * Represents the current action this pawn is performing at the
 * current cover node.
 */
enum ECoverAction
{
	/** Default no action */
	CA_Default,
	/** Blindfiring to the left */
	CA_BlindLeft,
	/** Blindfiring to the right */
	CA_BlindRight,
	/** Leaning to the left */
	CA_LeanLeft,
	/** Leaning to the right */
	CA_LeanRight,
	/** Stepping out to the left */
	CA_StepLeft,
	/** Stepping out to the right */
	CA_StepRight,
	/** Pop up, out of cover */
	CA_PopUp,
	/** Blind fire up */
	CA_BlindUp,

	/** AI Peek from cover options */
	CA_PeekLeft,
	CA_PeekRight,
	CA_PeekUp,
};

/**
 * Represents a direction associated with cover, for use with movement/camera/etc.
 */
enum ECoverDirection
{
	CD_Default,
	CD_Left,
	CD_Right,
	CD_Up,
};

/**
 * Represents what type of cover this node provides.
 */
enum ECoverType
{
	/** Default, no cover */
	CT_None,
	/** Full standing cover */
	CT_Standing,
	/** Mid-level crouch cover, stand to fire */
	CT_MidLevel,
};

/**
 * Contains information about what other cover nodes this node is
 * capable of firing on.
 */
struct native FireLink
{
	/** Acceptable methods of attack to use when engaging the target link */
	var array<ECoverAction> CoverActions;

	/** Type of cover for these links
		(ie can be CT_MidLevel even in a standing slot) */
	var ECoverType		CoverType;

	/** Target link */
	var() editconst const NavReference TargetLink;

	/** Target link slot */
	var int TargetSlotIdx;

	/** Location of the TargetLink when this FireLink was created/updated (Used for tracking CoverLink_Dynamic) */
	var Vector LastLinkLocation;

	/** Is this link considered a fallback link? (Shouldn't be desired, but is acceptable) */
	var bool bFallbackLink;
};

/** Contains information for a cover slot that a player can occupy */
struct native CoverSlot
{
	/** Current owner of this slot */
	var Controller SlotOwner;

	/** Gives LDs ability to force the type - CT_None == auto find*/
	var() ECoverType ForceCoverType;
	/** Type of cover this slot provides */
	var(Auto) editconst ECoverType CoverType;

	/** Offset from node location for this slot */
	var vector LocationOffset;

	/** Offset from node rotation for this slot */
	var rotator RotationOffset;

	/** List of all attackable nodes */
	var duplicatetransient array<FireLink>			FireLinks;
	var duplicatetransient array<FireLink>			ForcedFireLinks;
	/** List of coverlinks/slots that couldn't be shot at - used by COVERLINK_DYNAMIC */
	var duplicatetransient array<CoverInfo>			RejectedFireLinks;
	/** List of targets that are flanked by this slot */
	var duplicatetransient array<CoverReference>	ExposedFireLinks;
	/** List of nav points that are dangerous to path through when this slot is occupied */
	var duplicatetransient array<NavReference>		DangerLinks;

	/** Link/slot info about where this slot can mantle to */
	var duplicatetransient CoverReference	MantleTarget;

	/** Link/slot info about where swat turn evade can move to */
	/** @fixme: can't these be a static 2 element array and eliminate the direction parameter in CoverReference? */
	var duplicatetransient array<CoverReference>	TurnTarget;

	/** Info about where cover slip can move to */
	var duplicatetransient array<CoverReference>	SlipTarget;

	/** List of cover slots that should be claimed when this slot is claimed
		because they are overlapping */
	var(Auto) editconst duplicatetransient array<CoverReference>	OverlapClaims;

	/** Can we lean left/right to shoot from this slot? */
	var(Auto) bool bLeanLeft, bLeanRight;
	/** Can we popup? */
	var(Auto) editconst bool bCanPopUp;
	/** Can we mantle over this cover? */
	var(Auto) editconst bool bCanMantle;
	/** Can cover slip at this slot? */
	var(Auto) editconst bool bCanCoverSlip_Left, bCanCoverSlip_Right;
	/** Can swat turn at this slot? */
	var(Auto) editconst bool bCanSwatTurn_Left, bCanSwatTurn_Right;

	/** Is this slot currently enabled? */
	var() bool bEnabled;

	/** Is popping up allowed for midlevel/crouching cover? */
	var() bool bAllowPopup;
	/** Is mantling allowed here? */
	var() bool bAllowMantle;
	/** Is cover slip allowed? */
	var() bool bAllowCoverSlip;
	/** Is climbing up allowed here? */
	var() bool bAllowClimbUp;
	/** Is swat turn allowed? */
	var() bool bAllowSwatTurn;

	/** === Editor specific === */
	/** Is this slot currently selected for editing? */
	var transient bool bSelected;

	/** How far auto adjust code traces forward from lean fire point
		to determine if the lean has a valid fire line */
	var	float LeanTraceDist;

	/** Slot marker to allow the slot to exist on the navigation network */
	var() editconst duplicatetransient CoverSlotMarker SlotMarker;

	structdefaultproperties
	{
		bEnabled=TRUE

		bCanMantle=TRUE
		bCanCoverSlip_Left=TRUE
		bCanCoverSlip_Right=TRUE
		bCanSwatTurn_Left=TRUE
		bCanSwatTurn_Right=TRUE

		bAllowMantle=TRUE
		bAllowCoverSlip=TRUE
		bAllowPopup=TRUE
		bAllowSwatTurn=TRUE
		bAllowClimbUp=FALSE

		LeanTraceDist=64.f
	}
};

/** All slots linked to this node */
var() editinline array<CoverSlot> Slots;

/** List of all players using this cover */
var array<Controller> Claims;

/** Whether cover link is disabled */
var() bool bDisabled;

/** Claim all slots when someone claims one - used for cover that needs more than one slot, but slots overlap */
var() bool bClaimAllSlots;

/** Allow auto-sorting of the Slots array */
var bool bAutoSort;

/** Allow auto-adjusting of the Slots orientation/position and covertype? */
var() bool bAutoAdjust;

/** Is this circular cover? */
var() bool bCircular;

/** Cover is looped, first slot and last slot should be reachable direclty */
var() bool bLooped;

/** Is this cover restricted to player use? */
var() bool bPlayerOnly;
/** This cover is dynamic */
var	  bool bDynamicCover;
/** Max trace dist for fire links to check */
var() float MaxFireLinkDist;

/** Origin for circular cover */
var const vector CircularOrigin;

/** Radius for circular cover */
var const float CircularRadius;

/** Distance used when aligning to nearby surfaces */
var const float AlignDist;

/** Min height for nearby geometry to categorize as standing cover */
var const float StandHeight;

/** Min height for nearby geometry to categorize as mid-level cover */
var const float MidHeight;

/** Default height for Perch walls */
var() const float	PerchWallHeight; 
/** Allow a little error, we support walls slightly higher or lower. */
var() const	float	PerchWallNudge;

var const Vector	StandingLeanOffset;
var const Vector	CrouchLeanOffset;
var const Vector	PopupOffset;

/** Forward distance for checking cover slip links */
var const float	SlipDist;

/** Lateral distance for checking swat turn links */
var const float	TurnDist;

/** Used for the WorldInfo.CoverList linked list */
var const CoverLink NextCoverLink;

/** Returns the world location of the requested slot. */
simulated native final function vector GetSlotLocation(int SlotIdx, optional bool bForceUseOffset);

/** Returns the world rotation of the requested slot. */
simulated native final function rotator GetSlotRotation(int SlotIdx, optional bool bForceUseOffset);

/** Returns the world location of the default viewpoint for the specified slot. */
simulated native final function vector GetSlotViewPoint( int SlotIdx, optional ECoverType Type, optional ECoverAction Action );

/** Returns reference to the slot marker navigation point */
simulated native final function CoverSlotMarker	GetSlotMarker( int SlotIdx );

simulated native final function bool IsExposedTo( int SlotIdx, CoverInfo ChkSlot );

/** Asserts a claim on this link by the specified controller. */
final event bool Claim( Controller NewClaim, int SlotIdx )
{
	local int	Idx;
	local bool	bResult, bDoClaim;
	local PlayerController PC;
	local Controller PreviousOwner;


	local int NumClaims;
	local array<int> SlotList;
	local String Str;

	//debug
	if( bDebug )
	{
		LogInternal(self@"Claim Slot"@SlotIdx@"For"@NewClaim@"(All?)"@bClaimAllSlots);
	}


	bDoClaim = TRUE;


	// If slot already claimed
	if( Slots[SlotIdx].SlotOwner != None )
	{
		// If we have already claimed it, nothing to do
		// If we don't, fail claim
		bResult = Slots[SlotIdx].SlotOwner == NewClaim;
		bDoClaim = FALSE;

		// If claimer is different
		if( !bResult )
		{
			// If claimer is a player controller
			PC = PlayerController( NewClaim );
			if( PC != None )
			{
				PreviousOwner = Slots[SlotIdx].SlotOwner;
				// Tell the previous owner that we are taking over
				bDoClaim = TRUE;
			}
		}
	}

	if( bDoClaim )
	{
		// If all slots must be claimed
		if( bClaimAllSlots )
		{
			// Loop through each slot and set new claim as owner of all
			for( Idx = 0; Idx < Slots.Length; Idx++ )
			{
				if( Slots[Idx].SlotOwner == None )
				{
					// Add entry to general claims list (will contain multiple entries if has multiple slots claimed)
					Claims[Claims.Length] = NewClaim;
					// Mark slot claim
					Slots[Idx].SlotOwner = NewClaim;
					bResult = TRUE;
				}
			}
		}
		else
		{
			// Add entry to general claims list (will contain multiple entries if has multiple slots claimed)
			Claims[Claims.Length] = NewClaim;
			// Mark slot claim
			Slots[SlotIdx].SlotOwner = NewClaim;

			bResult = TRUE;
		}
		if (PreviousOwner != None)
		{
			PreviousOwner.NotifyCoverClaimViolation( NewClaim, self, SlotIdx );
		}
	}

	//debug

	if( bDebug )
	{
		for( Idx = 0; Idx < Claims.Length; Idx++ )
		{
			if( Claims[Idx] == NewClaim )
			{
				NumClaims++;
			}
		}
		for( Idx = 0; Idx < Slots.Length; Idx++ )
		{
			if( Slots[Idx].SlotOwner == NewClaim )
			{
				SlotList[SlotList.Length] = Idx;
			}
		}
		if( SlotList.Length == 0 )
		{
			Str = "None";
		}
		else
		{
			for( Idx = 0; Idx < SlotList.Length; Idx++ )
			{
				Str = Str@SlotList[Idx];
			}
		}

		LogInternal(self@"Claims from"@NewClaim@NumClaims@"Slots:"@Str);

		ScriptTrace();
	}


	return bResult;
}

/** Removes any claims the specified controller has on this link. */
final event bool UnClaim( Controller OldClaim, int SlotIdx, bool bUnclaimAll )
{
	local int Idx, NumReleased;
	local bool bResult;


	//debug
	local int NumClaims;
	local array<int> SlotList;
	local String Str;

	//debug
	if( bDebug )
	{
		LogInternal(self@"UnClaim"@OldClaim@SlotIdx@bUnclaimAll@bClaimAllSlots);
	}


	// If letting go of link completely
	if( bUnclaimAll )
	{
		// Clear the slot owner from all slots
		for( Idx = 0; Idx < Slots.Length; Idx++ )
		{
			if( Slots[Idx].SlotOwner == OldClaim )
			{
				Slots[Idx].SlotOwner = None;
				NumReleased++;
				bResult = TRUE;
			}
		}
	}
	// Otherwise, if we want to let go of only one slot (and shouldn't always hold all of them)
	else if( !bClaimAllSlots && Slots[SlotIdx].SlotOwner == OldClaim )
	{
		// Release this slot
		Slots[SlotIdx].SlotOwner = None;
		NumReleased++;
		bResult = TRUE;
	}

	// For each slot released
	while( NumReleased > 0 )
	{
		// Find a claim in the list
		Idx = Claims.Find(OldClaim);
		if( Idx < 0 )
		{
			break;
		}

		// Clear on claim from the general claims list
		Claims.Remove( Idx, 1 );
		NumReleased--;
	}

	//debug

	if( bDebug )
	{
		for( Idx = 0; Idx < Claims.Length; Idx++ )
		{
			if( Claims[Idx] == OldClaim )
			{
				NumClaims++;
			}
		}
		for( Idx = 0; Idx < Slots.Length; Idx++ )
		{
			if( Slots[Idx].SlotOwner == OldClaim )
			{
				SlotList[SlotList.Length] = Idx;
			}
		}
		if( SlotList.Length == 0 )
		{
			Str = "None";
		}
		else
		{
			for( Idx = 0; Idx < SlotList.Length; Idx++ )
			{
				Str = Str@SlotList[Idx];
			}
		}

		LogInternal(self@"Claims from"@OldClaim@NumClaims@"Slots:"@Str);

		ScriptTrace();
	}


	return bResult;
}

/** Returns true if the specified controller is able to claim the slot. */
final native function bool IsValidClaim( Controller ChkClaim, int SlotIdx, optional bool bSkipTeamCheck, optional bool bSkipOverlapCheck );

/**
 * Checks to see if the specified slot support stationary cover actions.
 */
simulated final function bool IsStationarySlot(int SlotIdx)
{
	return (!bCircular);
}

/**
 * Finds the current set of slots the specified point is between.  Returns true
 * if a valid slot set was found.
 */
simulated native final function bool FindSlots(vector CheckLocation, float MaxDistance, out int LeftSlotIdx, out int RightSlotIdx);


/**
 * Return true if the specified slot is an edge, signifying "End Of Cover".
 */
simulated native final function bool IsEdgeSlot( int SlotIdx, optional bool bIgnoreLeans );
simulated native final function bool IsLeftEdgeSlot( int SlotIdx, bool bIgnoreLeans );
simulated native final function bool IsRightEdgeSlot( int SlotIdx, bool bIgnoreLeans );

simulated final function bool AllowRightTransition(int SlotIdx)
{
	local int NextSlotIdx;

	NextSlotIdx = SlotIdx + 1;
	if( bLooped )
	{

		if( NextSlotIdx >= Slots.Length )
		{
			NextSlotIdx -= Slots.Length;
		}

		return Slots[NextSlotIdx].bEnabled;
	}

	return (SlotIdx < Slots.Length - 1 && Slots[NextSlotIdx].bEnabled);
}

simulated final function bool AllowLeftTransition(int SlotIdx)
{
	local int NextSlotIdx;

	NextSlotIdx = SlotIdx - 1;
	if( bLooped )
	{

		if( NextSlotIdx < 0 )
		{
			NextSlotIdx += Slots.Length;
		}

		return Slots[NextSlotIdx].bEnabled;
	}

	return (SlotIdx > 0 && Slots[NextSlotIdx].bEnabled);
}

/**
 * Searches for a fire link to the specified cover/slot and returns the cover actions.
 */
native noexport function bool GetFireLinkTo( int SlotIdx, CoverInfo ChkCover, ECoverType Type, out array<ECoverAction> Actions);

/**
 * Searches for a valid fire link to the specified cover/slot.
 * NOTE: marked noexport until 'optional out int' is fixed in the exporter
 */
native noexport function bool HasFireLinkTo( int SlotIdx, CoverInfo ChkCover );

/**
 * Returns a list of AI actions possible from this slot
 */
native final function GetSlotActions( int SlotIdx, out array<ECoverAction> Actions );

/**
 * Enable/disable the entire CoverLink.
 */
simulated event SetDisabled(bool bNewDisabled)
{
	local int SlotIdx;

	bDisabled = bNewDisabled;

	if( bDisabled )
	{
		for (SlotIdx = 0; SlotIdx < Slots.Length; SlotIdx++)
		{
			if (Slots[SlotIdx].SlotOwner != None)
			{
				Slots[SlotIdx].SlotOwner.NotifyCoverDisabled(self,SlotIdx);
			}
		}
	}
}

/**
 * Enable/disable a particular cover slot.
 */
simulated event SetSlotEnabled(int SlotIdx, bool bEnable)
{
	Slots[SlotIdx].bEnabled = bEnable;

	if ( (bEnable == FALSE) && (Slots[SlotIdx].SlotOwner != None) )
	{
		// notify any owner that the slot is disabled
		Slots[SlotIdx].SlotOwner.NotifyCoverDisabled( self, SlotIdx );
	}
}

/**
 * Handle modify action by enabling/disabling the list of slots, or auto adjusting.
 */
function OnModifyCover(SeqAct_ModifyCover Action)
{
	local array<int> SlotIndices;
	local int Idx, SlotIdx;
	local CoverReplicator CoverReplicator;

	// if the action has slots specified
	if (Action.Slots.Length > 0)
	{
		// use only those indicies
		SlotIndices = Action.Slots;
	}
	else
	{
		// otherwise use all the slots
		for (Idx = 0; Idx < Slots.Length; Idx++)
		{
			SlotIndices[SlotIndices.Length] = Idx;
		}
	}
	for (Idx = 0; Idx < SlotIndices.Length; Idx++)
	{
		SlotIdx = SlotIndices[Idx];
		if (SlotIdx >= 0 && SlotIdx < Slots.Length)
		{
			if (Action.InputLinks[0].bHasImpulse)
			{
				SetSlotEnabled(SlotIdx, TRUE);
			}
			else
			if (Action.InputLinks[1].bHasImpulse)
			{
				SetSlotEnabled(SlotIdx, FALSE);
			}
			else
			if (Action.InputLinks[2].bHasImpulse)
			{
				// update the slot
				if (AutoAdjustSlot(SlotIdx,FALSE) &&
					Slots[SlotIdx].SlotOwner != None)
				{
					// and notify if it changed
					Slots[SlotIdx].SlotOwner.NotifyCoverAdjusted();
				}
			}
			else
			if (Action.InputLinks[3].bHasImpulse)
			{
				Slots[SlotIdx].CoverType = Action.ManualCoverType;
				if (Slots[SlotIdx].SlotOwner != None)
				{
					// notify the owner of the change
					Slots[SlotIdx].SlotOwner.NotifyCoverAdjusted();
				}
			}
		}
	}

	CoverReplicator = WorldInfo.Game.GetCoverReplicator();
	if (CoverReplicator != None)
	{
		if (Action.InputLinks[0].bHasImpulse)
		{
			CoverReplicator.NotifyEnabledSlots(self, SlotIndices);
		}
		else if (Action.InputLinks[1].bHasImpulse)
		{
			CoverReplicator.NotifyDisabledSlots(self, SlotIndices);
		}
		else if (Action.InputLinks[2].bHasImpulse)
		{
			CoverReplicator.NotifyAutoAdjustSlots(self, SlotIndices);
		}
		else if (Action.InputLinks[3].bHasImpulse)
		{
			CoverReplicator.NotifySetManualCoverTypeForSlots(self, SlotIndices, Action.ManualCoverType);
		}
	}
}

/**
 * Auto-adjusts the slot orientation/location to the nearest geometry, as well
 * as determine leans and cover type.  Returns TRUE if the cover type changed.
 */
native final function bool AutoAdjustSlot(int SlotIdx, bool bOnlyCheckLeans);
native final function bool IsEnabled();


/**
 * Overridden to disable all slots when toggled off.
 */
function OnToggle(SeqAct_Toggle inAction)
{
	local int SlotIdx;

	Super.OnToggle( inAction );

	// Call OnToggle for slot markers also
	for( SlotIdx = 0; SlotIdx < Slots.Length; SlotIdx++ )
	{
		if( Slots[SlotIdx].SlotMarker != None )
		{
			Slots[SlotIdx].SlotMarker.OnToggle( inAction );
		}
	}
}

simulated function bool GetSwatTurnTarget( int SlotIdx, int Direction, out CoverReference out_Info )
{
	local int TurnIdx, Num;

	Num = Slots[SlotIdx].TurnTarget.Length;
	for( TurnIdx = 0; TurnIdx < Num; TurnIdx++ )
	{
		if( Slots[SlotIdx].TurnTarget[TurnIdx].Direction == Direction )
		{
			out_Info.Nav		= Slots[SlotIdx].TurnTarget[TurnIdx].Nav;
			out_Info.SlotIdx	= Slots[SlotIdx].TurnTarget[TurnIdx].SlotIdx;
			out_Info.Direction  = Slots[SlotIdx].TurnTarget[TurnIdx].Direction;
			break;
		}
	}

	return (out_Info.Nav != None);
}

//debug

simulated event Tick( float DeltaTime )
{
	local int SlotIdx;
	local CoverSlot Slot;
	local Vector OwnerLoc;
	local byte R, G, B;

	super.Tick( DeltaTime );


	if( bDebug )
	{
		for( SlotIdx = 0; SlotIdx < Slots.Length; SlotIdx++ )
		{
			Slot = Slots[SlotIdx];
			if( Slot.SlotOwner != None )
			{
				if( Slot.SlotOwner.Pawn != None )
				{
					OwnerLoc = Slot.SlotOwner.Pawn.Location;
					R = 166;
					G = 236;
					B = 17;
				}
				else
				{
					OwnerLoc = vect(0,0,0);
					R = 170;
					G = 0;
					B = 0;
				}

				DrawDebugLine( GetSlotLocation(SlotIdx), OwnerLoc, R, G, B );
			}
		}
	}
}


native final function int AddCoverSlot(vector SlotLocation, rotator SlotRotation, optional int SlotIdx = -1, optional bool bForceSlotUpdate);

defaultproperties
{
   Slots(0)=(LocationOffset=(X=64.000000,Y=0.000000,Z=0.000000),bCanMantle=True,bCanCoverSlip_Left=True,bCanCoverSlip_Right=True,bCanSwatTurn_Left=True,bCanSwatTurn_Right=True,bEnabled=True,bAllowPopup=True,bAllowMantle=True,bAllowCoverSlip=True,bAllowSwatTurn=True,LeanTraceDist=64.000000)
   bAutoSort=True
   bAutoAdjust=True
   MaxFireLinkDist=2048.000000
   AlignDist=34.000000
   StandHeight=130.000000
   MidHeight=70.000000
   PerchWallHeight=160.000000
   PerchWallNudge=4.000000
   StandingLeanOffset=(X=0.000000,Y=78.000000,Z=69.000000)
   CrouchLeanOffset=(X=0.000000,Y=70.000000,Z=19.000000)
   PopupOffset=(X=0.000000,Y=0.000000,Z=70.000000)
   SlipDist=152.000000
   TurnDist=512.000000
   bSpecialMove=True
   bBuildLongPaths=False
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      CollisionHeight=58.000000
      CollisionRadius=48.000000
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      Sprite=Texture2D'EngineResources.CoverNodeNone'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=CoverMeshComponent Name=CoverMesh ObjName=CoverMesh Archetype=CoverMeshComponent'Engine.Default__CoverMeshComponent'
      bUsePrecomputedShadows=False
      Name="CoverMesh"
      ObjectArchetype=CoverMeshComponent'Engine.Default__CoverMeshComponent'
   End Object
   Components(4)=CoverMesh
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__CoverLink"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
