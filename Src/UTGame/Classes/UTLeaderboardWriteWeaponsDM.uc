/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** The class that writes the DM stats */

class UTLeaderboardWriteWeaponsDM extends UTLeaderboardWriteBase;











































































































































































































































































































































































































































































































































































































































































































































































































































































#linenumber 10

//Copies all relevant PRI game stats into the Properties struct of the OnlineStatsWrite
//There can be many more stats in the PRI than what is in the Properties table (on Xbox for example)
//If the Properties table does not contain the entry, the data is not written
function CopyAllStats(UTPlayerReplicationInfo PRI)
{
	local IntStat tempIntStat;
	local int Stat1Idx, Stat2Idx;

	//Add any headshots to sniper kills
	Stat1Idx = PRI.KillStats.Find('StatName', 'KILLS_HEADSHOT');
	if (Stat1Idx != INDEX_NONE)
	{
		Stat2Idx = PRI.KillStats.Find('StatName', 'KILLS_SNIPERRIFLE');
		if (Stat2Idx != INDEX_NONE)
		{
			//Sum the headshot/sniper kills
			PRI.KillStats[Stat2Idx].StatValue += PRI.KillStats[Stat1Idx].StatValue;
		}
		else
		{
			//No sniper kills alone existed, copy headshots over
			tempIntStat.StatName = 'KILLS_SNIPERRIFLE';
			tempIntStat.StatValue = PRI.KillStats[Stat1Idx].StatValue;
			PRI.KillStats[PRI.KillStats.length] = tempIntStat;
		}
	}

	//Add any headshots to sniper deaths
	Stat1Idx = PRI.DeathStats.Find('StatName', 'DEATHS_HEADSHOT');
	if (Stat1Idx != INDEX_NONE)
	{
		Stat2Idx = PRI.DeathStats.Find('StatName', 'DEATHS_SNIPERRIFLE');
		if (Stat2Idx != INDEX_NONE)
		{
			//Sum the headshot/sniper deaths
			PRI.DeathStats[Stat2Idx].StatValue += PRI.DeathStats[Stat1Idx].StatValue;
		}
		else
		{
			//No sniper kills alone existed, copy headshots over
			tempIntStat.StatName = 'DEATHS_SNIPERRIFLE';
			tempIntStat.StatValue = PRI.DeathStats[Stat1Idx].StatValue;
			PRI.DeathStats[PRI.DeathStats.length] = tempIntStat;
		}
	}

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

	Super.CopyAllStats(PRI);
}

defaultproperties
{
   PureViewIds(0)=8
   StatNameToStatIdMapping(0)=(StatName="DEATHS_AVRIL",Id=268435463)
   StatNameToStatIdMapping(1)=(StatName="DEATHS_BIORIFLE",Id=268435464)
   StatNameToStatIdMapping(2)=(StatName="DEATHS_ENFORCER",Id=268435469)
   StatNameToStatIdMapping(3)=(StatName="DEATHS_ENVIRONMENT",Id=268435470)
   StatNameToStatIdMapping(4)=(StatName="DEATHS_FLAKCANNON",Id=268435471)
   StatNameToStatIdMapping(5)=(StatName="DEATHS_HEADSHOT",Id=268435780)
   StatNameToStatIdMapping(6)=(StatName="DEATHS_IMPACTHAMMER",Id=268435476)
   StatNameToStatIdMapping(7)=(StatName="DEATHS_INSTAGIB",Id=268435477)
   StatNameToStatIdMapping(8)=(StatName="DEATHS_LINKGUN",Id=268435483)
   StatNameToStatIdMapping(9)=(StatName="DEATHS_REDEEMER",Id=268435489)
   StatNameToStatIdMapping(10)=(StatName="DEATHS_ROCKETLAUNCHER",Id=268435490)
   StatNameToStatIdMapping(11)=(StatName="DEATHS_SHAPEDCHARGE",Id=268435494)
   StatNameToStatIdMapping(12)=(StatName="DEATHS_SHOCKCOMBO",Id=268435716)
   StatNameToStatIdMapping(13)=(StatName="DEATHS_SHOCKRIFLE",Id=268435496)
   StatNameToStatIdMapping(14)=(StatName="DEATHS_SNIPERRIFLE",Id=268435712)
   StatNameToStatIdMapping(15)=(StatName="DEATHS_SPIDERMINE",Id=268435740)
   StatNameToStatIdMapping(16)=(StatName="DEATHS_STINGER",Id=268435499)
   StatNameToStatIdMapping(17)=(StatName="DEATHS_TRANSLOCATOR",Id=268435500)
   StatNameToStatIdMapping(18)=(StatName="KILLS_AVRIL",Id=268435505)
   StatNameToStatIdMapping(19)=(StatName="KILLS_BIORIFLE",Id=268435506)
   StatNameToStatIdMapping(20)=(StatName="KILLS_ENFORCER",Id=268435511)
   StatNameToStatIdMapping(21)=(StatName="KILLS_ENVIRONMENT",Id=268435512)
   StatNameToStatIdMapping(22)=(StatName="KILLS_FLAKCANNON",Id=268435513)
   StatNameToStatIdMapping(23)=(StatName="KILLS_HEADSHOT",Id=268435517)
   StatNameToStatIdMapping(24)=(StatName="KILLS_IMPACTHAMMER",Id=268435519)
   StatNameToStatIdMapping(25)=(StatName="KILLS_INSTAGIB",Id=268435520)
   StatNameToStatIdMapping(26)=(StatName="KILLS_LINKGUN",Id=268435526)
   StatNameToStatIdMapping(27)=(StatName="KILLS_REDEEMER",Id=268435533)
   StatNameToStatIdMapping(28)=(StatName="KILLS_ROCKETLAUNCHER",Id=268435534)
   StatNameToStatIdMapping(29)=(StatName="KILLS_SHAPEDCHARGE",Id=268435538)
   StatNameToStatIdMapping(30)=(StatName="KILLS_SHOCKCOMBO",Id=268435540)
   StatNameToStatIdMapping(31)=(StatName="KILLS_SHOCKRIFLE",Id=268435541)
   StatNameToStatIdMapping(32)=(StatName="KILLS_SNIPERRIFLE",Id=268435713)
   StatNameToStatIdMapping(33)=(StatName="KILLS_SPIDERMINE",Id=268435756)
   StatNameToStatIdMapping(34)=(StatName="KILLS_STINGER",Id=268435543)
   StatNameToStatIdMapping(35)=(StatName="KILLS_TRANSLOCATOR",Id=268435544)
   StatNameToStatIdMapping(36)=(StatName="SUICIDES_AVRIL",Id=268435626)
   StatNameToStatIdMapping(37)=(StatName="SUICIDES_BIORIFLE",Id=268435627)
   StatNameToStatIdMapping(38)=(StatName="SUICIDES_ENFORCER",Id=268435632)
   StatNameToStatIdMapping(39)=(StatName="SUICIDES_ENVIRONMENT",Id=268435633)
   StatNameToStatIdMapping(40)=(StatName="SUICIDES_FLAKCANNON",Id=268435634)
   StatNameToStatIdMapping(41)=(StatName="SUICIDES_IMPACTHAMMER",Id=268435639)
   StatNameToStatIdMapping(42)=(StatName="SUICIDES_INSTAGIB",Id=268435640)
   StatNameToStatIdMapping(43)=(StatName="SUICIDES_LINKGUN",Id=268435646)
   StatNameToStatIdMapping(44)=(StatName="SUICIDES_REDEEMER",Id=268435652)
   StatNameToStatIdMapping(45)=(StatName="SUICIDES_ROCKETLAUNCHER",Id=268435653)
   StatNameToStatIdMapping(46)=(StatName="SUICIDES_SHAPEDCHARGE",Id=268435657)
   StatNameToStatIdMapping(47)=(StatName="SUICIDES_SHOCKCOMBO",Id=268435715)
   StatNameToStatIdMapping(48)=(StatName="SUICIDES_SHOCKRIFLE",Id=268435659)
   StatNameToStatIdMapping(49)=(StatName="SUICIDES_SNIPERRIFLE",Id=268435714)
   StatNameToStatIdMapping(50)=(StatName="SUICIDES_SPIDERMINE",Id=268435777)
   StatNameToStatIdMapping(51)=(StatName="SUICIDES_STINGER",Id=268435662)
   StatNameToStatIdMapping(52)=(StatName="SUICIDES_TRANSLOCATOR",Id=268435663)
   Properties(0)=(PropertyId=268435463,Data=(Type=SDT_Int32))
   Properties(1)=(PropertyId=268435464,Data=(Type=SDT_Int32))
   Properties(2)=(PropertyId=268435469,Data=(Type=SDT_Int32))
   Properties(3)=(PropertyId=268435470,Data=(Type=SDT_Int32))
   Properties(4)=(PropertyId=268435471,Data=(Type=SDT_Int32))
   Properties(5)=(PropertyId=268435780,Data=(Type=SDT_Int32))
   Properties(6)=(PropertyId=268435476,Data=(Type=SDT_Int32))
   Properties(7)=(PropertyId=268435477,Data=(Type=SDT_Int32))
   Properties(8)=(PropertyId=268435483,Data=(Type=SDT_Int32))
   Properties(9)=(PropertyId=268435489,Data=(Type=SDT_Int32))
   Properties(10)=(PropertyId=268435490,Data=(Type=SDT_Int32))
   Properties(11)=(PropertyId=268435494,Data=(Type=SDT_Int32))
   Properties(12)=(PropertyId=268435716,Data=(Type=SDT_Int32))
   Properties(13)=(PropertyId=268435496,Data=(Type=SDT_Int32))
   Properties(14)=(PropertyId=268435712,Data=(Type=SDT_Int32))
   Properties(15)=(PropertyId=268435740,Data=(Type=SDT_Int32))
   Properties(16)=(PropertyId=268435499,Data=(Type=SDT_Int32))
   Properties(17)=(PropertyId=268435500,Data=(Type=SDT_Int32))
   Properties(18)=(PropertyId=268435505,Data=(Type=SDT_Int32))
   Properties(19)=(PropertyId=268435506,Data=(Type=SDT_Int32))
   Properties(20)=(PropertyId=268435511,Data=(Type=SDT_Int32))
   Properties(21)=(PropertyId=268435512,Data=(Type=SDT_Int32))
   Properties(22)=(PropertyId=268435513,Data=(Type=SDT_Int32))
   Properties(23)=(PropertyId=268435517,Data=(Type=SDT_Int32))
   Properties(24)=(PropertyId=268435519,Data=(Type=SDT_Int32))
   Properties(25)=(PropertyId=268435520,Data=(Type=SDT_Int32))
   Properties(26)=(PropertyId=268435526,Data=(Type=SDT_Int32))
   Properties(27)=(PropertyId=268435533,Data=(Type=SDT_Int32))
   Properties(28)=(PropertyId=268435534,Data=(Type=SDT_Int32))
   Properties(29)=(PropertyId=268435538,Data=(Type=SDT_Int32))
   Properties(30)=(PropertyId=268435540,Data=(Type=SDT_Int32))
   Properties(31)=(PropertyId=268435541,Data=(Type=SDT_Int32))
   Properties(32)=(PropertyId=268435713,Data=(Type=SDT_Int32))
   Properties(33)=(PropertyId=268435756,Data=(Type=SDT_Int32))
   Properties(34)=(PropertyId=268435543,Data=(Type=SDT_Int32))
   Properties(35)=(PropertyId=268435544,Data=(Type=SDT_Int32))
   Properties(36)=(PropertyId=268435626,Data=(Type=SDT_Int32))
   Properties(37)=(PropertyId=268435627,Data=(Type=SDT_Int32))
   Properties(38)=(PropertyId=268435632,Data=(Type=SDT_Int32))
   Properties(39)=(PropertyId=268435633,Data=(Type=SDT_Int32))
   Properties(40)=(PropertyId=268435634,Data=(Type=SDT_Int32))
   Properties(41)=(PropertyId=268435639,Data=(Type=SDT_Int32))
   Properties(42)=(PropertyId=268435640,Data=(Type=SDT_Int32))
   Properties(43)=(PropertyId=268435646,Data=(Type=SDT_Int32))
   Properties(44)=(PropertyId=268435652,Data=(Type=SDT_Int32))
   Properties(45)=(PropertyId=268435653,Data=(Type=SDT_Int32))
   Properties(46)=(PropertyId=268435657,Data=(Type=SDT_Int32))
   Properties(47)=(PropertyId=268435715,Data=(Type=SDT_Int32))
   Properties(48)=(PropertyId=268435659,Data=(Type=SDT_Int32))
   Properties(49)=(PropertyId=268435714,Data=(Type=SDT_Int32))
   Properties(50)=(PropertyId=268435777,Data=(Type=SDT_Int32))
   Properties(51)=(PropertyId=268435662,Data=(Type=SDT_Int32))
   Properties(52)=(PropertyId=268435663,Data=(Type=SDT_Int32))
   ViewIds(0)=3
   ArbitratedViewIds(0)=8
   Name="Default__UTLeaderboardWriteWeaponsDM"
   ObjectArchetype=UTLeaderboardWriteBase'UTGame.Default__UTLeaderboardWriteBase'
}
