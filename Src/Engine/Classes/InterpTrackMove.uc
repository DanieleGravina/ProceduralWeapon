class InterpTrackMove extends InterpTrack
	native(Interpolation);

/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Track containing data for moving an actor around over time.
 * There is no UpdateTrack function. In the game, its the PHYS_Interpolating physics mode which 
 * updates the position based on the interp track.
 */

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Actual position keyframe data. */
var		InterpCurveVector	PosTrack;

/** Actual rotation keyframe data, stored as Euler angles in degrees, for easy editing on curve. */
var		InterpCurveVector	EulerTrack;

/** 
 * Array of group names to retrieve position and rotation data from instead of using the datastored in the keyframe. 
 * A value of NAME_None means to use the PosTrack and EulerTrack data for the keyframe.
 * There needs to be the same amount of elements in this array as there are keyframes. 
 */
struct native InterpLookupPoint
{
	var name	GroupName;
	var float	Time;
};

struct native InterpLookupTrack
{
	structcpptext
	{
		/** Add a new keypoint to the LookupTrack.  Returns the index of the new key.*/
		INT AddPoint( const FLOAT InTime, FName &InGroupName )
		{
			INT PointIdx=0; 
			
			for( PointIdx=0; PointIdx<Points.Num() && Points(PointIdx).Time < InTime; PointIdx++);
			
			Points.Insert(PointIdx);
			Points(PointIdx).Time = InTime;
			Points(PointIdx).GroupName = InGroupName;

			return PointIdx;
		}

		/** Move a keypoint to a new In value. This may change the index of the keypoint, so the new key index is returned. */
		INT MovePoint( INT PointIndex, FLOAT NewTime )
		{
			if( PointIndex < 0 || PointIndex >= Points.Num() )
			{
				return PointIndex;
			}

			FName GroupName = Points(PointIndex).GroupName;

			Points.Remove(PointIndex);

			const INT NewPointIndex = AddPoint( NewTime, GroupName );

			return NewPointIndex;
		}
	}

	var array<InterpLookupPoint>	Points;
};

var		InterpLookupTrack	LookupTrack;

/** When using IMR_LookAtGroup, specifies the Group which this track should always point its actor at. */
var()	name				LookAtGroupName;

/** Controls the tightness of the curve for the translation path. */
var()	float				LinCurveTension;

/** Controls the tightness of the curve for the rotation path. */
var()	float				AngCurveTension;

/** 
 *	Use a Quaternion linear interpolation between keys. 
 *	This is robust and will find the 'shortest' distance between keys, but does not support ease in/out.
 */
var()	bool				bUseQuatInterpolation;

/** In the editor, show a small arrow at each keyframe indicating the rotation at that key. */
var()	bool				bShowArrowAtKeys;

/** Disable previewing of this track - will always position Actor at Time=0.0. Useful when keyframing an object relative to this group. */
var()	bool				bDisableMovement;

/** If false, when this track is displayed on the Curve Editor in Matinee, do not show the Translation tracks. */
var()	bool				bShowTranslationOnCurveEd;

/** If false, when this track is displayed on the Curve Editor in Matinee, do not show the Rotation tracks. */
var()	bool				bShowRotationOnCurveEd;

/** If true, 3D representation of this track in the 3D viewport is disabled. */
var()	bool				bHide3DTrack;

enum EInterpTrackMoveFrame
{
	/** Track should be fixed relative to the world. */
	IMF_World,

	/** Track should move relative to the initial position of the actor when the interp sequence was started. */
	IMF_RelativeToInitial
};

/** Indicates what the movement track should be relative to. */
var()	editconst EInterpTrackMoveFrame	MoveFrame;


enum EInterpTrackMoveRotMode
{
	/** Should take orientation from the . */
	IMR_Keyframed,

	/** Point the X-Axis of the controlled Actor at the group specified by LookAtGroupName. */
	IMR_LookAtGroup

	/** Should look along the direction of the translation path, with Z always up. */
	// IMR_LookAlongPath // TODO!
};

var()	EInterpTrackMoveRotMode RotMode;

defaultproperties
{
   bShowTranslationOnCurveEd=True
   TrackInstClass=Class'Engine.InterpTrackInstMove'
   TrackTitle="Movement"
   bOnePerGroup=True
   Name="Default__InterpTrackMove"
   ObjectArchetype=InterpTrack'Engine.Default__InterpTrack'
}
