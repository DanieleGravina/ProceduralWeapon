/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryCoverLink extends ActorFactory
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

defaultproperties
{
   MenuName="Add CoverLink"
   NewActorClass=Class'Engine.CoverLink'
   SpecificGameName="War"
   Name="Default__ActorFactoryCoverLink"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
