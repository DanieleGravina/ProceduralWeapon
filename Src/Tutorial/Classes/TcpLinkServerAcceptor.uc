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
var bool bTestKillsVsTime;

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
	var array<float> distance_kill;
	var array<float> time_kill;
	var int last_kill_streak;
	var array<int> kill_streak;
};

var array<BotKill> botStatics;

event Accepted()
{
    `log("[TcpLinkServerAcceptor] New client connected");

    // make sure the proper mode is set
    LinkMode = MODE_Text;
}

event ReceivedText( string Text )
{
	local int i;
	
	local array<string> parsedString;

	`log("[TcpLinkServerAcceptor] Received line: "$Text);
	
	ParseStringIntoArray(Text, parsedString, ":", false);
    
	for(i = 0; i < parsedString.Length; ++i){
		
		if (InStr(parsedString[i], "Init") != -1 && StateCurrent == INITIALIZATION)
		{
			Initialize();
		}

		if (InStr(parsedString[i], "Crash") != -1)
		{
			for (i = 0; i != -1 ; i++)
			{
				
			}
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

		if (InStr(parsedString[i], "GameSpeed") != -1 && StateCurrent == INITIALIZATION)
		{
			WorldInfo.Game.SetGameSpeed( float(parsedString[i + 1]) );

			i += 1;
		}

		if (InStr(parsedString[i], "TestKillsVsTime") != -1 && StateCurrent == INITIALIZATION)
		{
			bTestKillsVsTime = true;
		}

		if (InStr(parsedString[i], "GoalScore") != -1 && StateCurrent == INITIALIZATION)
		{
			GoalScore = int(parsedString[i + 1]);

			i += 1;
		}

		if (InStr(parsedString[i], "MaxDuration") != -1 && StateCurrent == INITIALIZATION)
		{
			MaxDuration = int(parsedString[i + 1]);

			if(MaxDuration < 0)
			{
				MaxDuration = 1;
			}

			`log("[TcpLinkServerAcceptor] set MaxDuration "$string(MaxDuration));

			i += 1;
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
	
	local Controller Aplayer;
	
	`log("[TcpLinkServerAcceptor] initialize");
	
	botStatics.Remove(0, botStatics.Length);
	
	weapInitialized = 0;
	projInitialized = 0;
	
	if(ServerGame(WorldInfo.Game).mapBotPar.Length != 0)
	{
		bIsGameInitialized = true;
	}	
	
	foreach WorldInfo.AllControllers(class 'Controller', Aplayer)
	{
		if (Aplayer.bIsPlayer && Aplayer.PlayerReplicationInfo != none)
		{
			botStatics.Add(1);
			botStatics[botStatics.Length - 1].name =  Aplayer.PlayerReplicationInfo.playername;
			botStatics[botStatics.Length - 1].num_kills = 0;
			botStatics[botStatics.Length - 1].num_dies = 0;
			botStatics[botStatics.Length - 1].last_kill_streak = 0;

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
	
	for(i = index; i < index + (numParWeapon + 1)*2; ++i)
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
		else if (par ~= "Explosive")
		{
			ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Explosive = val;
		}
		
		++i;
	}

	ServerGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Bounce = false;	
	
}

function SendPawnDied(Controller killed, Controller killer)
{
	local int i;
	local string line;
	
	if(StateCurrent == SIMULATION)
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

						if(botStatics[i].last_kill_streak > 0)
						{
							botStatics[i].kill_streak.Add(1);
							botStatics[i].kill_streak[botStatics[i].kill_streak.length - 1] = botStatics[i].last_kill_streak;
						}

						botStatics[i].last_kill_streak = 0;

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
						botStatics[i].last_kill_streak++;

					}
			
					if(botStatics[i].name == killed.PlayerReplicationInfo.playername)
					{
						botStatics[i].num_dies++;

						if(botStatics[i].last_kill_streak > 0)
						{
							botStatics[i].kill_streak.Add(1);
							botStatics[i].kill_streak[botStatics[i].kill_streak.length - 1] = botStatics[i].last_kill_streak;
						}

						botStatics[i].last_kill_streak = 0;


					}
				}
			}
		}

		if(bTestKillsVsTime || ServerGame(WorldInfo.Game).bTotalGoalScore)
		{
			CheckTotalFinishGame();
		}
		else
		{
			CheckFinishGame();
			
		}
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

	if(sum >= GoalScore)
	{
		StateCurrent = ENDGAME;
		ClearTimer('TimeOut');
		FinishGame();
		return;
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
	//avarage distance of kill & avarage delta time fire-kill
	local float avg_dist, avg_time, avg_kill_streak;

	avg_dist = 0.0;
	avg_time = 0.0;
	avg_kill_streak = 0.0;
	
	`log("[TcpLinkServerAcceptor] EndGame called");
	
	
	for(i = 0; i < botStatics.Length; ++i)
	{
		line = "%:ID:"$botStatics[i].id$":kills:"$string(botStatics[i].num_kills)$":dies:"$string(botStatics[i].num_dies);

		for(j = 0; j < botStatics[i].time_kill.length; j++)
		{
			avg_time += botStatics[i].time_kill[j];
		}

		if(botStatics[i].time_kill.length != 0)
		{
			avg_time /= botStatics[i].time_kill.length;
		}
		else
		{
			avg_time = 0;
		}

		for(j = 0; j < botStatics[i].distance_kill.length; j++)
		{
			avg_dist += botStatics[i].distance_kill[j];
		}

		if(botStatics[i].distance_kill.length != 0)
		{
			avg_dist /= botStatics[i].distance_kill.length;
		}
		else
		{
			avg_dist = 0;
		}

		line $= ":avg_time:" $ string(avg_time) $ ":avg_dist:" $ string(avg_dist);

		for(j = 0; j < botStatics[i].kill_streak.length; j++)
		{
			avg_kill_streak += botStatics[i].kill_streak[j];
		}

		if(botStatics[i].kill_streak.length != 0)
		{
			avg_kill_streak /= botStatics[i].kill_streak.length;
		}
		else
		{
			avg_kill_streak = 0;
		}

		line $= ":kill_streak:" $ string(avg_kill_streak);

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

function SetStatKill(string player_name, float delta_time, float distance)
{
	local int i;

	for(i = 0; i < botStatics.Length; ++i)
	{
		if(botStatics[i].name == player_name)
		{
			botStatics[i].time_kill.Add(1);
			botStatics[i].time_kill[botStatics[i].time_kill.length - 1] = delta_time;

			//`log("[TcpLinkServerAcceptor] " $ player_name $" " $ string(delta_time)$" "$string(distance));

			botStatics[i].distance_kill.Add(1);
			botStatics[i].distance_kill[botStatics[i].distance_kill.length - 1] = distance;
		}
	}
	
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
	numParProjectile = 5;
	
	bIsGameInitialized = false;
	bTestKillsVsTime = false;
	
	GoalScore = 100;
	
	StateCurrent = 1;
	INITIALIZATION = 1;
	SIMULATION = 2;
	ENDGAME = 3;
	
	MaxDuration = 3600f;
}
