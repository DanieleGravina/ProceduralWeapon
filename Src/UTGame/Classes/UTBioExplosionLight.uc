/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTBioExplosionLight extends UTExplosionLight;

defaultproperties
{
   HighDetailFrameTime=0.020000
   TimeShift(0)=(Radius=48.000000,Brightness=20.000000,LightColor=(B=128,G=255,R=128,A=255))
   TimeShift(1)=(StartTime=0.110000,Radius=48.000000,Brightness=10.000000,LightColor=(B=64,G=255,R=64,A=255))
   TimeShift(2)=(StartTime=0.150000,Radius=32.000000,LightColor=(B=0,G=255,R=0,A=255))
   Radius=48.000000
   Brightness=200.000000
   LightColor=(B=192,G=255,R=128,A=255)
   Name="Default__UTBioExplosionLight"
   ObjectArchetype=UTExplosionLight'UTGame.Default__UTExplosionLight'
}
