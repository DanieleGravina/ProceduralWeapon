/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_SniperRifle extends UTWeaponAttachment;

var ParticleSystem TracerTemplate;
var array<MaterialInterface> TeamSkins;

simulated function SpawnTracer(vector EffectLocation, vector HitLocation)
{
	local ParticleSystemComponent E;
	local vector Dir;

	Dir = HitLocation - EffectLocation;
	if ( VSizeSq(Dir) > 14400.0 )
	{
		E = WorldInfo.MyEmitterPool.SpawnEmitter(TracerTemplate, EffectLocation, rotator(Dir));
		E.SetVectorParameter('Sniper_Endpoint', HitLocation);
	}
}

simulated function FirstPersonFireEffects(Weapon PawnWeapon, vector HitLocation)
{
	Super.FirstPersonFireEffects(PawnWeapon, HitLocation);

	SpawnTracer(UTWeapon(PawnWeapon).GetEffectLocation(), HitLocation);
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	Super.ThirdPersonFireEffects(HitLocation);

	SpawnTracer(GetEffectLocation(), HitLocation);
}

simulated function SetSkin(Material NewMaterial)
{
	local int TeamIndex;

	if ( NewMaterial == None ) 	// Clear the materials
	{
		TeamIndex = Instigator.GetTeamNum();
		if ( TeamIndex == 255 )
			TeamIndex = 0;
		Mesh.SetMaterial(0,TeamSkins[TeamIndex]);
	}
	else
	{
		Super.SetSkin(NewMaterial);
	}
}

defaultproperties
{
   TracerTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Beam'
   TeamSkins(0)=Material'WP_SniperRifle.Materials.M_WP_SniperRifle'
   TeamSkins(1)=MaterialInstanceConstant'WP_SniperRifle.Materials.M_WP_SniperRifle_Blue'
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_SniperRifle.Mesh.SK_WP_SniperRifle_3P_Mid'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_SniperRifle:SkeletalMeshComponent0.MeshSequenceA'
      CullDistance=5000.000000
      CachedCullDistance=5000.000000
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_3P_MuzzleFlash'
   bMakeSplash=True
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   ImpactEffects(0)=(MaterialType="Dirt",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactDirt_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(1)=(MaterialType="Gravel",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactDirt_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(2)=(MaterialType="Sand",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactDirt_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(3)=(MaterialType="Dirt_Wet",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactMud_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(4)=(MaterialType="Energy",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactEnergy_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(5)=(MaterialType="WorldBoundary",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactEnergy_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(6)=(MaterialType="Flesh",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactFlesh_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(7)=(MaterialType="Flesh_Human",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactFlesh_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(8)=(MaterialType="Kraal",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactFlesh_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(9)=(MaterialType="Necris",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactFlesh_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(10)=(MaterialType="Robot",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactMetal_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(11)=(MaterialType="Foliage",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactFoliage_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(12)=(MaterialType="Glass",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactGlass_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(13)=(MaterialType="Liquid",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWater_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(14)=(MaterialType="Water",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWater_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(15)=(MaterialType="ShallowWater",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWater_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(16)=(MaterialType="Lava",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWater_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(17)=(MaterialType="Slime",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWater_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(18)=(MaterialType="Metal",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactMetal_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(19)=(MaterialType="Snow",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactSnow_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(20)=(MaterialType="Wood",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactWood_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   ImpactEffects(21)=(MaterialType="NecrisVehicle",Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactMetal_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_Sniper.Sniper.A_Weapon_Sniper_ImpactDirt_Cue',DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_SniperRifle.Effects.P_WP_SniperRifle_Surface_Impact')
   BulletWhip=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_AmmoWhip_Cue'
   WeaponClass=Class'UTGame.UTWeap_SniperRifle'
   Name="Default__UTAttachment_SniperRifle"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
