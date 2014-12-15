//=============================================================================
// Volume:  a bounding volume
// touch() and untouch() notifications to the volume as actors enter or leave it
// enteredvolume() and leftvolume() notifications when center of actor enters the volume
// pawns with bIsPlayer==true  cause playerenteredvolume notifications instead of actorenteredvolume()
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class Volume extends Brush
	native
	nativereplication;

var Actor AssociatedActor;			// this actor gets touch() and untouch notifications as the volume is entered or left
var(Location) int LocationPriority;
var(Location) localized string LocationName;

/** Should pawns be forced to walk when inside this volume? */
var() bool bForcePawnWalk;
/** Should process all actors within this volume */
var() bool bProcessAllActors;


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

native noexport function bool Encompasses(Actor Other); // returns true if center of actor is within volume

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( AssociatedActor != None )
	{
		GotoState('AssociatedTouch');
		InitialState = GetStateName();
	}
}

simulated function string GetLocationStringFor(PlayerReplicationInfo PRI)
{
	return LocationName;
}

/**
 * list important Volume variables on canvas.  HUD will call DisplayDebug() on the current ViewTarget when
 * the ShowDebug exec is used
 *
 * @param	HUD		- HUD with canvas to draw on
 * @input	out_YL		- Height of the current font
 * @input	out_YPos	- Y position on Canvas. out_YPos += out_YL, gives position to draw text for next debug line.
 */
simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
	super.DisplayDebug(HUD, out_YL, out_YPos);

	HUD.Canvas.DrawText("AssociatedActor "$AssociatedActor, false);
	out_YPos += out_YL;
	HUD.Canvas.SetPos(4, out_YPos);
}

State AssociatedTouch
{
	event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
	{
		AssociatedActor.Touch(Other, OtherComp, HitLocation, HitNormal);
	}

	event untouch( Actor Other )
	{
		AssociatedActor.untouch(Other);
	}

	event BeginState(Name PreviousStateName)
	{
		local Actor A;

		ForEach TouchingActors(class'Actor', A)
			Touch(A, None, A.Location, Vect(0,0,1) );
	}
}

/**	Handling Toggle event from Kismet. */
simulated function OnToggle(SeqAct_Toggle Action)
{
	// Turn ON
	if (Action.InputLinks[0].bHasImpulse)
	{
		if(!bCollideActors)
		{
			SetCollision(true, bBlockActors);
		}
		CollisionComponent.SetBlockRigidBody( TRUE );
	}
	// Turn OFF
	else if (Action.InputLinks[1].bHasImpulse)
	{
		if(bCollideActors)
		{
			SetCollision(false, bBlockActors);
		}
		CollisionComponent.SetBlockRigidBody( FALSE );
	}
	// Toggle
	else if (Action.InputLinks[2].bHasImpulse)
	{
		SetCollision(!bCollideActors, bBlockActors);
		CollisionComponent.SetBlockRigidBody( !CollisionComponent.BlockRigidBody );
	}

	ForceNetRelevant();

	SetForcedInitialReplicatedProperty(Property'Engine.Actor.bCollideActors', (bCollideActors == default.bCollideActors));
}

simulated event CollisionChanged()
{
	// rigid body collision should match Unreal collision
	CollisionComponent.SetBlockRigidBody(bCollideActors);
}

event ProcessActorSetVolume( Actor Other );

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Brush:BrushComponent0'
      bAcceptsLights=True
      LightingChannels=(bInitialized=True,Dynamic=True)
      CollideActors=True
      BlockNonZeroExtent=True
      AlwaysLoadOnClient=True
      AlwaysLoadOnServer=True
      ObjectArchetype=BrushComponent'Engine.Default__Brush:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bSkipActorPropertyReplication=True
   bCollideActors=True
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_TouchAllButWeapons
   Name="Default__Volume"
   ObjectArchetype=Brush'Engine.Default__Brush'
}
