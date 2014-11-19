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

defaultproperties
{
	DefaultInventory(0)=class'ProceduralWeapon'
    DefaultInventory(1)=none
    DefaultPawnClass=class'TutorialPawn'
}