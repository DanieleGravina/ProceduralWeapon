/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_BioGoo_Charged extends UTDmgType_BioGoo
	abstract;

defaultproperties
{
   GibPerterbation=0.750000
   AlwaysGibDamageThreshold=99
   DamageWeaponFireMode=1
   DamageCameraAnim=CameraAnim'Camera_FX.BioRifle.C_WP_Bio_Alt_Hit'
   CustomTauntIndex=11
   Name="Default__UTDmgType_BioGoo_Charged"
   ObjectArchetype=UTDmgType_BioGoo'UTGameContent.Default__UTDmgType_BioGoo'
}
