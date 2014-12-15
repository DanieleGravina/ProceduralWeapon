/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_Enforcer extends UTWeaponAttachment;

/** second mesh for dual-wielding, constructed by duplicating Mesh if no default */
var SkeletalMeshComponent DualMesh;
var SkeletalMeshComponent DualOverlayMesh;

var ParticleSystemComponent DualMuzzleFlashPSC;
var UTExplosionLight DualMuzzleFlashLight;

/** toggled on each fire effect in the dual wielding case to alternate which gun effects get played on */
var bool bFlashDual;

var ParticleSystem TracerTemplate;

function SetSkin(Material NewMaterial)
{
	local int i;

	Super.SetSkin(NewMaterial);

	if (DualMesh != None)
	{
		for (i = 0; i < Mesh.Materials.length; i++)
		{
			DualMesh.SetMaterial(i, Mesh.GetMaterial(i));
		}
	}
}

simulated function SetDualWielding(bool bNowDual)
{
	local UTPawn P;
	local vector LeftScale;

	P = UTPawn(Instigator);
	if (P != None)
	{
		if (bNowDual)
		{
			if (DualMesh == None && Mesh != None)
			{
				DualMesh = new(self) Mesh.Class(Mesh);

				// reverse the mesh, like we do in 1st person
				LeftScale = DualMesh.Scale3D;
				LeftScale.X *= -1;
				DualMesh.SetScale3D(LeftScale);
			}
			if (DualMesh != None)
			{
				P.Mesh.AttachComponentToSocket(DualMesh, P.WeaponSocket2);

				// Weapon Mesh Shadow
				DualMesh.SetShadowParent(P.Mesh);
				DualMesh.SetLightEnvironment(P.LightEnvironment);

				if (P.ReplicatedBodyMaterial != None)
				{
					SetSkin(P.ReplicatedBodyMaterial);
				}
				if ( MuzzleFlashSocket != 'None' &&
					(MuzzleFlashPSCTemplate != None || MuzzleFlashAltPSCTemplate != None) )
				{
					DualMuzzleFlashPSC = new(self) class'UTParticleSystemComponent';
					DualMuzzleFlashPSC.bAutoActivate = false;
					DualMuzzleFlashPSC.SetOwnerNoSee(true);
					DualMesh.AttachComponentToSocket(DualMuzzleFlashPSC, MuzzleFlashSocket);
				}
				P.SetWeapAnimType(EWAT_DualPistols);

				if (OverlayMesh != None && DualOverlayMesh == None)
				{
					DualOverlayMesh = new(self) OverlayMesh.Class(OverlayMesh);
					DualOverlayMesh.SetParentAnimComponent(DualMesh);
					DualOverlayMesh.SetScale3D(DualMesh.Scale3D);
				}
				if (DualOverlayMesh != None && OverlayMesh.bAttached)
				{
					P.Mesh.AttachComponentToSocket(DualOverlayMesh, P.WeaponSocket2);
				}
			}
		}
		else
		{
			if (DualMesh != None && DualMesh.bAttached)
			{
				P.Mesh.DetachComponent(DualMesh);
				P.SetWeapAnimType(WeapAnimType);
			}
			if (DualOverlayMesh != None && DualOverlayMesh.bAttached)
			{
				P.Mesh.DetachComponent(DualOverlayMesh);
			}
			bFlashDual = false;
		}
	}
}

simulated function CreateOverlayMesh()
{
	Super.CreateOverlayMesh();

	if (DualMesh != None)
	{
		DualOverlayMesh = new(self) OverlayMesh.Class(OverlayMesh);
		DualOverlayMesh.SetParentAnimComponent(DualMesh);
		DualOverlayMesh.SetScale3D(DualMesh.Scale3D);
	}
}

simulated function SetWeaponOverlayFlags(UTPawn OwnerPawn)
{
	local int i;

	Super.SetWeaponOverlayFlags(OwnerPawn);

	if (OverlayMesh != None && DualOverlayMesh != None)
	{
		if (OverlayMesh.bAttached)
		{
			if (!DualOverlayMesh.bAttached)
			{
				OwnerPawn.Mesh.AttachComponentToSocket(DualOverlayMesh, OwnerPawn.WeaponSocket2);
			}

			for (i = 0; i < DualOverlayMesh.GetNumElements(); i++)
			{
				DualOverlayMesh.SetMaterial(i, OverlayMesh.GetMaterial(i));
			}
		}
		else
		{
			OwnerPawn.Mesh.DetachComponent(DualOverlayMesh);
		}
	}
}

simulated function DetachFrom(SkeletalMeshComponent MeshCpnt)
{
	if (MeshCpnt != None)
	{
		if (DualMesh != None && DualMesh.bAttached)
		{
			MeshCpnt.DetachComponent(DualMesh);
		}
		if (DualOverlayMesh != None && DualOverlayMesh.bAttached)
		{
			MeshCpnt.DetachComponent(DualOverlayMesh);
		}
	}
	Super.DetachFrom(MeshCpnt);
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{
	local UTPawn P;

	Super.ThirdPersonFireEffects(HitLocation);

	SpawnTracer(GetEffectLocation(), HitLocation);

	P = UTPawn(Instigator);
	if (P != None && P.bDualWielding)
	{
		// override recoil and play only on hand that's firing
		P.GunRecoilNode.bPlayRecoil = false;
		if (bFlashDual)
		{
			P.LeftRecoilNode.bPlayRecoil = true;
		}
		else
		{
			P.RightRecoilNode.bPlayRecoil = true;
		}

		bFlashDual = !bFlashDual;
	}
}

simulated function MuzzleFlashTimer()
{
	Super.MuzzleFlashTimer();

	if (DualMuzzleFlashLight != None)
	{
		DualMuzzleFlashLight.SetEnabled(false);
	}
	if (DualMuzzleFlashPSC != None && !bMuzzleFlashPSCLoops)
	{
		DualMuzzleFlashPSC.DeactivateSystem();
	}
}

simulated function CauseMuzzleFlash()
{
	if (!bFlashDual)
	{
		Super.CauseMuzzleFlash();
	}
	else
	{
		// only enable muzzleflash light if performance is high enough
		if (!WorldInfo.bDropDetail && !class'Engine'.static.IsSplitScreen() )
		{
			if (DualMuzzleFlashLight == None)
			{
				if (MuzzleFlashLightClass != None)
				{
					DualMuzzleFlashLight = new(self) MuzzleFlashLightClass;
					if (DualMesh != None && DualMesh.GetSocketByName(MuzzleFlashSocket) != None)
					{
						DualMesh.AttachComponentToSocket(DualMuzzleFlashLight, MuzzleFlashSocket);
					}
					else if (OwnerMesh != None)
					{
						OwnerMesh.AttachComponentToSocket(DualMuzzleFlashLight, UTPawn(OwnerMesh.Owner).WeaponSocket2);
					}
				}
			}
			else
			{
				DualMuzzleFlashLight.ResetLight();
			}
		}

		if (DualMuzzleFlashPSC != None)
		{
			if (!bMuzzleFlashPSCLoops || !DualMuzzleFlashPSC.bIsActive)
			{
				if (Instigator != None && Instigator.FiringMode == 1 && MuzzleFlashAltPSCTemplate != None)
				{
					DualMuzzleFlashPSC.SetTemplate(MuzzleFlashAltPSCTemplate);
				}
				else
				{
					DualMuzzleFlashPSC.SetTemplate(MuzzleFlashPSCTemplate);
				}

				SetMuzzleFlashParams(DualMuzzleFlashPSC);
				DualMuzzleFlashPSC.ActivateSystem();
			}
		}

		// Set when to turn it off.
		SetTimer(MuzzleFlashDuration,false,'MuzzleFlashTimer');
	}
}

simulated function StopMuzzleFlash()
{
	Super.StopMuzzleFlash();

	if (DualMuzzleFlashPSC != None)
	{
		DualMuzzleFlashPSC.DeactivateSystem();
	}
}

simulated function SpawnTracer(vector EffectLocation, vector HitLocation)
{
	local ParticleSystemComponent E;
	local vector Dir;

	Dir = HitLocation - EffectLocation;
	if ( VSizeSq(Dir) > 14400.0 )
	{
		E = WorldInfo.MyEmitterPool.SpawnEmitter(TracerTemplate, EffectLocation, rotator(Dir));
		E.SetVectorParameter('LinkBeamEnd', HitLocation);
	}
}

simulated function FirstPersonFireEffects(Weapon PawnWeapon, vector HitLocation)
{
	Super.FirstPersonFireEffects(PawnWeapon, HitLocation);

	SpawnTracer(UTWeapon(PawnWeapon).GetEffectLocation(), HitLocation);
}

simulated function vector GetEffectLocation()
{
	local SkeletalMeshComponent RealMesh;
	local vector Result;

	// swap to the dual mesh if necessary
	RealMesh = Mesh;
	Mesh = (bFlashDual && DualMesh != None) ? DualMesh : Mesh;
	Result = Super.GetEffectLocation();
	Mesh = RealMesh;

	return Result;
}

simulated function ChangeVisibility(bool bIsVisible)
{
	Super.ChangeVisibility(bIsVisible);

	if (DualMesh != None)
	{
		DualMesh.SetHidden(!bIsVisible);
	}
}

defaultproperties
{
   TracerTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcers_Tracer'
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_Enforcers.Mesh.SK_WP_Enforcer_3P_Mid'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_Enforcer:SkeletalMeshComponent0.MeshSequenceA'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcers_3P_MuzzleFlash'
   bMakeSplash=True
   MuzzleFlashLightClass=Class'UTGame.UTEnforcerMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   ImpactEffects(0)=(MaterialType="Dirt",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(1)=(MaterialType="Gravel",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(2)=(MaterialType="Sand",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(3)=(MaterialType="Dirt_Wet",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMud_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(4)=(MaterialType="Energy",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactEnergy_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(5)=(MaterialType="WorldBoundary",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactEnergy_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(6)=(MaterialType="Flesh",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(7)=(MaterialType="Flesh_Human",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(8)=(MaterialType="Kraal",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(9)=(MaterialType="Necris",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(10)=(MaterialType="Robot",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(11)=(MaterialType="Foliage",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFoliage_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(12)=(MaterialType="Glass",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactGlass_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(13)=(MaterialType="Liquid",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(14)=(MaterialType="Water",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'Envy_Effects.Particles.P_WP_Water_Splash_Small')
   ImpactEffects(15)=(MaterialType="ShallowWater",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'Envy_Effects.Particles.P_WP_Water_Splash_Small')
   ImpactEffects(16)=(MaterialType="Lava",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(17)=(MaterialType="Slime",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(18)=(MaterialType="Metal",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(19)=(MaterialType="Snow",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactSnow_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(20)=(MaterialType="Wood",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWood_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   ImpactEffects(21)=(MaterialType="NecrisVehicle",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(0)=(MaterialType="Dirt",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(1)=(MaterialType="Gravel",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(2)=(MaterialType="Sand",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(3)=(MaterialType="Dirt_Wet",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMud_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(4)=(MaterialType="Energy",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactEnergy_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(5)=(MaterialType="WorldBoundary",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactEnergy_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(6)=(MaterialType="Flesh",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(7)=(MaterialType="Flesh_Human",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(8)=(MaterialType="Kraal",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(9)=(MaterialType="Necris",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFlesh_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(10)=(MaterialType="Robot",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(11)=(MaterialType="Foliage",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactFoliage_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(12)=(MaterialType="Glass",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactGlass_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(13)=(MaterialType="Liquid",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(14)=(MaterialType="Water",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'Envy_Effects.Particles.P_WP_Water_Splash_Small')
   AltImpactEffects(15)=(MaterialType="ShallowWater",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'Envy_Effects.Particles.P_WP_Water_Splash_Small')
   AltImpactEffects(16)=(MaterialType="Lava",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(17)=(MaterialType="Slime",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWater_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(18)=(MaterialType="Metal",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(19)=(MaterialType="Snow",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactSnow_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(20)=(MaterialType="Wood",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactWood_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   AltImpactEffects(21)=(MaterialType="NecrisVehicle",Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactMetal_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_BulletImpacts.Cue.A_Weapon_Impact_Stone_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   DefaultAltImpactEffect=(Sound=SoundCue'A_Weapon_BulletImpacts.Cue.A_Weapon_Impact_Stone_Cue',DecalMaterials=(MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal01',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal02',MaterialInstanceConstant'WP_Enforcers.Decals.MI_WP_Enforcer_Impact_Decal03'),DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'WP_Enforcers.Effects.P_WP_Enforcer_Impact')
   BulletWhip=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_AmmoWhip_Cue'
   WeaponClass=Class'UTGame.UTWeap_Enforcer'
   WeapAnimType=EWAT_Pistol
   Name="Default__UTAttachment_Enforcer"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
