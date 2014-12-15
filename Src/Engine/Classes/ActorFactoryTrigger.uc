/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryTrigger extends ActorFactory
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

defaultproperties
{
   MenuName="Add Trigger"
   NewActorClass=Class'Engine.Trigger'
   Name="Default__ActorFactoryTrigger"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
