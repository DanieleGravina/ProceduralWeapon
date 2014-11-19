class ServerGame extends UTGame;

var OnlineService service;

var float RoF;

event PreBeginPlay()
{
    super.PreBeginPlay();
    service = Spawn(class'OnlineService');
    service.Initialize(self);
}

function AddDefaultInventory( pawn PlayerPawn ){
	Super.AddDefaultInventory(PlayerPawn);
	
	if(TutorialPawn(PlayerPawn) != none){
		`log("[ServerGame] SendPawn to TcpLinkServer");
		TutorialPawn(PlayerPawn).SendPawnToOnlineService(service);
		
	} 
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
	Super.NotifyKilled(Killer, Killed, KilledPawn, damageType);
	
	service.SendPawnDied(killed, killer);
}

defaultproperties
{
	DefaultInventory(0)=class'MyWeapon_PoisonDamage'
    DefaultInventory(1)=none
    DefaultPawnClass=class'TutorialPawn'
}