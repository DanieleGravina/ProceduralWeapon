class OnlineService extends Actor;

//Reference to Game Class
var ServerGame game;

var ProceduralWeapon procWeap;

var TcpLinkServer tcpServer;
var TcpLinkServerAcceptor tcpAcceptor;


function Initialize(ServerGame sg)
{
    game = sg;
    tcpServer = Spawn(class'TcpLinkServer');
}

function AddPawn(Pawn newPawn){
	`log("[OnlineServer] AddPawn");
	tcpServer.addPawn(newPawn);
}

function SendPawnDied(Controller killed, Controller killer)
{
	tcpServer.SendPawnDied(killed, killer);
}

defaultproperties
{
}