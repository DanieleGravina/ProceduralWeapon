/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactorySkeletalMeshMAT extends ActorFactorySkeletalMesh
	config(Editor)
	hidecategories(Object);

defaultproperties
{
   MenuName="Add SkeletalMeshMAT"
   NewActorClass=Class'Engine.SkeletalMeshActorMAT'
   Name="Default__ActorFactorySkeletalMeshMAT"
   ObjectArchetype=ActorFactorySkeletalMesh'Engine.Default__ActorFactorySkeletalMesh'
}
