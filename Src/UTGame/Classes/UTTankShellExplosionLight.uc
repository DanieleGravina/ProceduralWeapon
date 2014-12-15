/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTTankShellExplosionLight extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=384.000000,Brightness=32.000000,LightColor=(B=255,G=255,R=255,A=255))
   TimeShift(1)=(StartTime=0.400000,Radius=256.000000,Brightness=8.000000,LightColor=(B=128,G=255,R=255,A=255))
   TimeShift(2)=(StartTime=0.500000,Radius=192.000000,LightColor=(B=96,G=255,R=255,A=255))
   Radius=384.000000
   Brightness=32.000000
   Name="Default__UTTankShellExplosionLight"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}
