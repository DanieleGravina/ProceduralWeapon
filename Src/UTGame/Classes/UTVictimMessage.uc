/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVictimMessage extends UTWeaponKillMessage;

var(Message) localized string YouWereKilledBy, KilledByTrailer, OrbSuicideString, RunOverString, SpiderMineString, ScorpionKamikazeString, ViperKamikazeString, TelefragString;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	local string VictimString;
	local class<UTDamageType> VictimDamageType;
	
	if (RelatedPRI_1 == None)
	{
		if ( class<UTDmgType_OrbReturn>(OptionalObject) != None )
			return default.OrbSuicideString;
		return "";
	}

	if (RelatedPRI_1.GetPlayerAlias() != "")
	{
		VictimString = Default.YouWereKilledBy@RelatedPRI_1.GetPlayerAlias()$Default.KilledByTrailer;
		VictimDamageType = Class<UTDamageType>(OptionalObject);
		if ( VictimDamageType != None )
		{
			if ( VictimDamageType.default.DamageWeaponClass != None )
			{
				VictimString = VictimString$" ("$VictimDamageType.default.DamageWeaponClass.default.Itemname$")";
			}
			else if ( (class<UTDmgType_RanOver>(VictimDamageType) != None)
						|| (VictimDamageType.default.KillStatsName == 'KILLS_SCORPIONBLADE') )
			{
				VictimString = VictimString@default.RunOverString;
			}
			else if ( VictimDamageType.default.KillStatsName == 'KILLS_SPIDERMINE' )
			{
				VictimString = VictimString@default.SpiderMineString;
			}
			else if ( VictimDamageType.default.KillStatsName == 'KILLS_SCORPIONSELFDESTRUCT' )
			{
				VictimString = VictimString@default.ScorpionKamikazeString;
			}
			else if ( VictimDamageType.default.KillStatsName == 'KILLS_VIPERSELFDESTRUCT' )
			{
				VictimString = VictimString@default.ViperKamikazeString;
			}
			else if ( VictimDamageType.default.KillStatsName == 'KILLS_TRANSLOCATOR' )
			{
				VictimString = VictimString@default.TelefragString;
			}
		}
		return VictimString;
	}
	else
	{
		return "";
	}
}

defaultproperties
{
   YouWereKilledBy="Sei stato ucciso da"
   KilledByTrailer="!"
   OrbSuicideString="Hai deciso di essere un eroe."
   RunOverString="(Colpisci e fuggi)"
   SpiderMineString="(Mine robot)"
   ScorpionKamikazeString="(Autodistruzione Scorpion)"
   ViperKamikazeString="(Autodistruzione Viper)"
   TelefragString="(Fragmentato)"
   bIsUnique=True
   Lifetime=6.000000
   DrawColor=(B=0,G=0,R=255,A=255)
   FontSize=2
   Name="Default__UTVictimMessage"
   ObjectArchetype=UTWeaponKillMessage'UTGame.Default__UTWeaponKillMessage'
}
