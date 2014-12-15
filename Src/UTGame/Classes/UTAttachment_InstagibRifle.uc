/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_InstagibRifle extends UTWeaponAttachment;

var ParticleSystem BeamTemplate;
var array<MaterialImpactEffect> TeamImpactEffects;
var array<MaterialInterface> TeamSkins;
var array<ParticleSystem> TeamMuzzleFlashes;
var array<ParticleSystem> TeamBeams;

simulated function SpawnBeam(vector Start, vector End, bool bFirstPerson)
{
	local ParticleSystemComponent E;
	local actor HitActor;
	local vector HitNormal, HitLocation;

	if ( End == Vect(0,0,0) )
	{
		if ( !bFirstPerson || (Instigator.Controller == None) )
		{
	    	return;
		}
		// guess using current viewrotation;
		End = Start + vector(Instigator.Controller.Rotation) * class'UTWeap_ShockRifle'.default.WeaponRange;
		HitActor = Instigator.Trace(HitLocation, HitNormal, End, Start, TRUE, vect(0,0,0),, TRACEFLAG_Bullet);
		if ( HitActor != None )
		{
			End = HitLocation;
		}
	}

	E = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, Start);
	E.SetVectorParameter('ShockBeamEnd', End);
	if (bFirstPerson && !class'Engine'.static.IsSplitScreen())
	{
		E.SetDepthPriorityGroup(SDPG_Foreground);
	}
	else
	{
		E.SetDepthPriorityGroup(SDPG_World);
	}
}

simulated function FirstPersonFireEffects(Weapon PawnWeapon, vector HitLocation)	// Should be subclassed
{
	SetTeamEffects();

	Super.FirstPersonFireEffects(PawnWeapon , HitLocation);
	SpawnBeam(UTWeapon(PawnWeapon).GetEffectLocation(), HitLocation, true);
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	SetTeamEffects();

	Super.ThirdPersonFireEffects(HitLocation);

	SpawnBeam(GetEffectLocation(), HitLocation, false);
}

simulated function SetSkin(Material NewMaterial)
{
	local int TeamIndex;

	if ( NewMaterial == None ) 	// Clear the materials
	{
		TeamIndex = Instigator.GetTeamNum();
		if (TeamIndex >= TeamSkins.length)
		{
			TeamIndex = 0;
		}
		Mesh.SetMaterial(0, TeamSkins[TeamIndex]);
	}
	else
	{
		Super.SetSkin(NewMaterial);
	}
}

simulated function SetTeamEffects()
{
	local int Team;

	Team = Instigator.GetTeamNum();
	if (Team >= TeamBeams.length)
	{
		Team = 0;
	}

	DefaultImpactEffect = TeamImpactEffects[Team];
	DefaultAltImpactEffect = DefaultImpactEffect;
	MuzzleFlashAltPSCTemplate = TeamMuzzleFlashes[Team];
	MuzzleFlashPSCTemplate = MuzzleFlashAltPSCTemplate;
	BeamTemplate = TeamBeams[Team];
}

simulated function SetImpactedActor(Actor HitActor, vector HitLocation, vector HitNormal)
{
	// spawn impact effect even for UTPawns
	if (DefaultImpactEffect.ParticleTemplate != None && (HitActor == None || UTPawn(HitActor) != None) && EffectIsRelevant(HitLocation, false, MaxImpactEffectDistance))
	{
		WorldInfo.MyEmitterPool.SpawnEmitter(DefaultImpactEffect.ParticleTemplate, HitLocation, rotator(HitNormal));
	}
}

defaultproperties
{
   TeamImpactEffects(0)=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_InstagibImpactCue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_Impact_Red')
   TeamImpactEffects(1)=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_InstagibImpactCue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_Impact_Blue')
   TeamSkins(0)=Material'WP_ShockRifle.Materials.M_WP_ShockRifle_Instagib_Red'
   TeamSkins(1)=Material'WP_ShockRifle.Materials.M_WP_ShockRifle_Instagib_Blue'
   TeamMuzzleFlashes(0)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_3P_MF_Red'
   TeamMuzzleFlashes(1)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_3P_MF_Blue'
   TeamBeams(0)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_Beam_Red'
   TeamBeams(1)=ParticleSystem'WP_ShockRifle.Particles.P_Shockrifle_Instagib_Beam_Blue'
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_InstagibRifle:SkeletalMeshComponent0.MeshSequenceA'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashColor=(B=255,G=120,R=255,A=255)
   MuzzleFlashLightClass=Class'UTGame.UTShockMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   BulletWhip=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_WhipCue'
   WeaponClass=Class'UTGame.UTWeap_InstagibRifle'
   Name="Default__UTAttachment_InstagibRifle"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
