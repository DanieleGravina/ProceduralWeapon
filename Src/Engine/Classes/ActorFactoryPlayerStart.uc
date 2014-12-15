/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryPlayerStart extends ActorFactory
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

defaultproperties
{
   MenuName="Add PlayerStart"
   MenuPriority=1
   NewActorClass=Class'Engine.PlayerStart'
   Name="Default__ActorFactoryPlayerStart"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
