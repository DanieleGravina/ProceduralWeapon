class TestGame extends UTDeathmatch;

const NUM_BOTS = 2;
const NUM_WEAPON = 4;

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


//Added functionality to set the listen port of tcpServer
event InitGame( string Options, out string ErrorMessage )
{
	local string InOpt;
	
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
	Super.NotifyKilled(Killer, Killed, KilledPawn);

    SendPawnDied(killed.PlayerReplicationInfo.playername, killer.PlayerReplicationInfo.playername);
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

    tempPW.RoF = 0
	tempPW.Spread = 0
	tempPW.Range = 0
	tempPW.MaxAmmo = 0
	tempPW.ShotCost = 0

	tempPP.Speed = 0
	tempPP.Damage = 0
	tempPP.DamageRadius = 0
	tempPP.Gravity = 0

	StateCurrent = 3;
	INITIALIZATION = 1;
	SIMULATION = 2;
	ENDGAME = 3;

	MaxDuration = 600f;

	GameReplicationInfoClass=class'ProceduralGameReplicationInfo'
}