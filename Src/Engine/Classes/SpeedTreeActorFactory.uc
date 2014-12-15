/*=============================================================================
	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
=============================================================================*/
 
class SpeedTreeActorFactory extends ActorFactory
	config(Editor)
	native(SpeedTree);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() SpeedTree	SpeedTree;

defaultproperties
{
   MenuName="Add SpeedTree"
   NewActorClass=Class'Engine.SpeedTreeActor'
   Name="Default__SpeedTreeActorFactory"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
