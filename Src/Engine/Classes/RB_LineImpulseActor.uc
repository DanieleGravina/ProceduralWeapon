/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class RB_LineImpulseActor extends Actor
	native(Physics)
	placeable;

/**
 *	Similar to the RB_RadialImpulseActor, but does a line-check and applies an impulse to all Actors using rigid-bodies that it hits.
 */


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Strength of impulse to apply to actors hit by the line check. */
var()	float			ImpulseStrength;

/** Length of line to check along. */
var()	float			ImpulseRange;

/** If true, the Strength is taken as a change in velocity instead of an impulse (ie. mass will have no affect). */
var()	bool			bVelChange;

/** If an impulse should only be applied to the first thing the line hits, or all things in the lines path. */
var()	bool			bStopAtFirstHit;

var		ArrowComponent	Arrow;

var repnotify byte ImpulseCount;

replication
{
	if (bNetDirty)
		ImpulseCount;
}

/** Do the line check and apply impulse now. */
native final function FireLineImpulse();

/** Handling Toggle event from Kismet. */
simulated function OnToggle(SeqAct_Toggle inAction)
{
	if (inAction.InputLinks[0].bHasImpulse)
	{
		FireLineImpulse();
		ImpulseCount++;
		bForceNetUpdate = TRUE;
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'ImpulseCount')
	{
		FireLineImpulse();
	}
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   ImpulseStrength=900.000000
   ImpulseRange=200.000000
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowSize=4.166670
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Arrow=ArrowComponent0
   Components(0)=ArrowComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EngineResources.S_LineImpulse'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(1)=Sprite
   RemoteRole=ROLE_SimulatedProxy
   bNoDelete=True
   bAlwaysRelevant=True
   bOnlyDirtyReplication=True
   bEdShouldSnap=True
   NetUpdateFrequency=0.100000
   CollisionType=COLLIDE_CustomDefault
   Name="Default__RB_LineImpulseActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
