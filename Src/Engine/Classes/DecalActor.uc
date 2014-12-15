/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class DecalActor extends Actor
	native(Decal)
	placeable;

var() editconst const DecalComponent Decal;

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
   Begin Object Class=DecalComponent Name=NewDecalComponent ObjName=NewDecalComponent Archetype=DecalComponent'Engine.Default__DecalComponent'
      bStaticDecal=True
      Name="NewDecalComponent"
      ObjectArchetype=DecalComponent'Engine.Default__DecalComponent'
   End Object
   Decal=NewDecalComponent
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Components(1)=NewDecalComponent
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(2)=ArrowComponent0
   bStatic=True
   bMovable=False
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DecalActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
