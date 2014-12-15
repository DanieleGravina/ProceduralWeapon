/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_FlakShell extends UTDmgType_FlakShard
	abstract;

defaultproperties
{
   bThrowRagdoll=True
   GibPerterbation=0.250000
   DamageCameraAnim=CameraAnim'Camera_FX.Flak.C_WP_Flak_Alt_Hit_Shake'
   DeathString="`o � stato fatto a pezzi dalla gragnuola di `k."
   FemaleSuicide="`o si � fatta esplodere con una boccetta."
   MaleSuicide="`o si � fatto esplodere con una boccetta."
   bKRadialImpulse=True
   KDamageImpulse=1000.000000
   VehicleMomentumScaling=3.000000
   Name="Default__UTDmgType_FlakShell"
   ObjectArchetype=UTDmgType_FlakShard'UTGame.Default__UTDmgType_FlakShard'
}
