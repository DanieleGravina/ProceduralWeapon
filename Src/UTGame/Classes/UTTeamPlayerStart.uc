/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTTeamPlayerStart extends PlayerStart
	native;

/** Locker to get weapons from for spawning player */
var UTWeaponLocker BestLocker;

/** True if tried and failed to find a best locker */
var bool bNoLockerFound;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

// Players on different teams are not spawned in areas with the
// same TeamNumber unless there are more teams in the level than
// team numbers.
var() byte TeamNumber;			// what team can spawn at this start

// sprites used for this actor in the editor, depending on which team it's on
var editoronly array<Texture2D> TeamSprites;

function UTWeaponLocker GetBestLocker()
{
	local UTWeaponLocker Locker;
	local float Dist, BestDist;

	if ( (BestLocker == None) && !bNoLockerFound )
	{
		// find nearest weapon locker and provide the weapons
		ForEach DynamicActors(class'UTWeaponLocker', Locker)
		{
			Dist = VSizeSq(Location - Locker.Location);
			if ( (BestLocker == None) || (BestDist > Dist) )
			{
				BestDist = Dist;
				BestLocker = Locker;
			}
		}
		bNoLockerFound = ( BestLocker == None );
	}
	return BestLocker;
}

defaultproperties
{
   TeamSprites(0)=Texture2D'EnvyEditorResources.S_Player_Red'
   TeamSprites(1)=Texture2D'EnvyEditorResources.S_Player_Blue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__PlayerStart:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__PlayerStart:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__PlayerStart:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__PlayerStart:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__PlayerStart:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__PlayerStart:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__PlayerStart:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__PlayerStart:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__PlayerStart:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__PlayerStart:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTTeamPlayerStart"
   ObjectArchetype=PlayerStart'Engine.Default__PlayerStart'
}
