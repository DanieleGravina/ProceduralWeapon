/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class RB_RadialImpulseComponent extends PrimitiveComponent
	collapsecategories
	hidecategories(Object)
	native(Physics);

var()	ERadialImpulseFalloff	ImpulseFalloff;
var()	float					ImpulseStrength;
var()	float					ImpulseRadius;
var()	bool					bVelChange;

var		DrawSphereComponent		PreviewSphere;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native function FireImpulse( Vector Origin );

defaultproperties
{
   ImpulseStrength=900.000000
   ImpulseRadius=200.000000
   TickGroup=TG_PreAsyncWork
   Name="Default__RB_RadialImpulseComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
