/*
 * An example usage of the TcpLink class
 *  
 * By Michiel 'elmuerte' Hendriks for Epic Games, Inc.
 *  
 * You are free to use this example as you see fit, as long as you 
 * properly attribute the origin. 
 */ 
class TcpLinkServerAcceptor extends TcpLink;

struct BotKill
{
	var string name;
	var int num_kills;
	var int num_dies;
};

var array<BotKill> botStatics;


function Initialize(array<Pawn> p){
	//`log("[TcpLinkServerAcceptor] pawns added");
	//pawns = p;
}

event Accepted()
{
    `log("[TcpLinkServerAcceptor] New client connected");
    // make sure the proper mode is set
    LinkMode=MODE_Binary;
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
			
		if (InStr(parsedString[i], "close") != -1)
		{
			SendText("Closing by request");
			Close();
			return;
		}
    
		if (InStr(parsedString[i], "StartMatch") != -1)
		{
			WorldInfo.Game.StartMatch();
		}

		if (InStr(parsedString[i], "Spread") != -1 || InStr(parsedString[i], "RoF") != -1)
		{
			if(i + 1 < parsedString.Length)
			{
				ModifyWeapon(parsedString[i], parsedString[i+1]);
				i++;
			}
		}
		
	}
   
    
   
}

// Modify weapon of bots (and player)
function ModifyWeapon(string WeaponElement, string Value)
{
	local int i;
	local Controller Aplayer;
	
	local string line;
	local bool found;
	
	foreach WorldInfo.AllControllers(class'Controller', Aplayer)
	{
		if (Aplayer.bIsPlayer && Aplayer.Pawn != none && Aplayer.Pawn.Weapon != none)
		{
			
			`log("[TcpLinkServerAcceptor] change "$WeaponElement$" "$Value$" pawn: "$Aplayer.PlayerReplicationInfo.playername);
        	if (WeaponElement ~= "RoF")
			{
				ModifyRoF(Value, Aplayer.Pawn);
			}
			else if (WeaponElement ~= "Spread")
			{
				ModifySpread(Value, Aplayer.Pawn);
			}

			found = false;
			
			for(i = 0; i < botStatics.Length; ++i)
			{
				if(botStatics[i].name == Aplayer.PlayerReplicationInfo.playername){
					found = true;
				}
			}
			
			if(!found){
				botStatics.Add(1);
			
				botStatics[botStatics.Length - 1].name = Aplayer.PlayerReplicationInfo.playername;
				botStatics[botStatics.Length - 1].num_kills = 0;
				botStatics[botStatics.Length - 1].num_dies = 0;
			}
			
		}
	}
	
	for(i = 0; i < botStatics.Length; ++i)
	{
		line = botStatics[i].name$" "$string(botStatics[i].num_kills)$" "$string(botStatics[i].num_dies);

		`log("[TcpLinkServerAcceptor] "$line);
	}
}

function ModifyRoF(string Value, Pawn p)
{
	local float val;
	
	if(float(Value) != 0){
		val =  float(Value);
	}
	else
	{
		val = 0.5;
	}
	
	p.Weapon.FireInterval[0] = val;
}

function ModifySpread(string Value, Pawn p)
{
	local float val;
	
	if(float(Value) != 0){
		val =  float(Value);
	}
	else
	{
		val = 0.5;
	}
	
	p.Weapon.Spread[0] = val;
}

function SendPawnDied(Controller killed, Controller killer)
{
	local int i;
	local string line;
	local byte B[255];
	
	`log("[TcpLinkServerAcceptor] SendPawnDied called");
	
	
	if (killed.bIsPlayer)
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

//Send to client bot statics of the last match
function SendEndGame()
{
	local string line;
	local int i, j;
	local byte B[255];
	
	`log("[TcpLinkServerAcceptor] EndGame called");
	
	
	for(i = 0; i < botStatics.Length; ++i)
	{
		line = botStatics[i].name$" "$string(botStatics[i].num_kills)$" "$string(botStatics[i].num_dies);

		`log("[TcpLinkServerAcceptor] "$line);
		
		for(j = 0; j < Len(line); ++j){
			B[j] = byte(Asc(Right(Left(line, j+1), 1)));
		}
		
		SendBinary(Len(line), B);
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
