class ServerGame extends UTDeathmatch;

var TcpLinkServer tcpServer;

var bool bGameStart;
var bool bTestGame;

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
		
		if( Pawn.IsHumanControlled() )
		{
			Pawn.CreateInventory(class'ProceduralWeapon',true);
		}
		
		if(PWPawn(Pawn) != none && Pawn.Controller != none && Pawn.Controller.bIsPlayer)
		{
			`log("[ServerGame] Add default inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
			PWPawn(Pawn).SetProceduralWeapon();
		}
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn);
	
	tcpServer.SendPawnDied(killed, killer);
}

function PWParameters GetPWParameters(string botName)
{
	local int i;
	
	for(i = 0; i < mapBotPar.Length; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			return mapBotPar[i].weapPars;
		}
	}

	return mapBotPar[0].weapPars;
	
}

function PPParameters GetPPParameters(string botName)
{
	local int i;
	
	for(i = 0; i < mapBotPar.Length; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			return mapBotPar[i].projPars;
		}
	}	
	
	return mapBotPar[0].projPars;
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
}