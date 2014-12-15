/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_ActorFactory extends SeqAct_Latent
	native(Sequence);

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

enum EPointSelection
{
	/** Try each spawn point in a linear method */
	PS_Normal,
	/** Pick the first available randomly selected point */
	PS_Random,
	/** PS_Normal, but in reverse */
	PS_Reverse,
};

/** Is this factory enabled? */
var() bool bEnabled;

/** Is this factory currently in the process of spawning? */
var bool bIsSpawning;

/** Type of actor factory to use when creating the actor */
var() export editinline ActorFactory Factory;

/** Method of spawn point selection */
var() EPointSelection				PointSelection;

/** Set of points where Objects will be spawned */
var() array<Actor> SpawnPoints;

/** Number of actors to create */
var() int							SpawnCount;

/** Delay applied after creating an actor before creating the next one */
var() float							SpawnDelay;

/** Prevent spawning at locations with bBlockActors */
var() bool							bCheckSpawnCollision;

/** Last index used to spawn at, for PS_Normal/PS_Reverse */
var int LastSpawnIdx;

/** Number of actors spawned so far */
var int	SpawnedCount;

/** Remaining time before attempting the next spawn */
var float RemainingDelay;

defaultproperties
{
   bEnabled=True
   bCheckSpawnCollision=True
   SpawnCount=1
   SpawnDelay=0.500000
   LastSpawnIdx=-1
   InputLinks(0)=(LinkDesc="Spawn Actor")
   InputLinks(1)=(LinkDesc="Enable")
   InputLinks(2)=(LinkDesc="Disable")
   InputLinks(3)=(LinkDesc="Toggle")
   VariableLinks(0)=(LinkDesc="Spawn Point",PropertyName="SpawnPoints")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Spawned",bWriteable=True,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Spawn Count",PropertyName="SpawnCount",MinVars=1,MaxVars=255)
   ObjName="Actor Factory"
   ObjCategory="Actor"
   Name="Default__SeqAct_ActorFactory"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
