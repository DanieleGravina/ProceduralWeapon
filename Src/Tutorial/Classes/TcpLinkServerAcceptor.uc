/*
 * An example usage of the TcpLink class
 *  
 * By Michiel 'elmuerte' Hendriks for Epic Games, Inc.
 *  
 * You are free to use this example as you see fit, as long as you 
 * properly attribute the origin. 
 */ 
class TcpLinkServerAcceptor extends TcpLink;

var ProceduralWeapon procWeapon;

var array<Pawn> pawns;

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
			
		}
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
			
		for(i = 0; i < Len(line); ++i){
			B[i] = byte(Asc(Right(Left(line, i+1), 1)));
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
