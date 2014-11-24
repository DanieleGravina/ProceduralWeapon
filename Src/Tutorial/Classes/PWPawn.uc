//=============================================================================
// PWPawn, extends pawn to control the rpocedural weapon selected by pawn
//
//=============================================================================
class PWPawn extends UTPawn;

var int minRangeSniping;

/***************************************************************************
* Lets us know that the class is being called, for debugging purposes
***************************************************************************/
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();
    `Log("================");
    `Log("PWPawn up");
    
    /** called from UTPawn, spawns the default controller */
    SpawnDefaultController();
    
}

//Set the weapon with the parameters hold by the controller
function SetProceduralWeapon()
{
	local ProceduralWeapon myWeapon;
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`Log("PWPawn set weapon of "$Controller.PlayerReplicationInfo.playername);
	
		myWeapon = ProceduralWeapon(Weapon);
	
		myWeapon.Spread[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).Spread;
		myWeapon.FireInterval[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).RoF;
		myWeapon.MaxAmmoCount = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).MaxAmmo;
		myWeapon.ShotCost[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).ShotCost;
		myWeapon.WeaponRange = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).Range;
	
		myWeapon.AmmoCount = myWeapon.MaxAmmoCount;
	
		if(myWeapon.WeaponRange >= MinRangeSniping)
		{
			myWeapon.bSniping = true;
		}
	}
}

//Modified, PWPawn can't get any weapon different from default one
/*function HandlePickup(Inventory Inv)
{
	local ProceduralWeapon myWeapon;
	
	myWeapon = ProceduralWeapon(Weapon);
	
	MakeNoise(0.2);
	myWeapon.AmmoCount = myWeapon.MaxAmmoCount;
	
	`Log("PWPawn pickup");
}*/

defaultproperties
{
	minRangeSniping = 10000;
	
	 /** AI and navigation */
    bAvoidLedges=true               // don't get too close to ledges
    bStopAtLedges=true              // if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
    bUpdateEyeHeight=true           // Updates eye height so that the flashlight can become dynamic
	
	 /** PostRender functions */
    bPostRenderIfNotVisible = true  // IF true, may call PostRenderFor() even when this actor is not visible 
    bPostRenderOtherTeam=true       // If true, call postrenderfor() even if on different team
}