class TestGame extends UTDeathmatch;

const NUM_BOTS = 2;
const NUM_WEAPON = 3;

var TcpLinkServer tcpServer;

var bool bGameStart;
var bool bTestGame;
var bool bTotalGoalScore;

var int numPlayer;

var int listenPort;
var int maxDuration;

/* holds the weapon parameters controlled by the genetic algorithm */
struct PWParameters{
	var float RoF;
	var float Spread;
	var float Range;
	var int MaxAmmo;
	var int ShotCost;
};

/* holds the projectile parameters controlled by the genetic algorithm */
struct PPParameters{
	var float Speed;
	var float Damage;
	var float DamageRadius;
	var float Gravity;
	var float Explosive;
};

/* map PW parameters with bots name*/
struct BotParTriple{
	var int Id;
	var string botName;
	var PWParameters weapPars;
	var PPParameters projPars;
};

/* array of weapon parameters */
var BotParTriple mapBotPar[NUM_WEAPON];

var PPParameters tempPP;
var PWParameters tempPW;

struct MapPlayerLog{
	var string PlayerName;
	var TestLog log;
};

var array<MapPlayerLog> logs;


struct BotKill
{
	var int id;
	var string name;
	var int num_kills;
	var int num_dies;
};

var array<BotKill> botStatics;

//map player name and Id with the number of weapon
struct MapPlayerWeapon{
	var int id;
	var string PlayerName;
	var int NumWeapon;
};

var array<MapPlayerWeapon> mPlayers;

//states
var int StateCurrent;

var int INITIALIZATION;
var int SIMULATION;
var int ENDGAME;

var int FinalTotalScore;

var string name_human_player;
var bool bNamePlayerFound;


//Added functionality to set the listen port of tcpServer
event InitGame( string Options, out string ErrorMessage )
{
	local string InOpt;
	local Mutator mutPW, mutNoPowerUps;
	
	super.InitGame(Options, ErrorMessage);
	
	InOpt = ParseOption( Options, "ServerListenPort");
	if( InOpt != "" )
	{
		`log("ServerListenPort"@InOpt);
		listenPort = int(InOpt);
	}
	
	InOpt = ParseOption( Options, "MaxDuration");
	if( InOpt != "" )
	{
		`log("MaxDuration"@InOpt);
		maxDuration = float(InOpt);
	}

	InOpt = ParseOption( Options, "TestGame");
	if( InOpt != "" )
	{
		`log("TestGame"@InOpt);
		bTestGame = true;
	}

	InOpt = ParseOption( Options, "TotalGoalScore");
	if( InOpt != "" )
	{
		`log("TotalGoalScore"@InOpt);
		bTotalGoalScore = true;
		FinalTotalScore = int(InOpt);
	}

	//Add Procedural Weapon Mutator -> change weapon in weapon factory and projectile as well
	mutPW = Spawn(class 'UTMutator_ProceduralWeapon');
	mutNoPowerUps = Spawn(class 'UTMutator_NoPowerups ');
	// mc, beware of mut being none
	if (mutPW != None && mutNoPowerUps != None)
	{

		if (BaseMutator == None)
		{
			BaseMutator = mutPW;
			BaseMutator.AddMutator(mutNoPowerUps);
		}
		else
		{
			BaseMutator.AddMutator(mutPW);
			BaseMutator.AddMutator(mutNoPowerUps);
		}

	}
	
}

simulated event PreBeginPlay()
{
    super.PreBeginPlay();

    if(Role == ROLE_Authority)
    {
    	tcpServer = Spawn(class'TcpLinkServer');
    
	    tcpServer.SetListenPort(listenPort);
    }

    bChangeLevels = false;

    TimeLimit = 10000;
    GoalScore = 10000;
   
}

function AddDefaultInventory( pawn Pawn ){

	local int i;

	`log("[TestGame] Call AddDefaultInventory");

	if(PWPawn(Pawn) != none && Pawn.Controller != none && Pawn.Controller.bIsPlayer)
	{
		for(i = 0; i < NUM_BOTS; i++)
		{
			if(mapBotPar[i].botName == Pawn.Controller.PlayerReplicationInfo.playername)
			{
				PWPawn(Pawn).num_weapon = mPlayers[mapBotPar[i].id].NumWeapon;
				Super.AddDefaultInventory(Pawn);
				if(PWPawn(Pawn).num_weapon > 1)
				{
					Pawn.CreateInventory(class'ProceduralWeapon2', false);
				}
			}
		}

		`log("[TestGame] Set Weapon Log of "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
		PWPawn(Pawn).SetProceduralWeapon();
	}
}

function SetInventoryLog(Pawn p, TestLog log)
{
	if(PWPawn(p) != none && ProceduralInventoryManager(p.InvManager).myLog == none)
	{
		ProceduralInventoryManager(p.InvManager).SetTestLog(log);
	}
}

function SetWeaponLog(Pawn p, Weapon w)
{
	local int i;

	for (i = 0; i < logs.length ; i++)
	{
		if (logs[i].PlayerName == p.Controller.PlayerReplicationInfo.PlayerName)
		{
			ProceduralWeapon(w).SetTestLog(logs[i].log);
			SetInventoryLog(p, logs[i].log);
			return;
		}
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn )
{
	local int i;

	Super.NotifyKilled(Killer, Killed, KilledPawn);

    SendPawnDied(killed.PlayerReplicationInfo.playername, killer.PlayerReplicationInfo.playername);

    if(!bNamePlayerFound)
    {
    	for(i = 0; i < NUM_WEAPON; ++i)
		{
			if(mapBotPar[i].botName == name_human_player)
			{
				bNamePlayerFound = true;
			}
		}

		if(!bNamePlayerFound)
		{
			name_human_player = "Player";
			bNamePlayerFound = true;
		}

    }


    if(killed.PlayerReplicationInfo.playername == name_human_player)
    {
    	ResetBotWeapon(Killed, killer, killed);
    }
    else
    {
    	ResetBotWeapon(Killer, killed, killed);
    }
}

function array<PWParameters> GetPWParameters(string botName)
{
	local int i;
	local array<PWParameters> result;
	
	for(i = 0; i < NUM_WEAPON; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			result.Add(1);
			result[result.length - 1] =  mapBotPar[i].weapPars;
		}
	}

	return result;
	
}

function array<PPParameters> GetPPParameters(string botName)
{
	local int i;
	local array<PPParameters> result;
	
	for(i = 0; i < NUM_WEAPON; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			result.Add(1);
			result[result.length - 1] =  mapBotPar[i].projPars;
		}
	}

	return result;
}

function int LevelRecommendedPlayers()
{
	return numPlayers + 1;
}

function bool TooManyBots(Controller botToRemove)
{
	if(NumBots > numPlayer)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function initializeStatistics()
{
	local Controller Aplayer;
	local int i;

	i = 0;

	StateCurrent = INITIALIZATION;

	botStatics.Remove(0, botStatics.Length);
	logs.Remove(0, logs.length);
	mPlayers.Remove(0, mPlayers.length);

	foreach WorldInfo.AllControllers(class 'Controller', Aplayer)
	{
		if (Aplayer.bIsPlayer && Aplayer.PlayerReplicationInfo != none)
		{
			botStatics.Add(1);
			botStatics[botStatics.Length - 1].name = Aplayer.PlayerReplicationInfo.playername;
			botStatics[botStatics.Length - 1].num_kills = 0;
			botStatics[botStatics.Length - 1].num_dies = 0;

			mapBotPar[i].botName = Aplayer.PlayerReplicationInfo.playername;

			logs.Add(1);

			logs[logs.length - 1].PlayerName = Aplayer.PlayerReplicationInfo.PlayerName;
			logs[logs.length - 1].log = Spawn(class 'TestLog');
			logs[logs.length - 1].log.t0 = WorldInfo.TimeSeconds;
			logs[logs.length - 1].log.PlayerName = Aplayer.PlayerReplicationInfo.PlayerName;

			mPlayers.add(1);
			mPlayers[mPlayers.length - 1].PlayerName = Aplayer.PlayerReplicationInfo.playername;
			mPlayers[mPlayers.length - 1].NumWeapon = 0;
			mPlayers[mPlayers.length - 1].id = i;

			i++;
		}
	}
}

function initializeWeaponStat(int weaponInitialized, int IDPlayer)
{
	if(weaponInitialized < NUM_BOTS)
	{
		botStatics[weaponInitialized].id = IDPlayer;
		logs[weaponInitialized].log.ID = IDPlayer;
		
		mapBotPar[weaponInitialized].Id = IDPlayer;
		mPlayers[IDPlayer].NumWeapon++;
	}
	else if(IDPlayer < mPlayers.length)
	{
		mPlayers[IDPlayer].NumWeapon++;
		mapBotPar[weaponInitialized].botName = mPlayers[IDPlayer].PlayerName;
		mapBotPar[weaponInitialized].Id = IDPlayer;
	}
}

function SendPawnDied(String killed, String killer)
{
	local int i;
	
	if(StateCurrent == SIMULATION)
	{
	
		if(killed == killer)
		{
	
			for(i = 0; i < botStatics.Length; ++i)
			{
				if(botStatics[i].name == killed)
				{
					botStatics[i].num_dies++;
				}
			}
		}
		else
		{
	
			for(i = 0; i < botStatics.Length; ++i)
			{
				if(botStatics[i].name == killer)
				{
					botStatics[i].num_kills++;
				}
		
				if(botStatics[i].name == killed)
				{
					botStatics[i].num_dies++;
				}
			}
		}

		CheckTotalFinishGame();
		
	}
}

function CheckTotalFinishGame()
{
	local int i;
	local int sum;

	sum = 0;
	
	for(i = 0; i < botStatics.Length; ++i)
	{

		sum += botStatics[i].num_kills;
	}

	if(sum >= FinalTotalScore)
	{
		StateCurrent = ENDGAME;
		ClearTimer('TimeOut');
		EndMatch();
	}
}

function TimeOut()
{
	StateCurrent = ENDGAME;
	EndMatch();	
	
}

function MatchStarted()
{
	StateCurrent = SIMULATION;
	SetTimer(MaxDuration, false, 'TimeOut');

	if(bGameStart)
	{
		ResetLevel();
	}
	else
	{
		StartMatch();
		bGameStart = true;
	}
}

function EndMatch()
{
	local int i;

	for (i = 0; i < logs.length ; i++)
	{
		logs[i].log.WriteLog("%:ID:"$botStatics[i].id$":kills:"$string(botStatics[i].num_kills)$":dies:"$string(botStatics[i].num_dies));
	}

	ConsoleCommand("Quit");
	//ResetLevel();

}

function InitGameReplicationInfo()
{
	local ProceduralGameReplicationInfo GRI;
	local int i;

	Super.InitGameReplicationInfo();

	GRI = ProceduralGameReplicationInfo(GameReplicationInfo);

	for(i = 0; i < NUM_WEAPON; ++i)
	{
		GRI.mapBotPar[i] = mapBotPar[i];
	}
}

simulated function ResetBotWeapon(Controller player, Controller bot, Controller killed)
{
	local ProceduralWeapon myWeapon;
	local array<PWParameters> weaponPars;
	local array<PPParameters> projPars;
	local int index, i;

	`log("[TestGame] ResetBotWeapon called");

	weaponPars = GetPWParameters(name_human_player);

	projPars = GetPPParameters(name_human_player);

	index = 0;

	//setting weapon of bot

	if(killed == bot)
	{
		myWeapon = ProceduralWeapon(player.Pawn.weapon);

		if(weaponPars[index].RoF == myWeapon.FireInterval[0] && weaponPars[index].Spread == myWeapon.Spread[0])
		{
			index += 1;
		}

		for(i = 0; i  < NUM_WEAPON; i++)
		{
			if(mapBotPar[i].botName != name_human_player)
			{
				mapBotPar[i].weapPars.RoF = weaponPars[index].RoF;
				mapBotPar[i].weapPars.Spread = weaponPars[index].Spread;
				mapBotPar[i].weapPars.Range = weaponPars[index].Range;
				mapBotPar[i].weapPars.MaxAmmo = weaponPars[index].MaxAmmo;
				mapBotPar[i].weapPars.ShotCost = weaponPars[index].ShotCost;

				mapBotPar[i].projPars.Speed = projPars[index].Speed;
				mapBotPar[i].projPars.Damage = projPars[index].Damage;
				mapBotPar[i].projPars.DamageRadius = projPars[index].DamageRadius;
				mapBotPar[i].projPars.Gravity = projPars[index].Gravity;
				mapBotPar[i].projPars.Explosive = projPars[index].Explosive;
			}
		}
	}
	else{

		myWeapon = ProceduralWeapon(bot.Pawn.weapon);

		index = 1;

		//proportionate ammo count
		myWeapon.AmmoCount = myWeapon.AmmoCount/myWeapon.MaxAmmoCount*weaponPars[index].MaxAmmo;

		myWeapon.Spread[0] = weaponPars[index].Spread;
		myWeapon.FireInterval[0] = weaponPars[index].RoF;
		myWeapon.MaxAmmoCount = weaponPars[index].MaxAmmo;
		myWeapon.ShotCost[0] = weaponPars[index].ShotCost;
		
		myWeapon.Spread[1] = myWeapon.Spread[0];
		myWeapon.FireInterval[1] = myWeapon.FireInterval[0];
		myWeapon.ShotCost[1] = myWeapon.ShotCost[0];

		myWeapon.SpreadDist = myWeapon.Spread[0];

		myWeapon.Gravity = projPars[index].Gravity;
		myWeapon.Speed = projPars[index].Speed;

		if(projPars[index].Gravity != 0)
		{
			myWeapon.WeaponRange = Sqrt( 2*80/Abs(projPars[index].Gravity) ) *
									projPars[index].Speed;
		}
		else{
				//Range is MaxRange on default implementation 
			if(projPars[index].Speed < 300)
			{
				myWeapon.WeaponRange = weaponPars[index].Range*
										projPars[index].Speed;
			}
			else
			{
				myWeapon.WeaponRange = weaponPars[index].Range*300;
			}

		}

		
		if(myWeapon.WeaponRange >= PWPawn(bot.Pawn).MinRangeSniping)
		{
			myWeapon.bSniping = true;
		}

		if(myWeapon.FireInterval[0] < 0.5){
			myWeapon.bFastrepeater = true;
		}

		//setting projectile of bot

		for(i = 0; i  < NUM_WEAPON; i++)
		{
			if(mapBotPar[i].botName != name_human_player)
			{
				mapBotPar[i].projPars.Speed = projPars[index].Speed;
				mapBotPar[i].projPars.Damage = projPars[index].Damage;
				mapBotPar[i].projPars.DamageRadius = projPars[index].DamageRadius;
				mapBotPar[i].projPars.Gravity = projPars[index].Gravity;
				mapBotPar[i].projPars.Explosive = projPars[index].Explosive;
			}
		}

		`log("[TestGame] Weapon: " $string(bot.Pawn.Weapon.FireInterval[0]));
	}
}

defaultproperties
{
	DefaultInventory(0)=class'ProceduralWeapon'
	DefaultInventory(1)=None
	
    DefaultPawnClass=class'PWPawn'
    
    bChangeLevels = false

    bGameStart = false
    
    numPlayer = 4

    bTestGame = false
    bTotalGoalScore = true

    FinalTotalScore = 20;

    BotClass=Class'ProceduralWeaponBot'

    MaxCustomChars = 4

    tempPW.RoF = 1
	tempPW.Spread = 1
	tempPW.Range = 1
	tempPW.MaxAmmo = 1
	tempPW.ShotCost = 1

	tempPP.Speed = 1
	tempPP.Damage = 1
	tempPP.DamageRadius = 1
	tempPP.Gravity = 0

	StateCurrent = 3;
	INITIALIZATION = 1;
	SIMULATION = 2;
	ENDGAME = 3;

	MaxDuration = 600f;

	GameReplicationInfoClass=class'ProceduralGameReplicationInfo'

	name_human_player = "Giocatore"
	bNamePlayerFound = false;
}