/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_BioGoo extends UTDamageType
	abstract;

static function DoCustomDamageEffects(UTPawn ThePawn, class<UTDamageType> TheDamageType, const out TraceHitInfo HitInfo, vector HitLocation)
{
	local int i, Num;
	local MaterialInstanceConstant OldMIC, NewMIC;
	local int ValueIndex;
	local bool bFoundDiffuse;
	local Texture DiffuseTexture;

	//Char_Diffuse
	if (ThePawn.CurrFamilyInfo != None && ThePawn.CurrFamilyInfo.default.BioDeathMICParent != None)
	{
		Num = ThePawn.Mesh.GetNumElements();
		for (i = 0; i < Num; i++)
		{
			OldMIC = MaterialInstanceConstant(ThePawn.Mesh.GetMaterial(i));
			if (OldMIC != None)
			{
				// look up the chain until we find an MIC with the texture parameters that we need
				bFoundDiffuse = FALSE;
				//bFoundDiffuse = OldMic.GetTextureParameterValue( 'Char_Diffuse', DiffuseTexture );
				for( ValueIndex = 0;ValueIndex < OldMic.TextureParameterValues.Length;ValueIndex++)
				{
					if( OldMic.TextureParameterValues[ValueIndex].ParameterName == 'Char_Diffuse' )
					{
						OldMic.GetTextureParameterValue( 'Char_Diffuse', DiffuseTexture );
						bFoundDiffuse = TRUE;
						break;
					}
				}

				while( bFoundDiffuse != TRUE )
				{
					OldMic = MaterialInstanceConstant(OldMic.Parent);
					for( ValueIndex = 0;ValueIndex < OldMic.TextureParameterValues.Length;ValueIndex++)
					{
						if( OldMic.TextureParameterValues[ValueIndex].ParameterName == 'Char_Diffuse' )
						{
							OldMic.GetTextureParameterValue( 'Char_Diffuse', DiffuseTexture );
							bFoundDiffuse = TRUE;
							break;
						}
					}
				}

				OldMIC = MaterialInstanceConstant(ThePawn.Mesh.GetMaterial(i));
				OldMIC.SetTextureParameterValue( 'Char_Diffuse', DiffuseTexture );

				// duplicate the material (copying its parameter values)
				// then set the parent to the bio material
				NewMIC = new(ThePawn) OldMIC.Class(OldMic);
				NewMIC.SetParent(ThePawn.CurrFamilyInfo.default.BioDeathMICParent);
				ThePawn.Mesh.SetMaterial(i, NewMIC);
			}
		}

		ThePawn.Mesh.AttachComponent(ThePawn.BioBurnAway, ThePawn.TorsoBoneName);
		ThePawn.BioBurnAway.ActivateSystem();
		ThePawn.bKilledByBio = TRUE;
		ThePawn.bGibbed=TRUE; // this makes it so you can't then switch to a "gibbing" weapon and get chunks
		ThePawn.UpdateShadowSettings( FALSE );
	}
}

defaultproperties
{
   DamageBodyMatColor=(R=0.000000,G=50.000000,B=0.000000,A=1.000000)
   DamageOverlayTime=0.200000
   DeathOverlayTime=0.400000
   bUseDamageBasedDeathEffects=True
   bAnimateHipsForDeathAnim=False
   DamageWeaponClass=Class'UTGameContent.UTWeap_BioRifle_Content'
   DeathAnim="Death_Stinger"
   MotorDecayTime=1.000000
   DamageCameraAnim=CameraAnim'Camera_FX.BioRifle.C_WP_Bio_Hit'
   KillStatsName="KILLS_BIORIFLE"
   DeathStatsName="DEATHS_BIORIFLE"
   SuicideStatsName="SUICIDES_BIORIFLE"
   RewardCount=15
   RewardAnnouncementSwitch=4
   RewardEvent="REWARD_BIOHAZARD"
   CustomTauntIndex=1
   DeathString="`o è stato inglobato dal Fluido Bio di `k."
   FemaleSuicide="`o è soffocata nel suo stesso Fluido."
   MaleSuicide="`o è soffocato nel suo stesso Fluido."
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=0.200000
   Name="Default__UTDmgType_BioGoo"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
