/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTPowerCorePanel extends Actor
	abstract;

/** sound of the panel breaking off, played on spawn */
var SoundCue BreakSound;
/** sound when hitting something */
var SoundCue HitSound;

var StaticMeshComponent Mesh;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	PlaySound(BreakSound, true);
}

simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
					const out CollisionImpactData RigidCollisionData, int ContactIndex )
{
	if (LifeSpan < 7.3)
	{
		PlaySound(HitSound, true);
		Mesh.SetNotifyRigidBodyCollision(false);
	}
}

defaultproperties
{
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTPowerCorePanel"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
