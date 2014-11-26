class OnlineService extends Actor;

var ProceduralWeapon procWeap;

var TcpLinkServer tcpServer;
var TcpLinkServerAcceptor tcpAcceptor;


function Initialize()
{
    tcpServer = Spawn(class'TcpLinkServer');
    
}

function SendPawnDied(Controller killed, Controller killer)
{
	tcpServer.SendPawnDied(killed, killer);
}

// Inform client that the game has ended
/*function CheckFinishGame()
{
	tcpServer.CheckFinishGame();
}*/

defaultproperties
{
}