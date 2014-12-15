/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_LeviathanTurretBeam extends UTVWeap_LeviathanTurretBase
		HideDropDown;

defaultproperties
{
   FireTriggerTags(0)="TurretBeamMF_L"
   FireTriggerTags(1)="TurretBeamMF_R"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_PrimeAltImpact')
   BulletWhip=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_WhipCue'
   VehicleClass=Class'UTGameContent.UTVehicle_Leviathan_Content'
   WeaponFireSnd(0)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_FireCue'
   FireInterval(0)=0.300000
   InstantHitDamage(0)=35.000000
   InstantHitMomentum(0)=60000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_LeviathanBeam'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta Laser"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_LeviathanTurretBeam"
   ObjectArchetype=UTVWeap_LeviathanTurretBase'UTGame.Default__UTVWeap_LeviathanTurretBase'
}
