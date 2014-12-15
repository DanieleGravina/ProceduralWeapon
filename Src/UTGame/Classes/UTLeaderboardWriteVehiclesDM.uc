/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** The class that writes the DM stats */

class UTLeaderboardWriteVehiclesDM extends UTLeaderboardWriteBase;











































































































































































































































































































































































































































































































































































































































































































































































































































































#linenumber 10

//Copies all relevant PRI game stats into the Properties struct of the OnlineStatsWrite
//There can be many more stats in the PRI than what is in the Properties table (on Xbox for example)
//If the Properties table does not contain the entry, the data is not written
function CopyAllStats(UTPlayerReplicationInfo PRI)
{
	local IntStat tempIntStat;
	local TimeStat tempTimeStat;

	//Kill stats (collision/runover)
	foreach PRI.KillStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Death stats (collision/runover)
	foreach PRI.DeathStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Number of vehicles destroyed
	foreach PRI.VehicleKillStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Time driving in a vehicle
	foreach PRI.DrivingStats(tempTimeStat)
	{
		SetIntStatFromMapping(tempTimeStat.StatName, int(tempTimeStat.TotalTime));
	}

	Super.CopyAllStats(PRI);
}

defaultproperties
{
   PureViewIds(0)=6
   StatNameToStatIdMapping(0)=(StatName="DRIVING_UTVEHICLE_CICADA_CONTENT",Id=268435590)
   StatNameToStatIdMapping(1)=(StatName="DRIVING_UTVEHICLE_DARKWALKER_CONTENT",Id=268435591)
   StatNameToStatIdMapping(2)=(StatName="DRIVING_UTVEHICLE_FURY_CONTENT",Id=268435592)
   StatNameToStatIdMapping(3)=(StatName="DRIVING_UTVEHICLE_GOLIATH_CONTENT",Id=268435593)
   StatNameToStatIdMapping(4)=(StatName="DRIVING_UTVEHICLE_HELLBENDER_CONTENT",Id=268435594)
   StatNameToStatIdMapping(5)=(StatName="DRIVING_UTVEHICLE_HOVERBOARD",Id=268435595)
   StatNameToStatIdMapping(6)=(StatName="DRIVING_UTVEHICLE_LEVIATHAN_CONTENT",Id=268435596)
   StatNameToStatIdMapping(7)=(StatName="DRIVING_UTVEHICLE_MANTA_CONTENT",Id=268435597)
   StatNameToStatIdMapping(8)=(StatName="DRIVING_UTVEHICLE_NEMESIS",Id=268435598)
   StatNameToStatIdMapping(9)=(StatName="DRIVING_UTVEHICLE_NIGHTSHADE_CONTENT",Id=268435599)
   StatNameToStatIdMapping(10)=(StatName="DRIVING_UTVEHICLE_PALADIN",Id=268435600)
   StatNameToStatIdMapping(11)=(StatName="DRIVING_UTVEHICLE_RAPTOR_CONTENT",Id=268435601)
   StatNameToStatIdMapping(12)=(StatName="DRIVING_UTVEHICLE_SCAVENGER_CONTENT",Id=268435602)
   StatNameToStatIdMapping(13)=(StatName="DRIVING_UTVEHICLE_SCORPION_CONTENT",Id=268435603)
   StatNameToStatIdMapping(14)=(StatName="DRIVING_UTVEHICLE_SPMA_CONTENT",Id=268435604)
   StatNameToStatIdMapping(15)=(StatName="DRIVING_UTVEHICLE_STEALTHBENDER_CONTENT",Id=268435605)
   StatNameToStatIdMapping(16)=(StatName="DRIVING_UTVEHICLE_TURRET",Id=268435607)
   StatNameToStatIdMapping(17)=(StatName="DRIVING_UTVEHICLE_VIPER_CONTENT",Id=268435606)
   StatNameToStatIdMapping(18)=(StatName="VEHICLEKILL_UTVEHICLE_CICADA_CONTENT",Id=268435668)
   StatNameToStatIdMapping(19)=(StatName="VEHICLEKILL_UTVEHICLE_DARKWALKER_CONTENT",Id=268435669)
   StatNameToStatIdMapping(20)=(StatName="VEHICLEKILL_UTVEHICLE_FURY_CONTENT",Id=268435670)
   StatNameToStatIdMapping(21)=(StatName="VEHICLEKILL_UTVEHICLE_GOLIATH_CONTENT",Id=268435671)
   StatNameToStatIdMapping(22)=(StatName="VEHICLEKILL_UTVEHICLE_HELLBENDER_CONTENT",Id=268435672)
   StatNameToStatIdMapping(23)=(StatName="VEHICLEKILL_UTVEHICLE_HOVERBOARD",Id=268435673)
   StatNameToStatIdMapping(24)=(StatName="VEHICLEKILL_UTVEHICLE_LEVIATHAN_CONTENT",Id=268435674)
   StatNameToStatIdMapping(25)=(StatName="VEHICLEKILL_UTVEHICLE_MANTA_CONTENT",Id=268435675)
   StatNameToStatIdMapping(26)=(StatName="VEHICLEKILL_UTVEHICLE_NEMESIS",Id=268435676)
   StatNameToStatIdMapping(27)=(StatName="VEHICLEKILL_UTVEHICLE_NIGHTSHADE_CONTENT",Id=268435677)
   StatNameToStatIdMapping(28)=(StatName="VEHICLEKILL_UTVEHICLE_PALADIN",Id=268435678)
   StatNameToStatIdMapping(29)=(StatName="VEHICLEKILL_UTVEHICLE_RAPTOR_CONTENT",Id=268435679)
   StatNameToStatIdMapping(30)=(StatName="VEHICLEKILL_UTVEHICLE_SCAVENGER_CONTENT",Id=268435680)
   StatNameToStatIdMapping(31)=(StatName="VEHICLEKILL_UTVEHICLE_SCORPION_CONTENT",Id=268435681)
   StatNameToStatIdMapping(32)=(StatName="VEHICLEKILL_UTVEHICLE_SPMA_CONTENT",Id=268435682)
   StatNameToStatIdMapping(33)=(StatName="VEHICLEKILL_UTVEHICLE_STEALTHBENDER_CONTENT",Id=268435683)
   StatNameToStatIdMapping(34)=(StatName="VEHICLEKILL_UTVEHICLE_TURRET",Id=268435711)
   StatNameToStatIdMapping(35)=(StatName="VEHICLEKILL_UTVEHICLE_VIPER_CONTENT",Id=268435684)
   Properties(0)=(PropertyId=268435590,Data=(Type=SDT_Int32))
   Properties(1)=(PropertyId=268435591,Data=(Type=SDT_Int32))
   Properties(2)=(PropertyId=268435592,Data=(Type=SDT_Int32))
   Properties(3)=(PropertyId=268435593,Data=(Type=SDT_Int32))
   Properties(4)=(PropertyId=268435594,Data=(Type=SDT_Int32))
   Properties(5)=(PropertyId=268435595,Data=(Type=SDT_Int32))
   Properties(6)=(PropertyId=268435596,Data=(Type=SDT_Int32))
   Properties(7)=(PropertyId=268435597,Data=(Type=SDT_Int32))
   Properties(8)=(PropertyId=268435598,Data=(Type=SDT_Int32))
   Properties(9)=(PropertyId=268435599,Data=(Type=SDT_Int32))
   Properties(10)=(PropertyId=268435600,Data=(Type=SDT_Int32))
   Properties(11)=(PropertyId=268435601,Data=(Type=SDT_Int32))
   Properties(12)=(PropertyId=268435602,Data=(Type=SDT_Int32))
   Properties(13)=(PropertyId=268435603,Data=(Type=SDT_Int32))
   Properties(14)=(PropertyId=268435604,Data=(Type=SDT_Int32))
   Properties(15)=(PropertyId=268435605,Data=(Type=SDT_Int32))
   Properties(16)=(PropertyId=268435607,Data=(Type=SDT_Int32))
   Properties(17)=(PropertyId=268435606,Data=(Type=SDT_Int32))
   Properties(18)=(PropertyId=268435668,Data=(Type=SDT_Int32))
   Properties(19)=(PropertyId=268435669,Data=(Type=SDT_Int32))
   Properties(20)=(PropertyId=268435670,Data=(Type=SDT_Int32))
   Properties(21)=(PropertyId=268435671,Data=(Type=SDT_Int32))
   Properties(22)=(PropertyId=268435672,Data=(Type=SDT_Int32))
   Properties(23)=(PropertyId=268435673,Data=(Type=SDT_Int32))
   Properties(24)=(PropertyId=268435674,Data=(Type=SDT_Int32))
   Properties(25)=(PropertyId=268435675,Data=(Type=SDT_Int32))
   Properties(26)=(PropertyId=268435676,Data=(Type=SDT_Int32))
   Properties(27)=(PropertyId=268435677,Data=(Type=SDT_Int32))
   Properties(28)=(PropertyId=268435678,Data=(Type=SDT_Int32))
   Properties(29)=(PropertyId=268435679,Data=(Type=SDT_Int32))
   Properties(30)=(PropertyId=268435680,Data=(Type=SDT_Int32))
   Properties(31)=(PropertyId=268435681,Data=(Type=SDT_Int32))
   Properties(32)=(PropertyId=268435682,Data=(Type=SDT_Int32))
   Properties(33)=(PropertyId=268435683,Data=(Type=SDT_Int32))
   Properties(34)=(PropertyId=268435711,Data=(Type=SDT_Int32))
   Properties(35)=(PropertyId=268435684,Data=(Type=SDT_Int32))
   ViewIds(0)=4
   ArbitratedViewIds(0)=6
   Name="Default__UTLeaderboardWriteVehiclesDM"
   ObjectArchetype=UTLeaderboardWriteBase'UTGame.Default__UTLeaderboardWriteBase'
}
