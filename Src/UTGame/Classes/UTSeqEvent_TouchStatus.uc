/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqEvent_TouchStatus extends SeqEvent_Touch
	native(Sequence)
	hidecategories(SeqEvent_Touch);

/** internal - set when checking activation; indicates whether it's a touch check or untouch check */
var const private transient bool bCheckingTouch;

/** TRUE if this trigger only works for heroes */
var() bool bIsHeroOnly;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bForceOverlapping=False
   MaxTriggerCount=0
   ReTriggerDelay=0.000000
   OutputLinks(0)=(LinkDesc="First Touch")
   OutputLinks(1)=(LinkDesc="All UnTouched")
   ObjName="Touch Status"
   Name="Default__UTSeqEvent_TouchStatus"
   ObjectArchetype=SeqEvent_Touch'Engine.Default__SeqEvent_Touch'
}
