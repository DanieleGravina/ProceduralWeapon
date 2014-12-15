/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDecalManager extends DecalManager;

function bool CanSpawnDecals()
{
	return (!class'Engine'.static.IsSplitScreen() && Super.CanSpawnDecals());
}

defaultproperties
{
   Begin Object Class=DecalComponent Name=BaseDecal ObjName=BaseDecal Archetype=DecalComponent'Engine.Default__DecalManager:BaseDecal'
      ObjectArchetype=DecalComponent'Engine.Default__DecalManager:BaseDecal'
   End Object
   DecalTemplate=BaseDecal
   Name="Default__UTDecalManager"
   ObjectArchetype=DecalManager'Engine.Default__DecalManager'
}
