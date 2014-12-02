class ServerGame extends UTGame;

var TcpLinkServer tcpServer;

var bool bGameStart;

var int numPlayers;

var int listenPort;

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
	
}

event PreBeginPlay()
{
    super.PreBeginPlay();
    
    tcpServer = Spawn(class'TcpLinkServer');
    
    tcpServer.SetListenPort(listenPort);
    
    SetGameSpeed(60);
}

function AddDefaultInventory( pawn Pawn ){
	Super.AddDefaultInventory(Pawn);
	
	`log("[ServerGame] Add default inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
	
	if(PWPawn(Pawn) != none && Pawn.Controller != none && Pawn.Controller.bIsPlayer)
	{
		PWPawn(Pawn).SetProceduralWeapon();
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn, damageType);
	
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
	if(NumBots > numPlayers)
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
    DefaultInventory(1)=none
    DefaultPawnClass=class'PWPawn'
    
    bChangeLevels = false

    bGameStart = false
    
    numPlayers = 2
}