/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryStaticMesh extends ActorFactory
	config(Editor)
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	StaticMesh		StaticMesh;
var()	vector			DrawScale3D;

defaultproperties
{
   DrawScale3D=(X=1.000000,Y=1.000000,Z=1.000000)
   MenuName="Add StaticMesh"
   MenuPriority=2
   NewActorClass=Class'Engine.StaticMeshActor'
   Name="Default__ActorFactoryStaticMesh"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
