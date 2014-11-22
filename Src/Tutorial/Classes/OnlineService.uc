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

function SendPawnDied(Controller killed, Controller killer)
{
	tcpServer.SendPawnDied(killed, killer);
}

// Inform client that the game has ended
function SendEndGame()
{
	tcpServer.SendEndGame();
	`log("[OnlineService] EndGame called");
}

defaultproperties
{
}