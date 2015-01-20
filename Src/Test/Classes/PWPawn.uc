//=============================================================================
// PWPawn, extends pawn to control the procedural weapon selected by pawn
//
//=============================================================================
class PWPawn extends UTPawn
	  placeable
	  DependsOn(TestGame);
	
var int minRangeSniping;

var bool bIsRemote;

const NUM_BOTS = 2;

var int num_weapon;

/***************************************************************************
* Lets us know that the class is being called, for debugging purposes
***************************************************************************/
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();
    `Log("================");
    `Log("PWPawn up");
    
}

simulated function ProceduralWeaponSetTimer()
{
	SetProceduralWeapon();
}

//Set the weapon with the parameters hold by the controller
function SetProceduralWeapon()
{
	local array<PWParameters> weaponPars;
	local int index;
	local ProceduralWeapon myWeapon;
	
	`log("[PWPawn] before set weapon of "$Controller.PlayerReplicationInfo.playername);

	if(Weapon == None || InvManager == None)
	{
		SetTimer(0.05, false, 'ProceduralWeaponSetTimer');
		bIsRemote = true;
		return;
	}
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`log("[PWPawn] set weapon of "$Controller.PlayerReplicationInfo.playername);

		TestGame(WorldInfo.Game).SetWeaponLog(self);

		weaponPars = TestGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername);

		index = 0;

		ForEach InvManager.InventoryActors( class'ProceduralWeapon', myWeapon )
		{

			myWeapon.WeaponId = index;

			myWeapon.Spread[0] = weaponPars[index].Spread;
			myWeapon.FireInterval[0] = weaponPars[index].RoF;
			myWeapon.MaxAmmoCount = weaponPars[index].MaxAmmo;
			myWeapon.ShotCost[0] = weaponPars[index].ShotCost;
			myWeapon.WeaponRange = weaponPars[index].Range*1000;
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

			index++;
		}

		if(bIsRemote)
		{
			ClientSetProceduralWeapon();
		}
	}
}

reliable client function ClientSetProceduralWeapon()
{
	local array<PWParameters> weaponPars;
	local int index;
	local UTGameReplicationInfo GRI;
	local ProceduralGameReplicationInfo PGRI;
	local ProceduralWeapon myWeapon;
	
	`log("[PWPawn] before set weapon of "$Controller.PlayerReplicationInfo.playername);
	
	if(Weapon != none && ProceduralWeapon(Weapon) != none)
	{
		`log("[PWPawn] set weapon of "$Controller.PlayerReplicationInfo.playername);

		GRI = UTGameReplicationInfo(Controller.WorldInfo.GRI);
		PGRI = ProceduralGameReplicationInfo(GRI);

		weaponPars = PGRI.GetPWParameters(Controller.PlayerReplicationInfo.playername);

		index = 0;

		ForEach InvManager.InventoryActors( class'ProceduralWeapon', myWeapon )
		{

			myWeapon.WeaponId = index;

			myWeapon.Spread[0] = weaponPars[index].Spread;
			myWeapon.FireInterval[0] = weaponPars[index].RoF;
			myWeapon.MaxAmmoCount = weaponPars[index].MaxAmmo;
			myWeapon.ShotCost[0] = weaponPars[index].ShotCost;
			myWeapon.WeaponRange = weaponPars[index].Range*1000;
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

			index++;
		}
	}
}

defaultproperties
{
	
	InventoryManagerClass = class'ProceduralInventoryManager'
	
	minRangeSniping = 10000;

	bIsRemote = false;

	num_weapon = 1;
	
	 /** AI and navigation */
    /*AvoidLedges=true               // don't get too close to ledges
    bStopAtLedges=true              // if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
    bUpdateEyeHeight=true           // Updates eye height so that the flashlight can become dynamic*/
    
   //ControllerClass=UTGame.UTBot
}