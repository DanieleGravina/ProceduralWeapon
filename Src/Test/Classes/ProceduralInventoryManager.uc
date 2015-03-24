class ProceduralInventoryManager extends UTInventoryManager;

var TestLog myLog;
var int addedWeapon;

function SetTestLog(TestLog log)
{
	myLog = log;
}

/**
 * Switches to Previous weapon
 * Network: Client
 */
simulated function PrevWeapon()
{
	super.PrevWeapon();


	if(myLog != None)
	{
		myLog.addInventoryLog();
	}

	ChangeBotWeapon();
}

/**
 * Switches to Previous weapon
 * Network: Client
 */
simulated function NextWeapon()
{	
	super.NextWeapon();


	if(myLog != None)
	{
		myLog.addInventoryLog();
	}

	ChangeBotWeapon();
}

reliable server function ServerSetCurrentWeapon(Weapon DesiredWeapon)
{
	super.ServerSetCurrentWeapon(DesiredWeapon);
	
	if(myLog != None)
	{
		myLog.addInventoryLog();
	}
}

simulated function ChangeBotWeapon()
{
	local PWPawn P;
	local ProceduralWeapon myWeapon;
	local array<PWParameters> weaponPars;
	local array<PPParameters> projPars;
	local int index, i;

	if(ProceduralWeaponBot(Instigator.Controller) == None)
	{
		foreach WorldInfo.AllPawns(class'PWPawn', P)
		{
			if(ProceduralWeaponBot(P.Controller) != none)
			{
				`log("[ProcInvManager] ChangeBotWeapon called");

				weaponPars = TestGame(WorldInfo.Game).GetPWParameters(Instigator.Controller.PlayerReplicationInfo.playername);
				projPars = TestGame(WorldInfo.Game).GetPPParameters(Instigator.Controller.PlayerReplicationInfo.playername);

				//setting weapon of bot

				myWeapon = ProceduralWeapon(P.weapon);

				index = 0;

				if(weaponPars[index].RoF == myWeapon.FireInterval[0] && weaponPars[index].Spread == myWeapon.Spread[0])
				{
					index += 1;
				}

				//proportionate ammo count
				myWeapon.AmmoCount = myWeapon.AmmoCount/myWeapon.MaxAmmoCount*weaponPars[index].MaxAmmo;

				myWeapon.Spread[0] = weaponPars[index].Spread;
				myWeapon.FireInterval[0] = weaponPars[index].RoF;
				myWeapon.MaxAmmoCount = weaponPars[index].MaxAmmo;
				myWeapon.ShotCost[0] = weaponPars[index].ShotCost;
				
				myWeapon.Spread[1] = myWeapon.Spread[0];
				myWeapon.FireInterval[1] = myWeapon.FireInterval[0];
				myWeapon.ShotCost[1] = myWeapon.ShotCost[0];

				myWeapon.SpreadDist = myWeapon.Spread[0];

				myWeapon.Gravity = projPars[index].Gravity;
				myWeapon.Speed = projPars[index].Speed;

				if(projPars[index].Gravity != 0)
				{
					myWeapon.WeaponRange = Sqrt( 2*80/Abs(projPars[index].Gravity) ) *
											projPars[index].Speed;
				}
				else{
						//Range is MaxRange on default implementation 
					if(projPars[index].Speed < 300)
					{
						myWeapon.WeaponRange = weaponPars[index].Range*
												projPars[index].Speed;
					}
					else
					{
						myWeapon.WeaponRange = weaponPars[index].Range*300;
					}

				}

				
				if(myWeapon.WeaponRange >= PWPawn(Instigator).MinRangeSniping)
				{
					myWeapon.bSniping = true;
				}

				if(myWeapon.FireInterval[0] < 0.5){
					myWeapon.bFastrepeater = true;
				}

				//setting projectile of bot

				for(i = 0; i  < TestGame(WorldInfo.Game).NUM_WEAPON; i++)
				{
					if(TestGame(WorldInfo.Game).mapBotPar[i].botName != Instigator.Controller.PlayerReplicationInfo.playername)
					{
						TestGame(WorldInfo.Game).mapBotPar[i].projPars.Speed = projPars[index].Speed;
						TestGame(WorldInfo.Game).mapBotPar[i].projPars.Damage = projPars[index].Damage;
						TestGame(WorldInfo.Game).mapBotPar[i].projPars.DamageRadius = projPars[index].DamageRadius;
						TestGame(WorldInfo.Game).mapBotPar[i].projPars.Gravity = projPars[index].Gravity;
						TestGame(WorldInfo.Game).mapBotPar[i].projPars.Explosive = projPars[index].Explosive;
					}
				}

				`log("[ProcInvManager] Weapon: " $string(P.Weapon.FireInterval[0]));
			}
		}
	}
}



simulated function bool AddInventory(Inventory NewItem, optional bool bDoNotActivate)
{
	local int reloadCount;

	//`log("[ProcInvManager] before add inv");


	if( (NewItem != None) && !NewItem.bDeleteMe )
	{
		if(ProceduralWeapon(NewItem) != none || ProceduralWeapon2(NewItem) != none)
		{
			if(addedWeapon < PWPawn(Instigator).num_weapon)
			{
				//`log("[ProcInvManager] add procedural weapon");
				addedWeapon++;
				return super.AddInventory(NewItem, bDoNotActivate);
			}
			else
			{
				if(ProceduralWeapon(Instigator.Weapon) != none)
				{
					reloadCount = ProceduralWeapon(Instigator.Weapon).MaxAmmoCount/4 + 1;
					ProceduralWeapon(Instigator.Weapon).AddAmmo(reloadCount);	
				}
				else
				{
					reloadCount = ProceduralWeapon2(Instigator.Weapon).MaxAmmoCount/4 + 1;
					ProceduralWeapon2(Instigator.Weapon).AddAmmo(reloadCount);
				}

				NewItem.Destroy();
				return true;
			}
		}
		else
		{
			if(ClassIsChildOf(NewItem.class, class 'UTWeapon') || ClassIsChildOf(NewItem.class, class 'Projectile'))
			{
				reloadCount = ProceduralWeapon(Instigator.Weapon).MaxAmmoCount/4 + 1;
				ProceduralWeapon(Instigator.Weapon).AddAmmo(reloadCount);
				//`log("[ProcInvManager] added ammo");
				Instigator.TriggerEventClass(class'SeqEvent_GetInventory', NewItem);
				NewItem.Destroy();
				return true;
			}
			else
			{
				//`log("[ProcInvManager] add other than a weapon");
				return super.AddInventory(NewItem, bDoNotActivate);	
			}
		}
	}

	`log("[ProcInvManager] not added ammo");
	
	return false;
}

defaultproperties
{
	addedWeapon = 0;
}