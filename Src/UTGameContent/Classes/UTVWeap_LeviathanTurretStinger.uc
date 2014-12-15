/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_LeviathanTurretStinger extends UTVWeap_LeviathanTurretBase
		HideDropDown;

defaultproperties
{
   FireTriggerTags(0)="TurretStingerMF"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_PrimeAltImpact')
   VehicleClass=Class'UTGameContent.UTVehicle_Leviathan_Content'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_FireAltCue'
   FireInterval(0)=0.100000
   Spread(0)=0.067500
   InstantHitDamage(0)=40.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_LeviathanShard'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta Stinger"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_LeviathanTurretStinger"
   ObjectArchetype=UTVWeap_LeviathanTurretBase'UTGame.Default__UTVWeap_LeviathanTurretBase'
}
