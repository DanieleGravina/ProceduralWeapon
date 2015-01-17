class TestGame extends UTDeathmatch;

const NUM_BOTS = 2;

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
};

/* map PW parameters with bots name*/
struct BotParTriple{
	var string botName;
	var PWParameters weapPars;
	var PPParameters projPars;
};

/* array of weapon parameters */
var BotParTriple mapBotPar[NUM_BOTS];

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

event PreBeginPlay()
{
    super.PreBeginPlay();

    if(Role == ROLE_Authority)
    {
    	tcpServer = Spawn(class'TcpLinkServer');
    
	    tcpServer.SetListenPort(listenPort);
    }

    bChangeLevels = false;

    TimeLimit = 1000;
    GoalScore = 1000;
   
}

function AddDefaultInventory( pawn Pawn ){

	local int i;

	if(bTestGame)
	{

		if(PWPawn(Pawn) != none && Pawn.Controller != none && Pawn.Controller.bIsPlayer)
		{
			for(i = 0; i < NUM_BOTS; ++i)
			{
				if(mapBotPar[i].botName == Pawn.Controller.PlayerReplicationInfo.PlayerName)
				{
					switch (i)
					{
						case 0:
							
							DefaultInventory[0] = class 'ProceduralSniper';
							`log("[TestGame] Add SniperRifle inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
							break;
					
						case 1:
							DefaultInventory[0]  = class 'ProceduralFlak';
							`log("[TestGame] Add ShockRifle inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
							break;

						case 2:
							DefaultInventory[0]  = class 'ProceduralRocketLauncher';
							`log("[TestGame] Add Flak inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
							break;

						case 3:
							DefaultInventory[0]  = class 'ProceduralShockRifle';
							`log("[TestGame] Add Rocket inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
							break;
							
					
						default:
							DefaultInventory[0] = class 'UTWeap_SniperRifle';
							break;
							
					}
				}
			}
		}

		Super.AddDefaultInventory(Pawn);

	}
	else
	{
		Super.AddDefaultInventory(Pawn);
		
		if(PWPawn(Pawn) != none && Pawn.Controller != none && Pawn.Controller.bIsPlayer)
		{
			`log("[ServerGame] Add default inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
			PWPawn(Pawn).SetProceduralWeapon();
			SetWeaponLog(Pawn);
		}
	}
}

function SetInventoryLog(Pawn p, TestLog log)
{
	if(PWPawn(p) != none)
	{
		ProceduralInventoryManager(p.InvManager).SetTestLog(log);
	}
}

function SetWeaponLog(Pawn p)
{
	local int i;

	for (i = 0; i < logs.length ; i++)
	{
		if (logs[i].PlayerName == p.Controller.PlayerReplicationInfo.PlayerName)
		{
			ProceduralWeapon(p.Weapon).SetTestLog(logs[i].log);
			SetInventoryLog(p, logs[i].log);
			return;
		}
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn);

    //SendPawnDied(killed, killer);
}

simulated function SetPWParameters(string botName)
{
	local int i;
	
	for(i = 0; i < NUM_BOTS; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPW =  mapBotPar[i].weapPars;
			break;
		}
	}
	
}

simulated function SetPPParameters(string botName)
{
	local int i;
	
	for(i = 0; i < NUM_BOTS; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPP = mapBotPar[i].projPars;
			break;
		}
	}	
	
}

simulated function PWParameters GetPWParameters()
{
	return tempPW;
}

simulated function PPParameters GetPPParameters()
{
	return tempPP;
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

	if(StateCurrent == ENDGAME)
	{
		StateCurrent = INITIALIZATION;

		botStatics.Remove(0, botStatics.Length);
		logs.Remove(0, logs.length);

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

				i++;
			}
		}
	}
}

function initializeWeaponStat(int weaponID, int val)
{
	botStatics[weaponID].id = val;
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

}

replication
{
  // Variables the server should send ALL clients.
  if (bNetDirty && Role == ROLE_Authority)
  mapBotPar;

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

    FinalTotalScore = 2;

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
}