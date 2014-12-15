/**
 *	CameraAnim: defines a pre-packaged animation to be played on a camera.
 * 	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CameraAnim extends Object
	notplaceable
	native;

/** The InterpGroup that holds our actual interpolation data. */
var InterpGroup		CameraInterpGroup;

/** Length, in seconds. */
var float			AnimLength;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   AnimLength=3.000000
   Name="Default__CameraAnim"
   ObjectArchetype=Object'Core.Default__Object'
}
