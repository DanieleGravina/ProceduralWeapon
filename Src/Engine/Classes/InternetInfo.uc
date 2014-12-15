//=============================================================================
// InternetInfo: Parent class for Internet connection classes
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class InternetInfo extends Info
	native
	transient;

function string GetBeaconAddress( int i );
function string GetBeaconText( int i );

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__InternetInfo"
   ObjectArchetype=Info'Engine.Default__Info'
}
