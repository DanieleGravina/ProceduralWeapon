//=============================================================================
// Deprecated.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ZoneInfo extends Info
	native;

//-----------------------------------------------------------------------------
// Zone properties.

var() float KillZ;		// any actor falling below this level gets destroyed
var() float SoftKill;
var() class<KillZDamageType> KillZDamageType<AllowAbstract>;
var() bool bSoftKillZ;	// SoftKill units of grace unless land

defaultproperties
{
   KillZ=-262143.000000
   SoftKill=2500.000000
   KillZDamageType=Class'Engine.KillZDamageType'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   bStatic=True
   bNoDelete=True
   bGameRelevant=True
   Name="Default__ZoneInfo"
   ObjectArchetype=Info'Engine.Default__Info'
}
