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
	`log("[TcpLinkServerAcceptor] pawns added");
	pawns = p;
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
	
	local Pawn p;
	
	for( i = 0; i < Count; i++ )
	{
		n = int(B[i]);
		line $= Chr(n);
	}
	
	`log("[TcpLinkServerAcceptor] Received line: "$line);
    if (line ~= "close")
    {
        SendText("Closing by request");
        Close();
        return;
    }
    //SendText(line);
    
    ParseStringIntoArray(line, parsedString, ":", false);
    
    for(i = 0; i < parsedString.Length - 1; i += 2){
    	ModifyWeapon(parsedString[i], parsedString[i+1]);
    }
    
   
}

function ModifyWeapon(string WeaponElement, string Value)
{
	local int i;
	
	for(i = 0; i < pawns.Length; ++i){
        	if(pawns[i] != none && pawns[i].Weapon != none){
	            `log("[TcpLinkServerAcceptor] change "$WeaponElement$" pawn: "$string(i));
        		if (WeaponElement ~= "RoF")
				{
					ModifyRoF(Value, pawns[i]);
				}
				else if (WeaponElement ~= "Spread")
				{
					ModifySpread(Value, pawns[i]);
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

function SendPawnDied(Pawn diedPawn, Controller Killer)
{
	local int i, j, k;
	local string line;
	local byte B[255];
	
	for(i = 0; i < pawns.Length; ++i){
		if(pawns[i] == Killer.Pawn)
		{
			k = i;
		}
	}
	
	for(i = 0; i < pawns.Length; ++i){
		if(pawns[i] == diedPawn)
		{
			line = "pawn died "$string(i)$" Killer: "$string(k);
			
			for(j = 0; j < Len(line); ++j){
				B[j] = byte(Asc(Right(Left(line, j+1), 1)));
			}
			
			SendBinary(Len(line), B);
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
