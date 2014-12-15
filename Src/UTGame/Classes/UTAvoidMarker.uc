/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// UTAvoidMarker.
// Bots avoid these spots when moving - used for very short term stationary hazards like bio goo or sticky grenades
//=============================================================================
class UTAvoidMarker extends Actor
	native
	notPlaceable;

var byte TeamNum;
var CylinderComponent CollisionCylinder;

simulated native function byte GetTeamNum();

event Touch( actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	if ( (Pawn(Other) != None) && (UTBot(Pawn(Other).Controller) != None) && !WorldInfo.GRI.OnSameTeam(self,Other) )
		UTBot(Pawn(Other).Controller).FearThisSpot(self);
}

function StartleBots()
{
	local Pawn P;

	ForEach TouchingActors(class'Pawn', P)
		if ( (UTBot(P.Controller) != None) && !WorldInfo.GRI.OnSameTeam(self,P.Controller) )
			UTBot(P.Controller).Startle(self);
}

defaultproperties
{
   TeamNum=255
   Begin Object Class=CylinderComponent Name=Cylinder ObjName=Cylinder Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=40.000000
      CollisionRadius=100.000000
      CollideActors=True
      Name="Cylinder"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   CollisionCylinder=Cylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Components(1)=Cylinder
   bCollideActors=True
   CollisionComponent=Cylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTAvoidMarker"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
