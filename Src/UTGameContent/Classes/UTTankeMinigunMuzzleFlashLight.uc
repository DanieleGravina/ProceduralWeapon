/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTTankeMinigunMuzzleFlashLight extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=192.000000,Brightness=15.000000,LightColor=(B=255,G=255,R=255,A=255))
   TimeShift(1)=(StartTime=0.100000,Radius=96.000000,Brightness=6.000000,LightColor=(B=128,G=255,R=255,A=255))
   TimeShift(2)=(StartTime=0.150000,Radius=64.000000,LightColor=(B=64,G=255,R=255,A=255))
   Radius=192.000000
   Name="Default__UTTankeMinigunMuzzleFlashLight"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}
