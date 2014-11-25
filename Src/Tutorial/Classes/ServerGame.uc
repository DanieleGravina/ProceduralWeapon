class ServerGame extends UTGame;

var OnlineService service;
var int ScoreGoal;

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

var array<BotParTriple> mapBotPar;

event PreBeginPlay()
{
    super.PreBeginPlay();
    service = Spawn(class'OnlineService');
    service.Initialize();
    
    GoalScore = 1000;
    //SetGameSpeed(20);
}

function AddDefaultInventory( pawn Pawn ){
	Super.AddDefaultInventory(Pawn);
	
	`log("[ServerGame] Add default inventory to "$Pawn.Controller.PlayerReplicationInfo.PlayerName);
	
	if(PWPawn(Pawn) != none && Pawn.Controller.bIsPlayer)
	{
		PWPawn(Pawn).SetProceduralWeapon();
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn, damageType);
	
	service.SendPawnDied(killed, killer);
}

/*function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
	local bool result;
	
	result = Super.CheckEndGame(Winner, Reason);
	service.CheckEndGame();
	`log("[ServerGame] CheckEndGame called");
	
	Reset();
	
	return false;
}*/

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
}

defaultproperties
{
	DefaultInventory(0)=class'ProceduralWeapon'
    DefaultInventory(1)=none
    DefaultPawnClass=class'PWPawn'
    
    ScoreGoal = 1;
}