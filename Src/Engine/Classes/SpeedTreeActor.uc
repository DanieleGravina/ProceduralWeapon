/*=============================================================================
	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
=============================================================================*/
 
class SpeedTreeActor extends Actor
	native(SpeedTree)
	placeable;
	
var() const editconst SpeedTreeComponent SpeedTreeComponent;

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
   Begin Object Class=SpeedTreeComponent Name=SpeedTreeComponent0 ObjName=SpeedTreeComponent0 Archetype=SpeedTreeComponent'Engine.Default__SpeedTreeComponent'
      bAllowApproximateOcclusion=True
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Name="SpeedTreeComponent0"
      ObjectArchetype=SpeedTreeComponent'Engine.Default__SpeedTreeComponent'
   End Object
   SpeedTreeComponent=SpeedTreeComponent0
   Components(0)=SpeedTreeComponent0
   bStatic=True
   bNoDelete=True
   bWorldGeometry=True
   bMovable=False
   bCollideActors=True
   bBlockActors=True
   CollisionComponent=SpeedTreeComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__SpeedTreeActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
