/**
 * Event which is activated by gameplay code when a projectile lands.
 * Originator: the Pawn that owns this event.
 * Instigator: a projectile actor which was fired by the Pawn that owns this event
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_ProjectileLanded extends SequenceEvent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() float MaxDistance;

defaultproperties
{
   bPlayerOnly=False
   VariableLinks(0)=(LinkDesc="Projectile")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Shooter",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Witness",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Projectile Landed"
   ObjCategory="Physics"
   Name="Default__SeqEvent_ProjectileLanded"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
