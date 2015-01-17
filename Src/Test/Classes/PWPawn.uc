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
simulated function SetProceduralWeapon()
{
	local ProceduralWeapon myWeapon;
	
	`log("[PWPawn] before set weapon of "$Controller.PlayerReplicationInfo.playername);
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`log("[PWPawn] set weapon of "$Controller.PlayerReplicationInfo.playername);
	
		myWeapon = ProceduralWeapon(Weapon);

		TestGame(WorldInfo.Game).SetPWParameters(Controller.PlayerReplicationInfo.playername);

		myWeapon.Spread[0] = TestGame(WorldInfo.Game).GetPWParameters().Spread;
		myWeapon.FireInterval[0] = TestGame(WorldInfo.Game).GetPWParameters().RoF;
		myWeapon.MaxAmmoCount = TestGame(WorldInfo.Game).GetPWParameters().MaxAmmo;
		myWeapon.ShotCost[0] = TestGame(WorldInfo.Game).GetPWParameters().ShotCost;
		myWeapon.WeaponRange = TestGame(WorldInfo.Game).GetPWParameters().Range*1000;
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

	
		if(myWeapon.WeaponRange >= MinRangeSniping)
		{
			myWeapon.bSniping = true;
		}

		if(myWeapon.FireInterval[0] < 0.5){
			myWeapon.bFastrepeater = true;
		}

		if(myWeapon.ShotCost[0] > 1)
		{
			myWeapon.WeaponFireTypes[0]=EWFT_Custom;
			myWeapon.WeaponFireTypes[1]=EWFT_Custom;
		}
		else
		{
			myWeapon.WeaponFireTypes[0]=EWFT_Projectile;
			myWeapon.WeaponFireTypes[1]=EWFT_Projectile;
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