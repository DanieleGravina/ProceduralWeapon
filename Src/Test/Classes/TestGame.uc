class TestGame extends UTDeathmatch;

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
var array<BotParTriple> mapBotPar;

var PPParameters tempPP;
var PWParameters tempPW;

struct MapPlayerLog{
	string PlayerName;
	TestLog log;
};

var array<MapPlayerLog> logs;

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
	}
	
}

event PreBeginPlay()
{
    super.PreBeginPlay();
    
    tcpServer = Spawn(class'TcpLinkServer');
    
    tcpServer.SetListenPort(listenPort);
    tcpServer.SetMaxDuration(maxDuration);

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
			for(i = 0; i < mapBotPar.length; ++i)
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
		ProceduralInventoryManager(p.InvManager).SetTestLog(log)
	}
}

function SetWeaponLog(Pawn p)
{
	local int i;

	for (i = 0; i < logs.length ; i++)
	{
		if (logs[i].PlayerName == Pawn.Controller.PlayerReplicationInfo.PlayerName)
		{
			ProceduralWeapon(Pawn.Weapon).SetTestLog(logs[i].log)
			SetInventoryLog(p, logs[i].log)
			return
		}
	}

	logs.Add(1)

	logs[logs.length - 1].PlayerName = Pawn.Controller.PlayerReplicationInfo.PlayerName
	logs[logs.length - 1].log = Spawn(TestLog)

	ProceduralWeapon(Pawn.Weapon).SetTestLog(logs[logs.length - 1].log)
	SetInventoryLog(p, logs[logs.length - 1].log)

}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn);
	
	tcpServer.SendPawnDied(killed, killer);
}

function SetPWParameters(string botName)
{
	local int i;
	
	for(i = 0; i < mapBotPar.Length; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPW =  mapBotPar[i].weapPars;
			break;
		}
	}
	
}

function SetPPParameters(string botName)
{
	local int i;
	
	for(i = 0; i < mapBotPar.Length; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPP = mapBotPar[i].projPars;
			break;
		}
	}	
	
}

function PWParameters GetPWParameters()
{
	return tempPW;
}

function PPParameters GetPPParameters()
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

defaultproperties
{
	DefaultInventory(0)=class'ProceduralWeapon'
	DefaultInventory(1)=None
	
    DefaultPawnClass=class'PWPawn'
    
    bChangeLevels = false

    bGameStart = false
    
    numPlayer = 4

    bTestGame = false
    bTotalGoalScore = false

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
}