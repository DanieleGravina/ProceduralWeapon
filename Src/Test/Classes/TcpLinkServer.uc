/*
 * An example usage of the TcpLink class
 *  
 * By Michiel 'elmuerte' Hendriks for Epic Games, Inc.
 *  
 * You are free to use this example as you see fit, as long as you 
 * properly attribute the origin. 
 */ 
class TcpLinkServer extends TcpLink;

var int ListenPort;
var int MaxClients;
var int NumClients;

var Actor currentAcceptor;

event PostBeginPlay()
{
    super.PostBeginPlay();
}

event GainedChild( Actor C )
{
    `Log("[TcpLinkServer] GainedChild");
	super.GainedChild(C);
	++NumClients;
	
	// if too many clients, stop accepting new connections
	if(MaxClients > 0 && NumClients >= MaxClients && LinkState == STATE_Listening)
	{
		`log("[TcpLinkServer] Maximum  number of clients connected, rejecting new clients");
 		Close();
	}
	
	currentAcceptor = C;
}

event LostChild( Actor C )
{
    `Log("[TcpLinkServer] LostChild");
	Super.LostChild(C);
	--NumClients;
	
	// Check if there is room for accepting new clients
	if(NumClients < MaxClients && LinkState != STATE_Listening)
	{
		`log("[TcpLinkServer] Listening for incoming connections");
 		Listen();
	}
}

//Set the listen port of this server
function SetListenPort(int p)
{
	local int res;
	
	`log("[TcpLinkServer] set listen port "$string(p));
	ListenPort = p;
	
	// first bind the port you want to listen on
    res = BindPort(ListenPort, false);
    if (res == 0)
    {
        `log("[TcpLinkServer] Failed binding port "$ListenPort);
    }
    else {
        // start listening for connections
        if (Listen())
        {
            `log("[TcpLinkServer] Listening on port "$res$" for incoming connections");
        }
        else {
            `log("[TcpLinkServer] Failed listening on port "$ListenPort);
        }
    }
}


defaultproperties
{
    ListenPort=3742
    MaxClients=1    
    AcceptClass=Class'TcpLinkServerAcceptor'
}
