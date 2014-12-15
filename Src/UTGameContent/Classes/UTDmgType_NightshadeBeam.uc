/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_NightshadeBeam extends UTDamageType
	abstract;

var ParticleSystem PS_AttachToGib;

var name BoneToAttach;
var ParticleSystem PS_AttachToBody;

static function DoCustomDamageEffects(UTPawn ThePawn, class<UTDamageType> TheDamageType, const out TraceHitInfo HitInfo, vector HitLocation)
{
	// call this so we don't have code duplication
	class'UTDmgType_LinkBeam'.static.DoCustomDamageEffects( ThePawn, TheDamageType, HitInfo, HitLocation );
}


/** allows special effects when gibs are spawned via DoCustomDamageEffects() instead of the normal way */
simulated static function SpawnExtraGibEffects(UTGib TheGib)
{
	if ( (TheGib.WorldInfo.GetDetailMode() != DM_Low) && !TheGib.WorldInfo.bDropDetail && FRand() < 0.70f )
	{
		TheGib.PSC_GibEffect = new(TheGib) class'UTParticleSystemComponent';
		TheGib.PSC_GibEffect.SetTemplate(default.PS_AttachToGib);
		TheGib.AttachComponent(TheGib.PSC_GibEffect);
	}
}

defaultproperties
{
   PS_AttachToGib=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Death_Gib_Effect'
   BoneToAttach="b_Spine1"
   PS_AttachToBody=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Skeleton_Dissolve'
   DamageBodyMatColor=(R=50.000000,G=50.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.500000
   DeathOverlayTime=1.000000
   bLeaveBodyEffect=True
   bUseDamageBasedDeathEffects=True
   DamageWeaponClass=Class'UTGame.UTVWeap_NightshadeGun'
   DamageWeaponFireMode=1
   DamageCameraAnim=CameraAnim'Camera_FX.LinkGun.C_WP_Link_Beam_Hit'
   KillStatsName="KILLS_NIGHTSHADEGUN"
   DeathStatsName="DEATHS_NIGHTSHADEGUN"
   SuicideStatsName="SUICIDES_NIGHTSHADEGUN"
   DeathString="`o è stato sfregiato dal raggio Nightshade di `k."
   FemaleSuicide="`o si è trafitta."
   MaleSuicide="`o si è trafitto."
   bCausesBlood=False
   KDamageImpulse=100.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=0.100000
   Name="Default__UTDmgType_NightshadeBeam"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
