/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** The class that writes the DM stats */

class UTLeaderboardWriteVehicleWeaponsDM extends UTLeaderboardWriteBase;











































































































































































































































































































































































































































































































































































































































































































































































































































































#linenumber 10

//Copies all relevant PRI game stats into the Properties struct of the OnlineStatsWrite
//There can be many more stats in the PRI than what is in the Properties table (on Xbox for example)
//If the Properties table does not contain the entry, the data is not written
function CopyAllStats(UTPlayerReplicationInfo PRI)
{
	local IntStat tempIntStat;

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
   PureViewIds(0)=7
   StatNameToStatIdMapping(0)=(StatName="DEATHS_CICADAROCKET",Id=268435465)
   StatNameToStatIdMapping(1)=(StatName="DEATHS_CICADATURRET",Id=268435466)
   StatNameToStatIdMapping(2)=(StatName="DEATHS_DARKWALKERPASSGUN",Id=268435467)
   StatNameToStatIdMapping(3)=(StatName="DEATHS_DARKWALKERTURRET",Id=268435468)
   StatNameToStatIdMapping(4)=(StatName="DEATHS_FURYGUN",Id=268435472)
   StatNameToStatIdMapping(5)=(StatName="DEATHS_GOLIATHMACHINEGUN",Id=268435473)
   StatNameToStatIdMapping(6)=(StatName="DEATHS_GOLIATHTURRET",Id=268435474)
   StatNameToStatIdMapping(7)=(StatName="DEATHS_HELLBENDERPRIMARY",Id=268435475)
   StatNameToStatIdMapping(8)=(StatName="DEATHS_LEVIATHANEXPLOSION",Id=268435730)
   StatNameToStatIdMapping(9)=(StatName="DEATHS_LEVIATHANPRIMARY",Id=268435479)
   StatNameToStatIdMapping(10)=(StatName="DEATHS_LEVIATHANTURRETBEAM",Id=268435480)
   StatNameToStatIdMapping(11)=(StatName="DEATHS_LEVIATHANTURRETROCKET",Id=268435481)
   StatNameToStatIdMapping(12)=(StatName="DEATHS_LEVIATHANTURRETSHOCK",Id=268435731)
   StatNameToStatIdMapping(13)=(StatName="DEATHS_LEVIATHANTURRETSTINGER",Id=268435482)
   StatNameToStatIdMapping(14)=(StatName="DEATHS_MANTAGUN",Id=268435484)
   StatNameToStatIdMapping(15)=(StatName="DEATHS_NEMESISTURRET",Id=268435485)
   StatNameToStatIdMapping(16)=(StatName="DEATHS_NIGHTSHADEGUN",Id=268435732)
   StatNameToStatIdMapping(17)=(StatName="DEATHS_PALADINEXPLOSION",Id=268435733)
   StatNameToStatIdMapping(18)=(StatName="DEATHS_PALADINGUN",Id=268435486)
   StatNameToStatIdMapping(19)=(StatName="DEATHS_RAPTORGUN",Id=268435488)
   StatNameToStatIdMapping(20)=(StatName="DEATHS_RAPTORROCKET",Id=268435735)
   StatNameToStatIdMapping(21)=(StatName="DEATHS_SCAVENGERGUN",Id=268435492)
   StatNameToStatIdMapping(22)=(StatName="DEATHS_SCAVENGERSTABBED",Id=268435736)
   StatNameToStatIdMapping(23)=(StatName="DEATHS_SCORPIONBLADE",Id=268435737)
   StatNameToStatIdMapping(24)=(StatName="DEATHS_SCORPIONGLOB",Id=268435738)
   StatNameToStatIdMapping(25)=(StatName="DEATHS_SCORPIONSELFDESTRUCT",Id=268435739)
   StatNameToStatIdMapping(26)=(StatName="DEATHS_SPMACAMERACRUSH",Id=268435741)
   StatNameToStatIdMapping(27)=(StatName="DEATHS_SPMACANNON",Id=268435498)
   StatNameToStatIdMapping(28)=(StatName="DEATHS_SPMATURRET",Id=268435742)
   StatNameToStatIdMapping(29)=(StatName="DEATHS_STEALTHBENDERGUN",Id=268435743)
   StatNameToStatIdMapping(30)=(StatName="DEATHS_TURRETPRIMARY",Id=268435501)
   StatNameToStatIdMapping(31)=(StatName="DEATHS_TURRETROCKET",Id=268435744)
   StatNameToStatIdMapping(32)=(StatName="DEATHS_TURRETSHOCK",Id=268435502)
   StatNameToStatIdMapping(33)=(StatName="DEATHS_TURRETSTINGER",Id=268435503)
   StatNameToStatIdMapping(34)=(StatName="DEATHS_VIPERGUN",Id=268435504)
   StatNameToStatIdMapping(35)=(StatName="DEATHS_VIPERSELFDESTRUCT",Id=268435745)
   StatNameToStatIdMapping(36)=(StatName="KILLS_CICADAROCKET",Id=268435507)
   StatNameToStatIdMapping(37)=(StatName="KILLS_CICADATURRET",Id=268435508)
   StatNameToStatIdMapping(38)=(StatName="KILLS_DARKWALKERPASSGUN",Id=268435509)
   StatNameToStatIdMapping(39)=(StatName="KILLS_DARKWALKERTURRET",Id=268435510)
   StatNameToStatIdMapping(40)=(StatName="KILLS_FURYGUN",Id=268435514)
   StatNameToStatIdMapping(41)=(StatName="KILLS_GOLIATHMACHINEGUN",Id=268435515)
   StatNameToStatIdMapping(42)=(StatName="KILLS_GOLIATHTURRET",Id=268435516)
   StatNameToStatIdMapping(43)=(StatName="KILLS_HELLBENDERPRIMARY",Id=268435518)
   StatNameToStatIdMapping(44)=(StatName="KILLS_LEVIATHANEXPLOSION",Id=268435747)
   StatNameToStatIdMapping(45)=(StatName="KILLS_LEVIATHANPRIMARY",Id=268435522)
   StatNameToStatIdMapping(46)=(StatName="KILLS_LEVIATHANTURRETBEAM",Id=268435525)
   StatNameToStatIdMapping(47)=(StatName="KILLS_LEVIATHANTURRETROCKET",Id=268435523)
   StatNameToStatIdMapping(48)=(StatName="KILLS_LEVIATHANTURRETSHOCK",Id=268435748)
   StatNameToStatIdMapping(49)=(StatName="KILLS_LEVIATHANTURRETSTINGER",Id=268435524)
   StatNameToStatIdMapping(50)=(StatName="KILLS_MANTAGUN",Id=268435527)
   StatNameToStatIdMapping(51)=(StatName="KILLS_NEMESISTURRET",Id=268435528)
   StatNameToStatIdMapping(52)=(StatName="KILLS_NIGHTSHADEGUN",Id=268435749)
   StatNameToStatIdMapping(53)=(StatName="KILLS_PALADINEXPLOSION",Id=268435750)
   StatNameToStatIdMapping(54)=(StatName="KILLS_PALADINGUN",Id=268435529)
   StatNameToStatIdMapping(55)=(StatName="KILLS_RAPTORGUN",Id=268435531)
   StatNameToStatIdMapping(56)=(StatName="KILLS_RAPTORROCKET",Id=268435751)
   StatNameToStatIdMapping(57)=(StatName="KILLS_SCAVENGERGUN",Id=268435536)
   StatNameToStatIdMapping(58)=(StatName="KILLS_SCAVENGERSTABBED",Id=268435752)
   StatNameToStatIdMapping(59)=(StatName="KILLS_SCORPIONBLADE",Id=268435753)
   StatNameToStatIdMapping(60)=(StatName="KILLS_SCORPIONGLOB",Id=268435754)
   StatNameToStatIdMapping(61)=(StatName="KILLS_SCORPIONSELFDESTRUCT",Id=268435755)
   StatNameToStatIdMapping(62)=(StatName="KILLS_SPMACAMERACRUSH",Id=268435757)
   StatNameToStatIdMapping(63)=(StatName="KILLS_SPMACANNON",Id=268435542)
   StatNameToStatIdMapping(64)=(StatName="KILLS_SPMATURRET",Id=268435758)
   StatNameToStatIdMapping(65)=(StatName="KILLS_STEALTHBENDERGUN",Id=268435759)
   StatNameToStatIdMapping(66)=(StatName="KILLS_TURRETPRIMARY",Id=268435545)
   StatNameToStatIdMapping(67)=(StatName="KILLS_TURRETROCKET",Id=268435760)
   StatNameToStatIdMapping(68)=(StatName="KILLS_TURRETSHOCK",Id=268435546)
   StatNameToStatIdMapping(69)=(StatName="KILLS_TURRETSTINGER",Id=268435547)
   StatNameToStatIdMapping(70)=(StatName="KILLS_VIPERGUN",Id=268435548)
   StatNameToStatIdMapping(71)=(StatName="KILLS_VIPERSELFDESTRUCT",Id=268435761)
   StatNameToStatIdMapping(72)=(StatName="SUICIDES_CICADAROCKET",Id=268435628)
   StatNameToStatIdMapping(73)=(StatName="SUICIDES_CICADATURRET",Id=268435629)
   StatNameToStatIdMapping(74)=(StatName="SUICIDES_DARKWALKERPASSGUN",Id=268435630)
   StatNameToStatIdMapping(75)=(StatName="SUICIDES_DARKWALKERTURRET",Id=268435631)
   StatNameToStatIdMapping(76)=(StatName="SUICIDES_FURYGUN",Id=268435635)
   StatNameToStatIdMapping(77)=(StatName="SUICIDES_GOLIATHMACHINEGUN",Id=268435636)
   StatNameToStatIdMapping(78)=(StatName="SUICIDES_GOLIATHTURRET",Id=268435637)
   StatNameToStatIdMapping(79)=(StatName="SUICIDES_HELLBENDERPRIMARY",Id=268435638)
   StatNameToStatIdMapping(80)=(StatName="SUICIDES_LEVIATHANEXPLOSION",Id=268435762)
   StatNameToStatIdMapping(81)=(StatName="SUICIDES_LEVIATHANPRIMARY",Id=268435642)
   StatNameToStatIdMapping(82)=(StatName="SUICIDES_LEVIATHANTURRETBEAM",Id=268435643)
   StatNameToStatIdMapping(83)=(StatName="SUICIDES_LEVIATHANTURRETROCKET",Id=268435644)
   StatNameToStatIdMapping(84)=(StatName="SUICIDES_LEVIATHANTURRETSHOCK",Id=268435763)
   StatNameToStatIdMapping(85)=(StatName="SUICIDES_LEVIATHANTURRETSTINGER",Id=268435645)
   StatNameToStatIdMapping(86)=(StatName="SUICIDES_MANTAGUN",Id=268435647)
   StatNameToStatIdMapping(87)=(StatName="SUICIDES_NEMESISTURRET",Id=268435648)
   StatNameToStatIdMapping(88)=(StatName="SUICIDES_NIGHTSHADEGUN",Id=268435764)
   StatNameToStatIdMapping(89)=(StatName="SUICIDES_PALADINEXPLOSION",Id=268435765)
   StatNameToStatIdMapping(90)=(StatName="SUICIDES_PALADINGUN",Id=268435649)
   StatNameToStatIdMapping(91)=(StatName="SUICIDES_RAPTORGUN",Id=268435651)
   StatNameToStatIdMapping(92)=(StatName="SUICIDES_RAPTORROCKET",Id=268435766)
   StatNameToStatIdMapping(93)=(StatName="SUICIDES_SCAVENGERGUN",Id=268435655)
   StatNameToStatIdMapping(94)=(StatName="SUICIDES_SCAVENGERSTABBED",Id=268435767)
   StatNameToStatIdMapping(95)=(StatName="SUICIDES_SCORPIONBLADE",Id=268435768)
   StatNameToStatIdMapping(96)=(StatName="SUICIDES_SCORPIONGLOB",Id=268435769)
   StatNameToStatIdMapping(97)=(StatName="SUICIDES_SCORPIONSELFDESTRUCT",Id=268435770)
   StatNameToStatIdMapping(98)=(StatName="SUICIDES_SPMACAMERACRUSH",Id=268435772)
   StatNameToStatIdMapping(99)=(StatName="SUICIDES_SPMACANNON",Id=268435661)
   StatNameToStatIdMapping(100)=(StatName="SUICIDES_SPMATURRET",Id=268435773)
   StatNameToStatIdMapping(101)=(StatName="SUICIDES_STEALTHBENDERGUN",Id=268435774)
   StatNameToStatIdMapping(102)=(StatName="SUICIDES_TURRETPRIMARY",Id=268435664)
   StatNameToStatIdMapping(103)=(StatName="SUICIDES_TURRETROCKET",Id=268435775)
   StatNameToStatIdMapping(104)=(StatName="SUICIDES_TURRETSHOCK",Id=268435665)
   StatNameToStatIdMapping(105)=(StatName="SUICIDES_TURRETSTINGER",Id=268435666)
   StatNameToStatIdMapping(106)=(StatName="SUICIDES_VIPERGUN",Id=268435667)
   StatNameToStatIdMapping(107)=(StatName="SUICIDES_VIPERSELFDESTRUCT",Id=268435776)
   Properties(0)=(PropertyId=268435465,Data=(Type=SDT_Int32))
   Properties(1)=(PropertyId=268435466,Data=(Type=SDT_Int32))
   Properties(2)=(PropertyId=268435467,Data=(Type=SDT_Int32))
   Properties(3)=(PropertyId=268435468,Data=(Type=SDT_Int32))
   Properties(4)=(PropertyId=268435472,Data=(Type=SDT_Int32))
   Properties(5)=(PropertyId=268435473,Data=(Type=SDT_Int32))
   Properties(6)=(PropertyId=268435474,Data=(Type=SDT_Int32))
   Properties(7)=(PropertyId=268435475,Data=(Type=SDT_Int32))
   Properties(8)=(PropertyId=268435730,Data=(Type=SDT_Int32))
   Properties(9)=(PropertyId=268435479,Data=(Type=SDT_Int32))
   Properties(10)=(PropertyId=268435480,Data=(Type=SDT_Int32))
   Properties(11)=(PropertyId=268435481,Data=(Type=SDT_Int32))
   Properties(12)=(PropertyId=268435731,Data=(Type=SDT_Int32))
   Properties(13)=(PropertyId=268435482,Data=(Type=SDT_Int32))
   Properties(14)=(PropertyId=268435484,Data=(Type=SDT_Int32))
   Properties(15)=(PropertyId=268435485,Data=(Type=SDT_Int32))
   Properties(16)=(PropertyId=268435732,Data=(Type=SDT_Int32))
   Properties(17)=(PropertyId=268435733,Data=(Type=SDT_Int32))
   Properties(18)=(PropertyId=268435486,Data=(Type=SDT_Int32))
   Properties(19)=(PropertyId=268435488,Data=(Type=SDT_Int32))
   Properties(20)=(PropertyId=268435735,Data=(Type=SDT_Int32))
   Properties(21)=(PropertyId=268435492,Data=(Type=SDT_Int32))
   Properties(22)=(PropertyId=268435736,Data=(Type=SDT_Int32))
   Properties(23)=(PropertyId=268435737,Data=(Type=SDT_Int32))
   Properties(24)=(PropertyId=268435738,Data=(Type=SDT_Int32))
   Properties(25)=(PropertyId=268435739,Data=(Type=SDT_Int32))
   Properties(26)=(PropertyId=268435741,Data=(Type=SDT_Int32))
   Properties(27)=(PropertyId=268435498,Data=(Type=SDT_Int32))
   Properties(28)=(PropertyId=268435742,Data=(Type=SDT_Int32))
   Properties(29)=(PropertyId=268435743,Data=(Type=SDT_Int32))
   Properties(30)=(PropertyId=268435501,Data=(Type=SDT_Int32))
   Properties(31)=(PropertyId=268435744,Data=(Type=SDT_Int32))
   Properties(32)=(PropertyId=268435502,Data=(Type=SDT_Int32))
   Properties(33)=(PropertyId=268435503,Data=(Type=SDT_Int32))
   Properties(34)=(PropertyId=268435504,Data=(Type=SDT_Int32))
   Properties(35)=(PropertyId=268435745,Data=(Type=SDT_Int32))
   Properties(36)=(PropertyId=268435507,Data=(Type=SDT_Int32))
   Properties(37)=(PropertyId=268435508,Data=(Type=SDT_Int32))
   Properties(38)=(PropertyId=268435509,Data=(Type=SDT_Int32))
   Properties(39)=(PropertyId=268435510,Data=(Type=SDT_Int32))
   Properties(40)=(PropertyId=268435514,Data=(Type=SDT_Int32))
   Properties(41)=(PropertyId=268435515,Data=(Type=SDT_Int32))
   Properties(42)=(PropertyId=268435516,Data=(Type=SDT_Int32))
   Properties(43)=(PropertyId=268435518,Data=(Type=SDT_Int32))
   Properties(44)=(PropertyId=268435747,Data=(Type=SDT_Int32))
   Properties(45)=(PropertyId=268435522,Data=(Type=SDT_Int32))
   Properties(46)=(PropertyId=268435525,Data=(Type=SDT_Int32))
   Properties(47)=(PropertyId=268435523,Data=(Type=SDT_Int32))
   Properties(48)=(PropertyId=268435748,Data=(Type=SDT_Int32))
   Properties(49)=(PropertyId=268435524,Data=(Type=SDT_Int32))
   Properties(50)=(PropertyId=268435527,Data=(Type=SDT_Int32))
   Properties(51)=(PropertyId=268435528,Data=(Type=SDT_Int32))
   Properties(52)=(PropertyId=268435749,Data=(Type=SDT_Int32))
   Properties(53)=(PropertyId=268435750,Data=(Type=SDT_Int32))
   Properties(54)=(PropertyId=268435529,Data=(Type=SDT_Int32))
   Properties(55)=(PropertyId=268435531,Data=(Type=SDT_Int32))
   Properties(56)=(PropertyId=268435751,Data=(Type=SDT_Int32))
   Properties(57)=(PropertyId=268435536,Data=(Type=SDT_Int32))
   Properties(58)=(PropertyId=268435752,Data=(Type=SDT_Int32))
   Properties(59)=(PropertyId=268435753,Data=(Type=SDT_Int32))
   Properties(60)=(PropertyId=268435754,Data=(Type=SDT_Int32))
   Properties(61)=(PropertyId=268435755,Data=(Type=SDT_Int32))
   Properties(62)=(PropertyId=268435757,Data=(Type=SDT_Int32))
   Properties(63)=(PropertyId=268435542,Data=(Type=SDT_Int32))
   Properties(64)=(PropertyId=268435758,Data=(Type=SDT_Int32))
   Properties(65)=(PropertyId=268435759,Data=(Type=SDT_Int32))
   Properties(66)=(PropertyId=268435545,Data=(Type=SDT_Int32))
   Properties(67)=(PropertyId=268435760,Data=(Type=SDT_Int32))
   Properties(68)=(PropertyId=268435546,Data=(Type=SDT_Int32))
   Properties(69)=(PropertyId=268435547,Data=(Type=SDT_Int32))
   Properties(70)=(PropertyId=268435548,Data=(Type=SDT_Int32))
   Properties(71)=(PropertyId=268435761,Data=(Type=SDT_Int32))
   Properties(72)=(PropertyId=268435628,Data=(Type=SDT_Int32))
   Properties(73)=(PropertyId=268435629,Data=(Type=SDT_Int32))
   Properties(74)=(PropertyId=268435630,Data=(Type=SDT_Int32))
   Properties(75)=(PropertyId=268435631,Data=(Type=SDT_Int32))
   Properties(76)=(PropertyId=268435635,Data=(Type=SDT_Int32))
   Properties(77)=(PropertyId=268435636,Data=(Type=SDT_Int32))
   Properties(78)=(PropertyId=268435637,Data=(Type=SDT_Int32))
   Properties(79)=(PropertyId=268435638,Data=(Type=SDT_Int32))
   Properties(80)=(PropertyId=268435762,Data=(Type=SDT_Int32))
   Properties(81)=(PropertyId=268435642,Data=(Type=SDT_Int32))
   Properties(82)=(PropertyId=268435643,Data=(Type=SDT_Int32))
   Properties(83)=(PropertyId=268435644,Data=(Type=SDT_Int32))
   Properties(84)=(PropertyId=268435763,Data=(Type=SDT_Int32))
   Properties(85)=(PropertyId=268435645,Data=(Type=SDT_Int32))
   Properties(86)=(PropertyId=268435647,Data=(Type=SDT_Int32))
   Properties(87)=(PropertyId=268435648,Data=(Type=SDT_Int32))
   Properties(88)=(PropertyId=268435764,Data=(Type=SDT_Int32))
   Properties(89)=(PropertyId=268435765,Data=(Type=SDT_Int32))
   Properties(90)=(PropertyId=268435649,Data=(Type=SDT_Int32))
   Properties(91)=(PropertyId=268435651,Data=(Type=SDT_Int32))
   Properties(92)=(PropertyId=268435766,Data=(Type=SDT_Int32))
   Properties(93)=(PropertyId=268435655,Data=(Type=SDT_Int32))
   Properties(94)=(PropertyId=268435767,Data=(Type=SDT_Int32))
   Properties(95)=(PropertyId=268435768,Data=(Type=SDT_Int32))
   Properties(96)=(PropertyId=268435769,Data=(Type=SDT_Int32))
   Properties(97)=(PropertyId=268435770,Data=(Type=SDT_Int32))
   Properties(98)=(PropertyId=268435772,Data=(Type=SDT_Int32))
   Properties(99)=(PropertyId=268435661,Data=(Type=SDT_Int32))
   Properties(100)=(PropertyId=268435773,Data=(Type=SDT_Int32))
   Properties(101)=(PropertyId=268435774,Data=(Type=SDT_Int32))
   Properties(102)=(PropertyId=268435664,Data=(Type=SDT_Int32))
   Properties(103)=(PropertyId=268435775,Data=(Type=SDT_Int32))
   Properties(104)=(PropertyId=268435665,Data=(Type=SDT_Int32))
   Properties(105)=(PropertyId=268435666,Data=(Type=SDT_Int32))
   Properties(106)=(PropertyId=268435667,Data=(Type=SDT_Int32))
   Properties(107)=(PropertyId=268435776,Data=(Type=SDT_Int32))
   ViewIds(0)=5
   ArbitratedViewIds(0)=7
   Name="Default__UTLeaderboardWriteVehicleWeaponsDM"
   ObjectArchetype=UTLeaderboardWriteBase'UTGame.Default__UTLeaderboardWriteBase'
}
