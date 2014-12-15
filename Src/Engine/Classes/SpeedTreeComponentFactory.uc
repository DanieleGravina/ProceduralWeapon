/*=============================================================================
	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
=============================================================================*/
 
class SpeedTreeComponentFactory extends PrimitiveComponentFactory
	native(SpeedTree)
	hidecategories(Object)
	collapsecategories
	editinlinenew;

var() SpeedTreeComponent SpeedTreeComponent;

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
      Name="SpeedTreeComponent0"
      ObjectArchetype=SpeedTreeComponent'Engine.Default__SpeedTreeComponent'
   End Object
   SpeedTreeComponent=SpeedTreeComponent0
   CollideActors=True
   BlockActors=True
   BlockZeroExtent=True
   BlockNonZeroExtent=True
   BlockRigidBody=True
   Name="Default__SpeedTreeComponentFactory"
   ObjectArchetype=PrimitiveComponentFactory'Engine.Default__PrimitiveComponentFactory'
}
