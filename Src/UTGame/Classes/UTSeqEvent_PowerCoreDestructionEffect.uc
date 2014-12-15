/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** client side event triggered by power core when it wants to play its destruction effect
 * use this to make a level specific effect instead of the default
 */
class UTSeqEvent_PowerCoreDestructionEffect extends SequenceEvent;

/** skeletal mesh actor the power core spawns (for e.g. matinee control) */
var SkeletalMeshActor MeshActor;

defaultproperties
{
   MaxTriggerCount=0
   bPlayerOnly=False
   bClientSideOnly=True
   VariableLinks(0)=(LinkDesc="Skeletal Mesh Actor",PropertyName="MeshActor")
   ObjName="Play Core Destruction"
   Name="Default__UTSeqEvent_PowerCoreDestructionEffect"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
