/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CameraMode extends Object
	native;

simulated function ProcessViewRotation( float DeltaTime, Actor ViewTarget, out Rotator out_ViewRotation, out Rotator out_DeltaRot );

function bool AllowPawnRotation() 
{
	return TRUE;
}

defaultproperties
{
   Name="Default__CameraMode"
   ObjectArchetype=Object'Core.Default__Object'
}
