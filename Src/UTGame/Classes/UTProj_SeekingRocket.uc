/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_SeekingRocket extends UTProj_Rocket
	native;

var Actor Seeking;
var vector InitialDir;
var bool bSuperSeekAirTargets;

/** The last time a lock message was sent */
var float	LastLockWarningTime;

/** How long before re-sending the next Lock On message update */
var float	LockWarningInterval;

/** Tracking strength multiplier */
var float BaseTrackingStrength;

replication
{
    if( bNetInitial && (Role==ROLE_Authority) )
        Seeking, InitialDir;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   BaseTrackingStrength=1.000000
   CheckRadius=0.000000
   bRotationFollowsVelocity=True
   MyDamageType=Class'UTGame.UTDmgType_SeekingRocket'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SeekingRocket"
   ObjectArchetype=UTProj_Rocket'UTGame.Default__UTProj_Rocket'
}
