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
function SetProceduralWeapon()
{
	local ProceduralWeapon myWeapon;
	
	`log("[PWPawn] before set weapon of "$Controller.PlayerReplicationInfo.playername);
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`log("[PWPawn] set weapon of "$Controller.PlayerReplicationInfo.playername);
	
		myWeapon = ProceduralWeapon(Weapon);

		ServerGame(WorldInfo.Game).SetPWParameters(Controller.PlayerReplicationInfo.playername);

		myWeapon.Spread[0] = ServerGame(WorldInfo.Game).GetPWParameters().Spread;
		myWeapon.FireInterval[0] = ServerGame(WorldInfo.Game).GetPWParameters().RoF;
		myWeapon.MaxAmmoCount = ServerGame(WorldInfo.Game).GetPWParameters().MaxAmmo;
		myWeapon.ShotCost[0] = ServerGame(WorldInfo.Game).GetPWParameters().ShotCost;
		myWeapon.WeaponRange = ServerGame(WorldInfo.Game).GetPWParameters().Range*1000;
	
		myWeapon.AmmoCount = myWeapon.MaxAmmoCount;
		myWeapon.Spread[1] = myWeapon.Spread[0];
		myWeapon.FireInterval[1] = myWeapon.FireInterval[0];
		myWeapon.ShotCost[1] = myWeapon.ShotCost[0];
		
	
		if(myWeapon.WeaponRange >= MinRangeSniping)
		{
			myWeapon.bSniping = true;
		}
	}
}

defaultproperties
{
	
	//InventoryManagerClass = class'MyInventoryManager'
	
	minRangeSniping = 10000;
	
	 /** AI and navigation */
    /*AvoidLedges=true               // don't get too close to ledges
    bStopAtLedges=true              // if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
    bUpdateEyeHeight=true           // Updates eye height so that the flashlight can become dynamic*/
    
   ControllerClass=UTGame.UTBot
}