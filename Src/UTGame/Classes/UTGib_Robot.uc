/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_Robot extends UTGib
	abstract;


var name CustomGibSocketName;

simulated function DoCustomGibEffects()
{
	local SkeletalMeshComponent SMC;
	local SkeletalMeshSocket SMS;

	SMC = SkeletalMeshComponent(GibMeshComp);

	if( SMC != none )
	{
		SMS = SMC.GetSocketByName( CustomGibSocketName );

		// so we know the spark exists in this MeshComponent
		if( SMS != none )
		{
			PSC_GibEffect = new(self) class'UTParticleSystemComponent';
			PSC_GibEffect.SetTemplate( PS_CustomEffect );
			SMC.AttachComponentToSocket( PSC_GibEffect, CustomGibSocketName );
		}
	}
}

defaultproperties
{
   CustomGibSocketName="Spark"
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_GibMedium_Cue'
   MITV_GibMeshTemplate=MaterialInstanceTimeVarying'CH_Gibs.Materials.MITV_CH_Gibs_Corrupt01'
   PS_CustomEffect=ParticleSystem'Envy_Effects2.Particles.P_Robot_Gib_Spark'
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_Robot"
   ObjectArchetype=UTGib'UTGame.Default__UTGib'
}
