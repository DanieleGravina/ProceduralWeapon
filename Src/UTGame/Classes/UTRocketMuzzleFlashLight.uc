/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTRocketMuzzleFlashLight extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=160.000000,Brightness=8.000000,LightColor=(B=255,G=255,R=255,A=255))
   TimeShift(1)=(StartTime=0.200000,Radius=96.000000,Brightness=5.000000,LightColor=(B=128,G=255,R=255,A=255))
   TimeShift(2)=(StartTime=0.250000,Radius=96.000000,LightColor=(B=64,G=255,R=255,A=255))
   Radius=192.000000
   Name="Default__UTRocketMuzzleFlashLight"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}
