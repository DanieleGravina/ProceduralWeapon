/** volume that doesn't do anything - just used to name areas for displaying on the scoreboard, etc 
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/
class UTAreaNamingVolume extends Volume
	hidecategories(Volume)
	placeable;

defaultproperties
{
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
      ObjectArchetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTAreaNamingVolume"
   ObjectArchetype=Volume'Engine.Default__Volume'
}
