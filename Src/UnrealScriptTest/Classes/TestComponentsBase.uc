/**
 * Base class for grouping all unrealscript component testing classes.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class TestComponentsBase extends ActorComponent
	native;

/**
 * the value for this property will not be modified in instances of this component.
 */
var()			int						UnmodifiedInt;

/**
 * the value for this property will be modified in instances of this component.
 */
var()			float					ModifiedFloat;

defaultproperties
{
   UnmodifiedInt=10
   ModifiedFloat=10.000000
   Name="Default__TestComponentsBase"
   ObjectArchetype=ActorComponent'Engine.Default__ActorComponent'
}
