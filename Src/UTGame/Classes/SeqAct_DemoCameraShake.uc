/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_DemoCameraShake extends SequenceAction;

var() DemoCamMod_ScreenShake.ScreenShakeStruct	CameraShake;

var() float		GlobalScale;
var() float		GlobalAmplitudeScale; 
var() float		GlobalFrequencyScale;

defaultproperties
{
   CameraShake=(TimeDuration=1.000000,RotAmplitude=(X=100.000000,Y=100.000000,Z=200.000000),RotFrequency=(X=10.000000,Y=10.000000,Z=25.000000),LocAmplitude=(X=0.000000,Y=3.000000,Z=5.000000),LocFrequency=(X=1.000000,Y=10.000000,Z=20.000000),FOVAmplitude=2.000000,FOVFrequency=5.000000)
   GlobalScale=1.000000
   GlobalAmplitudeScale=1.000000
   GlobalFrequencyScale=1.000000
   InputLinks(0)=(LinkDesc="Timed")
   InputLinks(1)=(LinkDesc="Continuous")
   InputLinks(2)=(LinkDesc="Stop")
   ObjName="Camera Shake"
   ObjCategory="DemoGame"
   Name="Default__SeqAct_DemoCameraShake"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
