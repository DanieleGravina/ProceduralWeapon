/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** Common columns to be read from the DM tables */
class UTLeaderboardReadDM extends UTLeaderboardReadBase;











































































































































































































































































































































































































































































































































































































































































































































































































































































#linenumber 8

defaultproperties
{
   ViewId=1
   SortColumnId=998
   ColumnIds(0)=998
   ColumnIds(1)=1
   ColumnIds(2)=2
   ColumnIds(3)=42
   ColumnIds(4)=3
   ColumnIds(5)=4
   ColumnIds(6)=5
   ColumnIds(7)=6
   ColumnIds(8)=43
   ColumnIds(9)=45
   ColumnIds(10)=44
   ColumnIds(11)=8
   ColumnIds(12)=9
   ColumnIds(13)=10
   ColumnIds(14)=11
   ColumnIds(15)=12
   ColumnIds(16)=13
   ColumnIds(17)=34
   ColumnIds(18)=35
   ColumnIds(19)=36
   ColumnIds(20)=7
   ColumnIds(21)=40
   ColumnIds(22)=37
   ColumnIds(23)=32
   ColumnIds(24)=33
   ColumnIds(25)=38
   ColumnIds(26)=39
   ColumnIds(27)=31
   ColumnIds(28)=41
   ColumnIds(29)=14
   ColumnIds(30)=15
   ColumnIds(31)=16
   ColumnIds(32)=17
   ColumnIds(33)=18
   ColumnIds(34)=19
   ColumnIds(35)=20
   ColumnIds(36)=21
   ColumnIds(37)=22
   ColumnIds(38)=23
   ColumnIds(39)=24
   ColumnIds(40)=25
   ColumnIds(41)=26
   ColumnIds(42)=27
   ColumnIds(43)=28
   ColumnIds(44)=29
   ColumnIds(45)=30
   ColumnIds(46)=52
   ColumnIds(47)=55
   ColumnIds(48)=53
   ColumnIds(49)=54
   ColumnIds(50)=58
   ColumnIds(51)=56
   ColumnIds(52)=46
   ColumnIds(53)=47
   ColumnIds(54)=48
   ColumnIds(55)=49
   ColumnIds(56)=50
   ColumnIds(57)=51
   ColumnMappings(0)=(Id=1,Name="EVENT_KILLS",ColumnName="Uccisioni")
   ColumnMappings(1)=(Id=2,Name="EVENT_DEATHS",ColumnName="Morti")
   ColumnMappings(2)=(Id=42,Name="EVENT_BULLSEYE",ColumnName="Bersaglio")
   ColumnMappings(3)=(Id=3,Name="EVENT_DENIEDREDEEMER",ColumnName="Redentore negato")
   ColumnMappings(4)=(Id=4,Name="EVENT_EAGLEEYE",ColumnName="Vista Aquila")
   ColumnMappings(5)=(Id=5,Name="EVENT_ENDSPREE",ColumnName="Raptus Terminati")
   ColumnMappings(6)=(Id=6,Name="EVENT_FIRSTBLOOD",ColumnName="Prime uccisioni")
   ColumnMappings(7)=(Id=43,Name="EVENT_HIJACKED",ColumnName="Dirottamenti veicolo")
   ColumnMappings(8)=(Id=45,Name="EVENT_RANOVERKILLS",ColumnName="Uccisioni da veicolo")
   ColumnMappings(9)=(Id=44,Name="EVENT_RANOVERDEATHS",ColumnName="Ucciso da veicolo")
   ColumnMappings(10)=(Id=8,Name="EVENT_TOPGUN",ColumnName="Top Guns")
   ColumnMappings(11)=(Id=9,Name="MULTIKILL_DOUBLEKILL",ColumnName="Doppia Uccisione")
   ColumnMappings(12)=(Id=10,Name="MULTIKILL_MEGAKILL",ColumnName="Mega Uccisione")
   ColumnMappings(13)=(Id=11,Name="MULTIKILL_MONSTERKILL",ColumnName="Uccisione mostruosa")
   ColumnMappings(14)=(Id=12,Name="MULTIKILL_MULTIKILL",ColumnName="Multi uccisione")
   ColumnMappings(15)=(Id=13,Name="MULTIKILL_ULTRAKILL",ColumnName="Ultra uccisione")
   ColumnMappings(16)=(Id=34,Name="PICKUPS_BERSERK",ColumnName="Berserk")
   ColumnMappings(17)=(Id=35,Name="PICKUPS_INVISIBILITY",ColumnName="Invisibilità")
   ColumnMappings(18)=(Id=36,Name="PICKUPS_INVULNERABILITY",ColumnName="Invulnerabilità")
   ColumnMappings(19)=(Id=7,Name="PICKUPS_JUMPBOOTS",ColumnName="Stivali Anti-Gravità")
   ColumnMappings(20)=(Id=40,Name="PICKUPS_SHIELDBELT",ColumnName="Elettrocintura")
   ColumnMappings(21)=(Id=37,Name="PICKUPS_UDAMAGE",ColumnName="UDamage")
   ColumnMappings(22)=(Id=32,Name="PICKUPS_ARMOR",ColumnName="Pickup Armatura")
   ColumnMappings(23)=(Id=33,Name="PICKUPS_HEALTH",ColumnName="Oggetti curatori")
   ColumnMappings(24)=(Id=38,Name="POWERUPTIME_BERSERK",ColumnName="Tempo Berserk")
   ColumnMappings(25)=(Id=39,Name="POWERUPTIME_INVISIBILITY",ColumnName="Tempo invisibilità")
   ColumnMappings(26)=(Id=31,Name="POWERUPTIME_INVULNERABILITY",ColumnName="Tempo invulnerabilità")
   ColumnMappings(27)=(Id=41,Name="POWERUPTIME_UDAMAGE",ColumnName="Tempo danno")
   ColumnMappings(28)=(Id=14,Name="REWARD_BIGGAMEHUNTER",ColumnName="Cacciatore di Animali di Grossa Taglia")
   ColumnMappings(29)=(Id=15,Name="REWARD_BIOHAZARD",ColumnName="Rischio Biologico")
   ColumnMappings(30)=(Id=16,Name="REWARD_BLUESTREAK",ColumnName="Raggio Blu")
   ColumnMappings(31)=(Id=17,Name="REWARD_COMBOKING",ColumnName="Re del combo")
   ColumnMappings(32)=(Id=18,Name="REWARD_FLAKMASTER",ColumnName="Maestro Flak")
   ColumnMappings(33)=(Id=19,Name="REWARD_GUNSLINGER",ColumnName="Pistolero")
   ColumnMappings(34)=(Id=20,Name="REWARD_HEADHUNTER",ColumnName="Cacciatore di teste")
   ColumnMappings(35)=(Id=21,Name="REWARD_JACKHAMMER",ColumnName="Martello pneumatico")
   ColumnMappings(36)=(Id=22,Name="REWARD_ROADRAMPAGE",ColumnName="Furia per Strada")
   ColumnMappings(37)=(Id=23,Name="REWARD_ROCKETSCIENTIST",ColumnName="Scienziato Missilistica")
   ColumnMappings(38)=(Id=24,Name="REWARD_SHAFTMASTER",ColumnName="Maestro di lance")
   ColumnMappings(39)=(Id=25,Name="SPREE_DOMINATING",ColumnName="Sto dominando!")
   ColumnMappings(40)=(Id=26,Name="SPREE_GODLIKE",ColumnName="Divino")
   ColumnMappings(41)=(Id=27,Name="SPREE_KILLINGSPREE",ColumnName="Raptus Omicida")
   ColumnMappings(42)=(Id=28,Name="SPREE_RAMPAGE",ColumnName="Azioni violente")
   ColumnMappings(43)=(Id=29,Name="SPREE_MASSACRE",ColumnName="Massacro")
   ColumnMappings(44)=(Id=30,Name="SPREE_UNSTOPPABLE",ColumnName="Implacabile")
   ColumnMappings(45)=(Id=52,Name="EVENT_HATTRICK",ColumnName="Hat Tricks")
   ColumnMappings(46)=(Id=53,Name="EVENT_KILLEDFLAGCARRIER",ColumnName="Porta bandiera ucciso")
   ColumnMappings(47)=(Id=54,Name="EVENT_RETURNEDFLAG",ColumnName="Bandiere riportate")
   ColumnMappings(48)=(Id=58,Name="EVENT_SCOREDFLAG",ColumnName="Bandiere totalizzate")
   ColumnMappings(49)=(Id=55,Name="EVENT_LASTSECONDSAVE",ColumnName="Salvate all'ultimo secondo")
   ColumnMappings(50)=(Id=56,Name="EVENT_RETURNEDORB",ColumnName="Globi riportati")
   ColumnMappings(51)=(Id=46,Name="NODE_DAMAGEDCORE",ColumnName="Nuclei danneggiati")
   ColumnMappings(52)=(Id=47,Name="NODE_DESTROYEDCORE",ColumnName="Nuclei distrutti")
   ColumnMappings(53)=(Id=48,Name="NODE_DESTROYEDNODE",ColumnName="Nodi distrutti")
   ColumnMappings(54)=(Id=49,Name="NODE_HEALEDNODE",ColumnName="Nodi riparati")
   ColumnMappings(55)=(Id=50,Name="NODE_NODEBUILT",ColumnName="Nodi costruiti")
   ColumnMappings(56)=(Id=51,Name="NODE_NODEBUSTER",ColumnName="Spacca nodi")
   ColumnMappings(57)=(Id=998,Name="ELO",ColumnName="Teschi Collezionati")
   ColumnMappings(58)=(ColumnName="Teschi Ottenuti")
   ColumnMappings(59)=(ColumnName="Massimo numero di Teschi trasportato")
   ColumnMappings(60)=(ColumnName="Punti di tradimento")
   ColumnMappings(61)=(ColumnName="Premi")
   ViewName="PlayerDM"
   Name="Default__UTLeaderboardReadDM"
   ObjectArchetype=UTLeaderboardReadBase'UTGame.Default__UTLeaderboardReadBase'
}
