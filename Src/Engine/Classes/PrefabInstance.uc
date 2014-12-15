/**
 * An Actor representing an instance of a Prefab in a level.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PrefabInstance extends Actor
	native(Prefab);

/** The prefab that this is an instance of. */
var		const		Prefab					TemplatePrefab;

/**
 *	The version of the Prefab that this is an instance of.
 *	This allows us to detect if the prefab has changed, and the instance needs to be updated.
 */
var		const		int						TemplateVersion;

/** Mapping from archetypes in the source prefab (TemplatePrefab) to instances of those archetypes in this PrefabInstance. */
var		const native Map{UObject*,UObject*}	ArchetypeToInstanceMap;

/** Kismet sequence that was created for this PrefabInstance. */
var		const		Sequence				SequenceInstance;


/** Contains the epic+licensee version that this PrefabInstance's package was saved with. */
var	const			int						PI_PackageVersion;
var	const			int						PI_LicenseePackageVersion;

var	const			array<byte>				PI_Bytes;
var	const			array<object>			PI_CompleteObjects;
var	const			array<object>			PI_ReferencedObjects;
var	const			array<string>			PI_SavedNames;
var	const native	Map{UObject*,INT}		PI_ObjectMap;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   PI_PackageVersion=-1
   PI_LicenseePackageVersion=-1
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EngineResources.PrefabSprite'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__PrefabInstance"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
