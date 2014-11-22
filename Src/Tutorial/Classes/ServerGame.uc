class ServerGame extends UTGame;

var OnlineService service;

var float RoF;

event PreBeginPlay()
{
    super.PreBeginPlay();
    service = Spawn(class'OnlineService');
    service.Initialize(self);
    
    SetGameSpeed(30);
    GoalScore = 25;
}

function AddDefaultInventory( pawn PlayerPawn ){
	Super.AddDefaultInventory(PlayerPawn);
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn, damageType);
	
	service.SendPawnDied(killed, killer);
}

function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
	local bool result;
	
	result = Super.CheckEndGame(Winner, Reason);
	
	if(result)
	{
		service.SendEndGame();
		`log("[ServerGame] EndGame called");
	}
	
	return result;
}

defaultproperties
{
	DefaultInventory(0)=class'UTWeap_ShockRifle'
    DefaultInventory(1)=none
    DefaultPawnClass=class'UTPawn'
}