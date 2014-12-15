/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryMover extends ActorFactoryDynamicSM
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

defaultproperties
{
   MenuName="Add InterpActor"
   NewActorClass=Class'Engine.InterpActor'
   Name="Default__ActorFactoryMover"
   ObjectArchetype=ActorFactoryDynamicSM'Engine.Default__ActorFactoryDynamicSM'
}
