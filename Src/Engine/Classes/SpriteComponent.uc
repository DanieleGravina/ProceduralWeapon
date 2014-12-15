/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SpriteComponent extends PrimitiveComponent
	native
	noexport
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var() Texture2D	Sprite;
var() bool		bIsScreenSizeScaled;
var() float		ScreenSize;

defaultproperties
{
   Sprite=Texture2D'EngineResources.S_Actor'
   ScreenSize=0.100000
   Name="Default__SpriteComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
