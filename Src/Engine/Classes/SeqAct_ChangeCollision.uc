/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class SeqAct_ChangeCollision extends SequenceAction;

var() bool bCollideActors;
var() bool bBlockActors;
var() bool bIgnoreEncroachers;

defaultproperties
{
   ObjName="Change Collision"
   ObjCategory="Actor"
   Name="Default__SeqAct_ChangeCollision"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
