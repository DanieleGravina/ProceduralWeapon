/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqEvent_TurretStatusChanged extends SequenceEvent;

defaultproperties
{
   MaxTriggerCount=0
   bPlayerOnly=False
   OutputLinks(0)=(LinkDesc="Created")
   OutputLinks(1)=(LinkDesc="Destroyed")
   OutputLinks(2)=(LinkDesc="Player Enter")
   OutputLinks(3)=(LinkDesc="Player Exit")
   ObjName="Turret Status Changed"
   Name="Default__UTSeqEvent_TurretStatusChanged"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
