/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTTankMuzzleFlash extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=600.000000,Brightness=8.000000,LightColor=(B=255,G=255,R=255,A=255))
   TimeShift(1)=(StartTime=0.250000,Radius=350.000000,Brightness=8.000000,LightColor=(B=128,G=255,R=255,A=255))
   TimeShift(2)=(StartTime=0.300000,Radius=200.000000,LightColor=(B=64,G=255,R=255,A=255))
   Radius=400.000000
   Name="Default__UTTankMuzzleFlash"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}
