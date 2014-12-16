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
	
		if(ServerGame(WorldInfo.Game).mapBotPar.Length != 0)
		{
			//TODO better code
			myWeapon.Spread[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).Spread;
			myWeapon.FireInterval[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).RoF;
			myWeapon.MaxAmmoCount = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).MaxAmmo;
			myWeapon.ShotCost[0] = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).ShotCost;
			myWeapon.WeaponRange = ServerGame(WorldInfo.Game).GetPWParameters(Controller.PlayerReplicationInfo.playername).Range*1000;
		
			myWeapon.AmmoCount = myWeapon.MaxAmmoCount;
			myWeapon.Spread[1] = myWeapon.Spread[0];
			myWeapon.FireInterval[1] = myWeapon.FireInterval[0];
			myWeapon.ShotCost[1] = myWeapon.ShotCost[0];
		}
		
	
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
	
	 /** PostRender functions */
    bPostRenderIfNotVisible = true  // IF true, may call PostRenderFor() even when this actor is not visible 
    bPostRenderOtherTeam=true       // If true, call postrenderfor() even if on different team
    
    /*begin object class=SkeletalMeshComponent Name=Model3D                
      SkeletalMesh=CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode
      PhysicsAsset=CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics
      AnimSets(0)=CH_AnimHuman.Anims.K_AnimHuman_BaseMale
      AnimtreeTemplate=CH_AnimHuman_Tree.AT_CH_Human
    end object

   Components.Add(Model3D);*/
    
   ControllerClass=UTGame.UTBot
}