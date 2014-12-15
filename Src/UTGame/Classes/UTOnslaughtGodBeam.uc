/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtGodBeam extends Actor
	native(Onslaught)
	notplaceable;

var StaticMeshComponent NodeBeamEffect;
var private transient	MaterialInstanceConstant BeamMaterialInstance;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	CreateBeamMaterialInstance();
}

simulated function CreateBeamMaterialInstance()
{
	BeamMaterialInstance = NodeBeamEffect.CreateAndSetMaterialInstanceConstant(0);
	BeamMaterialInstance.SetVectorParameterValue('Team', class'UTOnslaughtNodeObjective'.Default.BeamColor[2]);
}

defaultproperties
{
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTOnslaughtGodBeam"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
