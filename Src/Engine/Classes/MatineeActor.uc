// Actor used by matinee (SeqAct_Interp) objects to replicate activation, playback, and other relevant flags to net clients
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class MatineeActor extends Actor
	native
	nativereplication;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** the SeqAct_Interp associated with this actor (this is set in C++ by the action that spawns this actor)
 *	on the client, the MatineeActor will tick this SeqAct_Interp and notify the actors it should be affecting
 */
var const SeqAct_Interp InterpAction;
/** properties that may change on InterpAction that we need to notify clients about, since the object's properties will not be replicated */
var bool bIsPlaying, bReversePlayback, bPaused;
var float PlayRate;
var float Position;

replication
{
	if (bNetInitial && Role == ROLE_Authority)
		InterpAction;

	if (bNetDirty && Role == ROLE_Authority)
		bIsPlaying, bReversePlayback, bPaused, PlayRate, Position;
}

/** called by InterpAction when significant changes occur. Updates replicated data. */
event Update()
{
	bIsPlaying = InterpAction.bIsPlaying;
	bReversePlayback = InterpAction.bReversePlayback;
	bPaused = InterpAction.bPaused;
	PlayRate = InterpAction.PlayRate;
	Position = InterpAction.Position;
	bForceNetUpdate = TRUE;
}

defaultproperties
{
   PlayRate=1.000000
   Position=-1.000000
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   RemoteRole=ROLE_SimulatedProxy
   bAlwaysRelevant=True
   bReplicateMovement=False
   bSkipActorPropertyReplication=True
   bOnlyDirtyReplication=True
   NetUpdateFrequency=1.000000
   NetPriority=2.700000
   CollisionType=COLLIDE_CustomDefault
   Name="Default__MatineeActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
