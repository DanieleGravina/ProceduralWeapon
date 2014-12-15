/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Used to affect reverb settings in the game and editor.
 */
class ReverbVolume extends Volume
	native
	placeable
	hidecategories(Advanced,Attachment,Collision,Volume);

/**
 * Indicates a reverb preset to use.
 */
enum ReverbPreset
{
    REVERB_Default,
    REVERB_Bathroom,
    REVERB_StoneRoom,
    REVERB_Auditorium,
    REVERB_ConcertHall,
    REVERB_Cave,
    REVERB_Hallway,
    REVERB_StoneCorridor,
    REVERB_Alley,
    REVERB_Forest,
    REVERB_City,
    REVERB_Mountains,
    REVERB_Quarry,
    REVERB_Plain,
    REVERB_ParkingLot,
    REVERB_SewerPipe,
    REVERB_Underwater,
    REVERB_SmallRoom,
    REVERB_MediumRoom,
    REVERB_LargeRoom,
    REVERB_MediumHall,
    REVERB_LargeHall,
    REVERB_Plate,
};

/** Struct encapsulating settings for reverb effects. */
struct native ReverbSettings
{
	/** The reverb preset to employ. */
	var() ReverbPreset	ReverbType;

	/** Volume level of the reverb affect. */
	var() float			Volume;

	/** Time to fade from the current reverb settings into this setting, in seconds. */
	var() float			FadeTime;

	structdefaultproperties
	{
		ReverbType=REVERB_Default
		Volume=0.5
		FadeTime=2.0
	}
};

/**
 * Priority of this volume. In the case of overlapping volumes the one with the highest priority
 * is chosen. The order is undefined if two or more overlapping volumes have the same priority.
 */
var()							float				Priority;

/** Reverb settings to use for this volume. */
var()							ReverbSettings		Settings;

/** Next volume in linked listed, sorted by priority in descending order. */
var const noimport transient	ReverbVolume		NextLowerPriorityVolume;

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

defaultproperties
{
   Settings=(Volume=0.500000,FadeTime=2.000000)
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
      CollideActors=False
      BlockNonZeroExtent=False
      ObjectArchetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bCollideActors=False
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__ReverbVolume"
   ObjectArchetype=Volume'Engine.Default__Volume'
}
