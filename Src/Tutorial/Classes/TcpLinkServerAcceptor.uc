/*
 * An example usage of the TcpLink class
 *  
 * By Michiel 'elmuerte' Hendriks for Epic Games, Inc.
 *  
 * You are free to use this example as you see fit, as long as you 
 * properly attribute the origin. 
 */ 
class TcpLinkServerAcceptor extends TcpLink;

var int weapInitialized;
var int projInitialized;

var int numParWeapon;
var int numParProjectile;

var bool bIsGameInitialized;

var int GoalScore;

var int StateCurrent;

//states
var int INITIALIZATION;
var int SIMULATION;
var int ENDGAME;

//Max Duration in seconds of a match
var float MaxDuration;

struct BotKill
{
	var int id;
	var string name;
	var int num_kills;
	var int num_dies;
};

var array<BotKill> botStatics;

event Accepted()
{
    `log("[TcpLinkServerAcceptor] New client connected");

    // make sure the proper mode is set
    LinkMode = MODE_Binary;
}

event ReceivedBinary(int Count , byte B[255])
{
	local string line;
	local int n;
	local int i;
	
	local float value;
	local array<string> parsedString;
	
	for( i = 0; i < Count; i++ )
	{
		n = int(B[i]);
		line $= Chr(n);
	}
	
	`log("[TcpLinkServerAcceptor] Received line: "$line);
	
	ParseStringIntoArray(line, parsedString, ":", false);
    
	for(i = 0; i < parsedString.Length; ++i){
		
		if (InStr(parsedString[i], "Init") != -1 && StateCurrent == INITIALIZATION)
		{
			Initialize();
		}
			
		if (InStr(parsedString[i], "Close") != -1)
		{
			Close();
			return;
		}

		if (InStr(parsedString[i], "Reset") != -1)
		{
			ServerGame(WorldInfo.Game).Reset();
		}
    
		if (InStr(parsedString[i], "StartMatch") != -1 && StateCurrent == INITIALIZATION)
		{
			StateCurrent = SIMULATION;
			SetTimer(MaxDuration, false, 'TimeOut');
			
			if(ServerGame(WorldInfo.Game).bGameStart)
			{
				//ServerGame(WorldInfo.Game).RestartGame();
				ServerGame(WorldInfo.Game).ResetLevel();
			}
			else
			{
				ServerGame(WorldInfo.Game).StartMatch();
				ServerGame(WorldInfo.Game).bGameStart = true;
			}
		}

		//Initialize weapon parameter of bots
		if (InStr(parsedString[i], "WeaponPar") != -1 && weapInitialized < ServerGame(WorldInfo.Game).mapBotPar.Length 
		    && StateCurrent == INITIALIZATION)
		{
			if(i + numParWeapon*2 < parsedString.Length)
			{
				ModifyWeapon(parsedString, i + 1);
				i += numParWeapon*2;
			}
			
			weapInitialized++;
		}

		if (InStr(parsedString[i], "ProjectilePar") != -1 && projInitialized < ServerGame(WorldInfo.Game).mapBotPar.Length 
		    && StateCurrent == INITIALIZATION)
		{
			if(i + numParProjectile*2 < parsedString.Length)
			{
				ModifyProjectile(parsedString, i + 1);
				i += numParProjectile*2;
			}
			
			projInitialized++;
		}
		
	}
   
    
   
}

//Initialize bot structure
function Initialize()
{
	
	local AIController Aplayer;
	
	`log("[TcpLinkServerAcceptor] initialize");
	
	botStatics.Remove(0, botStatics.Length);
	
	weapInitialized = 0;
	projInitialized = 0;
	
	if(ServerGame(WorldInfo.Game).mapBotPar.Length != 0)
	{
		bIsGameInitialized = true;
	}	
	
	foreach WorldInfo.AllControllers(class'AIController', Aplayer)
	{
		if (Aplayer.bIsPlayer && Aplayer.PlayerReplicationInfo != none && Aplayer.PlayerReplicationInfo.playername != "")
		{
			botStatics.Add(1);
			botStatics[botStatics.Length - 1].name =  Aplayer.PlayerReplicationInfo.playername;
			botStatics[botStatics.Length - 1].num_kills = 0;
			botStatics[botStatics.Length - 1].num_dies = 0;

			//TODO rewrite in more elegant way
			if(!bIsGameInitialized)
			{
				ServerGame(WorldInfo.Game).mapBotPar.Add(1);
				ServerGame(WorldInfo.Game).mapBotPar[ServerGame(WorldInfo.Game).mapBotPar.Length - 1].botName = Aplayer.PlayerReplicationInfo.playername;
			}
		
			`log("[TcpLinkServerAcceptor] initialize bot "$botStatics[botStatics.Length - 1].name);
		}
	}
}

// Modify weapon of bots (and player)
function ModifyWeapon(array<string> WeaponPar, int index)
{
	local int i;
	local float val;
	
	local string par;
	
	
	for(i = index; i < index + numParWeapon*2; ++i)
	{
		par = WeaponPar[i];
		val = float(WeaponPar[i + 1]);
		
		`log("[TcpLinkServerAcceptor] set "$par$" "$string(val)$" "$string(weapInitialized));
		
		if (par ~= "ID")
		{
			botStatics[weapInitialized].id = val;
		} 
		else if (par ~= "RoF")
		{
			ServerGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.RoF = val;
		}
		else if (par ~= "Spread")
		{
			ServerGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.Spread = val;
		}
		else if (par ~= "Range")
		{
			ServerGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.Range = val;
		}
		else if (par ~= "MaxAmmo")
		{
			ServerGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.MaxAmmo = val;
		}
		else if (par ~= "ShotCost")
		{
			ServerGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.ShotCost = val;
		}
		
		++i;
	}	
	
}

// Modify weapon of bots (and player)
function ModifyProjectile(array<string> ProjectilePar, int index)
{
	local int i;
	local float val;
	
	local string par;
	
	
	for(i = index; i < index + numParProjectile*2; ++i)
	{
		par = ProjectilePar[i];
		val = float(ProjectilePar[i + 1]);
		
		`log("[TcpLinkServerAcceptor] set "$par$" "$string(val)$" "$string(projInitialized));
		
		if (par ~= "Speed")
		{
			ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Speed = val;
		}
		else if (par ~= "Damage")
		{
			ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Damage = val;
		}
		else if (par ~= "DamageRadius")
		{
			ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.DamageRadius = val;
		}
		else if (par ~= "Gravity")
		{
			ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Gravity = val;
		}
		
		++i;
	}	
	
}

function SendPawnDied(Controller killed, Controller killer)
{
	local int i;
	local string line;
	local byte B[255];
	
	if(StateCurrent == SIMULATION && killed.PlayerReplicationInfo.playername != "Player")
	{
	
		`log("[TcpLinkServerAcceptor] SendPawnDied called");
	
		if(killer == none)
		{
			killer = killed;
		}
	
	
		if (killed.bIsPlayer)
		{
			if(killer == none || killed.PlayerReplicationInfo.playername == killer.PlayerReplicationInfo.playername)
			{
				line = "Player died "$killed.PlayerReplicationInfo.playername$" Suicide";
				`log("[TcpLinkServerAcceptor] "$line);
		
				for(i = 0; i < botStatics.Length; ++i)
				{
					if(botStatics[i].name == killed.PlayerReplicationInfo.playername)
					{
						botStatics[i].num_dies++;
					}
				}
			}
			else
			{
				line = "Player died "$killed.PlayerReplicationInfo.playername$" Killer: "$killer.PlayerReplicationInfo.playername;
			
				`log("[TcpLinkServerAcceptor] "$line);
		
				for(i = 0; i < botStatics.Length; ++i)
				{
					if(botStatics[i].name == killer.PlayerReplicationInfo.playername)
					{
						botStatics[i].num_kills++;
					}
			
					if(botStatics[i].name == killed.PlayerReplicationInfo.playername)
					{
						botStatics[i].num_dies++;
					}
				}
			}
		}
	
		CheckFinishGame();
	}
}

function CheckFinishGame()
{
	local int i;
	
	for(i = 0; i < botStatics.Length; ++i)
	{
		if(botStatics[i].num_kills >= GoalScore)
		{
			StateCurrent = ENDGAME;
			ClearTimer('TimeOut');
			FinishGame();
			return;
		}
	}
}

//if the match is too long, time out will call finishgame
function TimeOut()
{
	StateCurrent = ENDGAME;
	FinishGame();	
	
}

//Send to client bot statics of the last match
function FinishGame()
{
	local string line;
	local int i, j;
	local byte B[255];
	
	`log("[TcpLinkServerAcceptor] EndGame called");
	
	
	for(i = 0; i < botStatics.Length; ++i)
	{
		line = "%:ID:"$botStatics[i].id$":kills:"$string(botStatics[i].num_kills)$":dies:"$string(botStatics[i].num_dies);

		`log("[TcpLinkServerAcceptor] "$line);
		
		for(j = 0; j < Len(line); ++j){
			B[j] = byte(Asc(Right(Left(line, j+1), 1)));
		}
		
		SendBinary(Len(line), B);
	}
	
	line = "%End";
	
	for(j = 0; j < Len(line); ++j){
		B[j] = byte(Asc(Right(Left(line, j+1), 1)));
	}
	
	SendBinary(Len(line), B);

	
}

event Closed()
{
    `Log("[TcpLinkServerAcceptor] Connection closed");
    // It's important to destroy the object so that the parent knows
    // about it and can handle the closed connection. You can not
    // reuse acceptor instances.
 	Destroy();
}

function SetMaxDuration(float time)
{
	`Log("[TcpLinkServerAcceptor] SetMaxDuration"$string(time));
	MaxDuration = time;
}

defaultproperties
{
	weapInitialized = 0;
	projInitialized = 0;
	numParWeapon = 5;
	numParProjectile = 4;
	
	bIsGameInitialized = false;
	
	GoalScore = 10;
	
	StateCurrent = 1;
	INITIALIZATION = 1;
	SIMULATION = 2;
	ENDGAME = 3;
	
	MaxDuration = 3600f;
}
