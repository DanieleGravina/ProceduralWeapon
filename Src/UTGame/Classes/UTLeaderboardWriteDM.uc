/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** The class that writes the DM general stats */

class UTLeaderboardWriteDM extends UTLeaderboardWriteBase;











































































































































































































































































































































































































































































































































































































































































































































































































































































#linenumber 10

/** Grouping of stats for the category MULTIKILL */
var array<name> MultiKill;

/** Grouping of stats for the category SPREE */
var array<name> Spree;

/** Class that holds the stats mapping/info for weapons */
var class<UTLeaderboardWriteBase> WeaponsStatsClass;

/** Class that holds the stats mapping/info for vehicles */
var class<UTLeaderboardWriteBase> VehicleStatsClass;

/** Class that holds the stats mapping/info for vehicle weapons */
var class<UTLeaderboardWriteBase> VehicleWeaponsStatsClass;

//Copies all relevant PRI game stats into the Properties struct of the OnlineStatsWrite
//There can be many more stats in the PRI than what is in the Properties table (on Xbox for example)
//If the Properties table does not contain the entry, the data is not written
function CopyAllStats(UTPlayerReplicationInfo PRI)
{
	local IntStat tempIntStat;
	local TimeStat tempTimeStat;
	local int Score;

	SetIntStat(0x10000005 ,PRI.Kills);
	// Make sure to create a non-zero rating value
	Score = PRI.Score;
	if (Score == 0)
	{
		Score = -1;
	}
	SetIntStat(PROPERTY_LEADERBOARDRATING,Score);
	SetIntStat(0x10000006 ,PRI.Deaths);

	//Kill stats
	foreach PRI.KillStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Death stats
	foreach PRI.DeathStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Suicide stats
	foreach PRI.SuicideStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Event Stats such as Multikill, Spree, Reward
	foreach PRI.EventStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Number of node events accomplished (capture/destroy/etc)
	foreach PRI.NodeStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Number of things picked up
	foreach PRI.PickupStats(tempIntStat)
	{
		SetIntStatFromMapping(tempIntStat.StatName, tempIntStat.StatValue);
	}

	//Time under a powerup
	foreach PRI.PowerupTimeStats(tempTimeStat)
	{
		SetIntStatFromMapping(tempTimeStat.StatName, int(tempTimeStat.TotalTime));
	}

	Super.CopyAllStats(PRI);
}

//Calls CopyAllStats() on relevant stat tables and then writes the data out to the online interface
function CopyAndWriteAllStats(UniqueNetId UniqId, UTPlayerReplicationInfo PRI, bool bIsPureServer, OnlineStatsInterface StatsInterface)
{
	local UTLeaderboardWriteWeaponsDM WeaponStats;
	local UTLeaderboardWriteVehiclesDM VehicleStats;
	local UTLeaderboardWriteVehicleWeaponsDM VehicleWeaponsStats;
	if (StatsInterface != None)
	{
		//Copy all stats out of the PRI
		//and copy them into the online subsystem where they will be
		//sent via the network in EndOnlineGame()

		self.SetPureServerMode(bIsPureServer);
		self.CopyAllStats(PRI);
		StatsInterface.WriteOnlineStats(UniqId, self);

		if (WeaponsStatsClass != none)
		{
			WeaponStats = UTLeaderboardWriteWeaponsDM(new WeaponsStatsClass);
			WeaponStats.SetPureServerMode(bIsPureServer);
			WeaponStats.CopyAllStats(PRI);
			StatsInterface.WriteOnlineStats(UniqId, WeaponStats);
		}

		if (VehicleStatsClass != none)
		{
			VehicleStats = UTLeaderboardWriteVehiclesDM(new VehicleStatsClass);
			VehicleStats.SetPureServerMode(bIsPureServer);
			VehicleStats.CopyAllStats(PRI);
			StatsInterface.WriteOnlineStats(UniqId, VehicleStats);
		}

		if (VehicleWeaponsStatsClass != none)
		{
			VehicleWeaponsStats = UTLeaderboardWriteVehicleWeaponsDM(new VehicleWeaponsStatsClass);
			VehicleWeaponsStats.SetPureServerMode(bIsPureServer);
			VehicleWeaponsStats.CopyAllStats(PRI);
			StatsInterface.WriteOnlineStats(UniqId, VehicleWeaponsStats);
		}
	}
}

defaultproperties
{
   MultiKill(0)="MULTIKILL_DOUBLEKILL"
   MultiKill(1)="MULTIKILL_MULTIKILL"
   MultiKill(2)="MULTIKILL_MEGAKILL"
   MultiKill(3)="MULTIKILL_ULTRAKILL"
   MultiKill(4)="MULTIKILL_MONSTERKILL"
   spree(0)="SPREE_KILLINGSPREE"
   spree(1)="SPREE_RAMPAGE"
   spree(2)="SPREE_DOMINATING"
   spree(3)="SPREE_UNSTOPPABLE"
   spree(4)="SPREE_GODLIKE"
   spree(5)="SPREE_MASSACRE"
   WeaponsStatsClass=Class'UTGame.UTLeaderboardWriteWeaponsDM'
   VehicleStatsClass=Class'UTGame.UTLeaderboardWriteVehiclesDM'
   VehicleWeaponsStatsClass=Class'UTGame.UTLeaderboardWriteVehicleWeaponsDM'
   StatNameToStatIdMapping(0)=(StatName="EVENT_KILLS",Id=268435461)
   StatNameToStatIdMapping(1)=(StatName="EVENT_DEATHS",Id=268435462)
   StatNameToStatIdMapping(2)=(StatName="EVENT_BULLSEYE",Id=268435778)
   StatNameToStatIdMapping(3)=(StatName="EVENT_DENIEDREDEEMER",Id=268435549)
   StatNameToStatIdMapping(4)=(StatName="EVENT_EAGLEEYE",Id=268435550)
   StatNameToStatIdMapping(5)=(StatName="EVENT_ENDSPREE",Id=268435551)
   StatNameToStatIdMapping(6)=(StatName="EVENT_FIRSTBLOOD",Id=268435552)
   StatNameToStatIdMapping(7)=(StatName="EVENT_HIJACKED",Id=268435779)
   StatNameToStatIdMapping(8)=(StatName="EVENT_RANOVERDEATHS",Id=268435729)
   StatNameToStatIdMapping(9)=(StatName="EVENT_RANOVERKILLS",Id=268435734)
   StatNameToStatIdMapping(10)=(StatName="EVENT_TOPGUN",Id=268435561)
   StatNameToStatIdMapping(11)=(StatName="MULTIKILL_DOUBLEKILL",Id=268435562)
   StatNameToStatIdMapping(12)=(StatName="MULTIKILL_MEGAKILL",Id=268435563)
   StatNameToStatIdMapping(13)=(StatName="MULTIKILL_MONSTERKILL",Id=268435564)
   StatNameToStatIdMapping(14)=(StatName="MULTIKILL_MULTIKILL",Id=268435565)
   StatNameToStatIdMapping(15)=(StatName="MULTIKILL_ULTRAKILL",Id=268435566)
   StatNameToStatIdMapping(16)=(StatName="PICKUPS_ARMOR",Id=268435707)
   StatNameToStatIdMapping(17)=(StatName="PICKUPS_BERSERK",Id=268435719)
   StatNameToStatIdMapping(18)=(StatName="PICKUPS_HEALTH",Id=268435708)
   StatNameToStatIdMapping(19)=(StatName="PICKUPS_INVISIBILITY",Id=268435720)
   StatNameToStatIdMapping(20)=(StatName="PICKUPS_INVULNERABILITY",Id=268435721)
   StatNameToStatIdMapping(21)=(StatName="PICKUPS_JUMPBOOTS",Id=268435722)
   StatNameToStatIdMapping(22)=(StatName="PICKUPS_SHIELDBELT",Id=268435782)
   StatNameToStatIdMapping(23)=(StatName="PICKUPS_UDAMAGE",Id=268435723)
   StatNameToStatIdMapping(24)=(StatName="POWERUPTIME_BERSERK",Id=268435727)
   StatNameToStatIdMapping(25)=(StatName="POWERUPTIME_INVISIBILITY",Id=268435724)
   StatNameToStatIdMapping(26)=(StatName="POWERUPTIME_INVULNERABILITY",Id=268435728)
   StatNameToStatIdMapping(27)=(StatName="POWERUPTIME_UDAMAGE",Id=268435726)
   StatNameToStatIdMapping(28)=(StatName="REWARD_BIGGAMEHUNTER",Id=268435573)
   StatNameToStatIdMapping(29)=(StatName="REWARD_BIOHAZARD",Id=268435574)
   StatNameToStatIdMapping(30)=(StatName="REWARD_BLUESTREAK",Id=268435575)
   StatNameToStatIdMapping(31)=(StatName="REWARD_COMBOKING",Id=268435576)
   StatNameToStatIdMapping(32)=(StatName="REWARD_FLAKMASTER",Id=268435577)
   StatNameToStatIdMapping(33)=(StatName="REWARD_GUNSLINGER",Id=268435578)
   StatNameToStatIdMapping(34)=(StatName="REWARD_HEADHUNTER",Id=268435579)
   StatNameToStatIdMapping(35)=(StatName="REWARD_JACKHAMMER",Id=268435580)
   StatNameToStatIdMapping(36)=(StatName="REWARD_ROADRAMPAGE",Id=268435581)
   StatNameToStatIdMapping(37)=(StatName="REWARD_ROCKETSCIENTIST",Id=268435582)
   StatNameToStatIdMapping(38)=(StatName="REWARD_SHAFTMASTER",Id=268435583)
   StatNameToStatIdMapping(39)=(StatName="SPREE_DOMINATING",Id=268435584)
   StatNameToStatIdMapping(40)=(StatName="SPREE_GODLIKE",Id=268435585)
   StatNameToStatIdMapping(41)=(StatName="SPREE_KILLINGSPREE",Id=268435586)
   StatNameToStatIdMapping(42)=(StatName="SPREE_MASSACRE",Id=268435588)
   StatNameToStatIdMapping(43)=(StatName="SPREE_RAMPAGE",Id=268435587)
   StatNameToStatIdMapping(44)=(StatName="SPREE_UNSTOPPABLE",Id=268435589)
   Properties(0)=(PropertyId=268435462,Data=(Type=SDT_Int32))
   Properties(1)=(PropertyId=268435461,Data=(Type=SDT_Int32))
   Properties(2)=(PropertyId=268435778,Data=(Type=SDT_Int32))
   Properties(3)=(PropertyId=268435549,Data=(Type=SDT_Int32))
   Properties(4)=(PropertyId=268435550,Data=(Type=SDT_Int32))
   Properties(5)=(PropertyId=268435551,Data=(Type=SDT_Int32))
   Properties(6)=(PropertyId=268435552,Data=(Type=SDT_Int32))
   Properties(7)=(PropertyId=268435779,Data=(Type=SDT_Int32))
   Properties(8)=(PropertyId=268435729,Data=(Type=SDT_Int32))
   Properties(9)=(PropertyId=268435734,Data=(Type=SDT_Int32))
   Properties(10)=(PropertyId=268435561,Data=(Type=SDT_Int32))
   Properties(11)=(PropertyId=268435562,Data=(Type=SDT_Int32))
   Properties(12)=(PropertyId=268435563,Data=(Type=SDT_Int32))
   Properties(13)=(PropertyId=268435564,Data=(Type=SDT_Int32))
   Properties(14)=(PropertyId=268435565,Data=(Type=SDT_Int32))
   Properties(15)=(PropertyId=268435566,Data=(Type=SDT_Int32))
   Properties(16)=(PropertyId=268435707,Data=(Type=SDT_Int32))
   Properties(17)=(PropertyId=268435719,Data=(Type=SDT_Int32))
   Properties(18)=(PropertyId=268435708,Data=(Type=SDT_Int32))
   Properties(19)=(PropertyId=268435720,Data=(Type=SDT_Int32))
   Properties(20)=(PropertyId=268435721,Data=(Type=SDT_Int32))
   Properties(21)=(PropertyId=268435722,Data=(Type=SDT_Int32))
   Properties(22)=(PropertyId=268435782,Data=(Type=SDT_Int32))
   Properties(23)=(PropertyId=268435723,Data=(Type=SDT_Int32))
   Properties(24)=(PropertyId=268435727,Data=(Type=SDT_Int32))
   Properties(25)=(PropertyId=268435724,Data=(Type=SDT_Int32))
   Properties(26)=(PropertyId=268435728,Data=(Type=SDT_Int32))
   Properties(27)=(PropertyId=268435726,Data=(Type=SDT_Int32))
   Properties(28)=(PropertyId=268435573,Data=(Type=SDT_Int32))
   Properties(29)=(PropertyId=268435574,Data=(Type=SDT_Int32))
   Properties(30)=(PropertyId=268435575,Data=(Type=SDT_Int32))
   Properties(31)=(PropertyId=268435576,Data=(Type=SDT_Int32))
   Properties(32)=(PropertyId=268435577,Data=(Type=SDT_Int32))
   Properties(33)=(PropertyId=268435578,Data=(Type=SDT_Int32))
   Properties(34)=(PropertyId=268435579,Data=(Type=SDT_Int32))
   Properties(35)=(PropertyId=268435580,Data=(Type=SDT_Int32))
   Properties(36)=(PropertyId=268435581,Data=(Type=SDT_Int32))
   Properties(37)=(PropertyId=268435582,Data=(Type=SDT_Int32))
   Properties(38)=(PropertyId=268435583,Data=(Type=SDT_Int32))
   Properties(39)=(PropertyId=268435584,Data=(Type=SDT_Int32))
   Properties(40)=(PropertyId=268435585,Data=(Type=SDT_Int32))
   Properties(41)=(PropertyId=268435586,Data=(Type=SDT_Int32))
   Properties(42)=(PropertyId=268435588,Data=(Type=SDT_Int32))
   Properties(43)=(PropertyId=268435587,Data=(Type=SDT_Int32))
   Properties(44)=(PropertyId=268435589,Data=(Type=SDT_Int32))
   Name="Default__UTLeaderboardWriteDM"
   ObjectArchetype=UTLeaderboardWriteBase'UTGame.Default__UTLeaderboardWriteBase'
}
