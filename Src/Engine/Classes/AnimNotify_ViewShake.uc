/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class AnimNotify_ViewShake extends AnimNotify_Scripted;

/** radius within which to shake player views */
var()	float	ShakeRadius;
/** Duration in seconds of shake */
var()	float	Duration;
/** view rotation amplitude (pitch,yaw,roll) */
var()	vector	RotAmplitude;
/** frequency of rotation shake */
var()	vector	RotFrequency;
/** relative view offset amplitude (x,y,z) */
var()	vector	LocAmplitude;
/** frequency of view offset shake */
var()	vector	LocFrequency;
/** fov shake amplitude */
var()	float	FOVAmplitude;
/** fov shake frequency */
var()	float	FOVFrequency;

/** Should use a bone location as shake's epicentre? */
var()	bool	bUseBoneLocation;
/** if so, bone name to use */
var()	name	BoneName;

event Notify( Actor Owner, AnimNodeSequence AnimSeqInstigator )
{
	local PlayerController PC;
	local float			Pct, DistToOrigin;
	local vector		ViewShakeOrigin, CamLoc;
	local rotator		CamRot;

	// Figure out world origin of view shake
	if( bUseBoneLocation &&
		AnimSeqInstigator != None &&
		AnimSeqInstigator.SkelComponent != None )
	{
		ViewShakeOrigin = AnimSeqInstigator.SkelComponent.GetBoneLocation( BoneName );
	}
	else
	{
		ViewShakeOrigin = Owner.Location;
	}

	// propagate to all player controllers
	if (Owner != None)
	{
		foreach Owner.WorldInfo.AllControllers(class'PlayerController', PC)
		{
			PC.GetPlayerViewPoint(CamLoc, CamRot);
			DistToOrigin = VSize(ViewShakeOrigin - CamLoc);
			if( DistToOrigin < ShakeRadius )
			{
				Pct = 1.f - (DistToOrigin / ShakeRadius);
				PC.CameraShake
				(
					Duration*Pct,
					RotAmplitude*Pct,
					RotFrequency*Pct,
					LocAmplitude*Pct,
					LocFrequency*Pct,
					FOVAmplitude*Pct,
					FOVFrequency*Pct
				);
			}
		}
	}
}

defaultproperties
{
   ShakeRadius=4096.000000
   Duration=1.000000
   RotAmplitude=(X=100.000000,Y=100.000000,Z=200.000000)
   RotFrequency=(X=10.000000,Y=10.000000,Z=25.000000)
   LocAmplitude=(X=0.000000,Y=3.000000,Z=6.000000)
   LocFrequency=(X=1.000000,Y=10.000000,Z=20.000000)
   FOVAmplitude=2.000000
   FOVFrequency=5.000000
   Name="Default__AnimNotify_ViewShake"
   ObjectArchetype=AnimNotify_Scripted'Engine.Default__AnimNotify_Scripted'
}
