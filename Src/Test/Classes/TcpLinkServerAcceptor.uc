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

//states
var int StateCurrent;

var int INITIALIZATION;
var int SIMULATION;
var int ENDGAME;

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
			TestGame(WorldInfo.Game).Reset();
		}

		if (InStr(parsedString[i], "GameSpeed") != -1 && StateCurrent == INITIALIZATION)
		{
			WorldInfo.Game.SetGameSpeed( float(parsedString[i + 1]) );

			i += 1;
		}

    
		if (InStr(parsedString[i], "StartMatch") != -1 && StateCurrent == INITIALIZATION)
		{
			StateCurrent = SIMULATION;
			TestGame(WorldInfo.Game).MatchStarted();
		}

		//Initialize weapon parameter of bots
		if (InStr(parsedString[i], "WeaponPar") != -1 && weapInitialized < TestGame(WorldInfo.Game).NUM_BOTS 
		    && StateCurrent == INITIALIZATION)
		{
			if(i + numParWeapon*2 < parsedString.Length)
			{
				ModifyWeapon(parsedString, i + 1);
				i += numParWeapon*2;
			}
			
			weapInitialized++;
		}

		if (InStr(parsedString[i], "ProjectilePar") != -1 && projInitialized < TestGame(WorldInfo.Game).NUM_BOTS 
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
	
	`log("[TcpLinkServerAcceptor] initialize");
	
	weapInitialized = 0;
	projInitialized = 0;
	
	TestGame(WorldInfo.Game).initializeStatistics();
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
			TestGame(WorldInfo.Game).initializeWeaponStat(weapInitialized, val);
		} 
		else if (par ~= "RoF")
		{
			TestGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.RoF = val;
		}
		else if (par ~= "Spread")
		{
			TestGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.Spread = val;
		}
		else if (par ~= "Range")
		{
			TestGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.Range = val;
		}
		else if (par ~= "MaxAmmo")
		{
			TestGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.MaxAmmo = val;
		}
		else if (par ~= "ShotCost")
		{
			TestGame(WorldInfo.Game).mapBotPar[weapInitialized].weapPars.ShotCost = val;
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
			TestGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Speed = val;
		}
		else if (par ~= "Damage")
		{
			TestGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Damage = val;
		}
		else if (par ~= "DamageRadius")
		{
			TestGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.DamageRadius = val;
		}
		else if (par ~= "Gravity")
		{
			TestGame(WorldInfo.Game).mapBotPar[projInitialized].projPars.Gravity = val;
		}
		
		++i;
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

defaultproperties
{
	weapInitialized = 0;
	projInitialized = 0;
	numParWeapon = 5;
	numParProjectile = 4;

	StateCurrent = 1;
	INITIALIZATION = 1;
	SIMULATION = 2;
	ENDGAME = 3;
}
