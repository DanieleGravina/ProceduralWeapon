//=============================================================================
// PWPawn, extends pawn to control the procedural weapon selected by pawn
//
//=============================================================================
class PWPawn extends UTPawn
	  placeable;
	
var int minRangeSniping;

/***************************************************************************
* Lets us know that the class is being called, for debugging purposes
***************************************************************************/
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();
    `Log("================");
    `Log("PWPawn up");
    
}

//Set the weapon with the parameters hold by the controller
function SetProceduralWeapon(TcpLinkServer _tcp_server)
{
	local ProceduralWeapon myWeapon;
	
	`log("[PWPawn] before set weapon of "$Controller.PlayerReplicationInfo.playername);
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`log("[PWPawn] set weapon of "$Controller.PlayerReplicationInfo.playername);
	
		myWeapon = ProceduralWeapon(Weapon);

		myWeapon.tcp_server = _tcp_server;

		ServerGame(WorldInfo.Game).SetPWParameters(Controller.PlayerReplicationInfo.playername);
		ServerGame(WorldInfo.Game).SetPPParameters(Controller.PlayerReplicationInfo.playername);

		myWeapon.Spread[0] = ServerGame(WorldInfo.Game).GetPWParameters().Spread;
		myWeapon.FireInterval[0] = ServerGame(WorldInfo.Game).GetPWParameters().RoF;
		myWeapon.MaxAmmoCount = ServerGame(WorldInfo.Game).GetPWParameters().MaxAmmo;
		myWeapon.ShotCost[0] = ServerGame(WorldInfo.Game).GetPWParameters().ShotCost;
		myWeapon.WeaponRange = ServerGame(WorldInfo.Game).GetPWParameters().Range*300;
/*
		`log("[PWPawn] Spread "$string(myWeapon.Spread[0]));
		`log("[PWPawn] FireInterval "$string(myWeapon.FireInterval[0]));
		`log("[PWPawn] MaxAmmoCount "$string(myWeapon.MaxAmmoCount));
		`log("[PWPawn] Shotcost "$string(myWeapon.Shotcost[0]));
		`log("[PWPawn] WeaponRange "$string(myWeapon.WeaponRange));
	*/	

		myWeapon.ShotCost[0] = (myWeapon.ShotCost[0] > 10) ? 10 : myWeapon.ShotCost[0];
	
		myWeapon.AmmoCount = myWeapon.MaxAmmoCount;
		myWeapon.Spread[1] = myWeapon.Spread[0];
		myWeapon.FireInterval[1] = myWeapon.FireInterval[0];
		myWeapon.ShotCost[1] = myWeapon.ShotCost[0];

		myWeapon.SpreadDist = myWeapon.Spread[0];

		if(ServerGame(WorldInfo.Game).GetPPParameters().Explosive > 0)
		{
			myWeapon.bRecommendSplashDamage = true;
		}

	
		if(myWeapon.WeaponRange >= MinRangeSniping)
		{
			myWeapon.bSniping = true;
		}

		if(myWeapon.FireInterval[0] < 0.5){
			myWeapon.bFastrepeater = true;
		}
	}
}

defaultproperties
{
	
	InventoryManagerClass = class'ProceduralInventoryManager'
	
	minRangeSniping = 10000;
	
	 /** AI and navigation */
    /*AvoidLedges=true               // don't get too close to ledges
    bStopAtLedges=true              // if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
    bUpdateEyeHeight=true           // Updates eye height so that the flashlight can become dynamic*/
    
   ControllerClass=UTGame.UTBot
}