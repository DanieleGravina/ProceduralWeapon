/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTStingerTurretMuzzleFlashLight extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=160.000000,Brightness=8.000000,LightColor=(B=255,G=128,R=64,A=255))
   TimeShift(1)=(StartTime=0.100000,Radius=96.000000,Brightness=8.000000,LightColor=(B=128,G=0,R=0,A=255))
   TimeShift(2)=(StartTime=0.150000,Radius=64.000000,LightColor=(B=64,G=0,R=0,A=255))
   Radius=160.000000
   Name="Default__UTStingerTurretMuzzleFlashLight"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}