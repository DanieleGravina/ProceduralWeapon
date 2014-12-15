/**
 * An ObjectVolume will replace the normal object references with anything contained within
 * the assigned volume at runtime, allowing designers to quickly reference large areas.
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqVar_ObjectVolume extends SeqVar_Object
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

/** Last time ContainedObjects was udpated */
var float LastUpdateTime;

/** List of objects contained within the volume */
var array<Object> ContainedObjects;

/** List of object types to exclude */
var() array<class<Object> > ExcludeClassList;

/** Should this volume account for non-colliding as well? */
var() bool bCollidingOnly;

defaultproperties
{
   ExcludeClassList(0)=Class'Engine.Trigger'
   ExcludeClassList(1)=Class'Engine.Volume'
   bCollidingOnly=True
   ObjName="Object Volume"
   Name="Default__SeqVar_ObjectVolume"
   ObjectArchetype=SeqVar_Object'Engine.Default__SeqVar_Object'
}
