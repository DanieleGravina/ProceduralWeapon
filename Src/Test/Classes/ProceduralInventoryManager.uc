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
}

reliable server function ServerSetCurrentWeapon(Weapon DesiredWeapon)
{
	super.ServerSetCurrentWeapon(DesiredWeapon);
	
	if(myLog != None)
	{
		myLog.addInventoryLog();
	}
}

/*simulated function ClientWeaponSet(Weapon NewWeapon, bool bOptionalSet)
{
	Super.ClientWeaponSet(NewWeapon, bOptionalSet);

	PWPawn(Instigator).ClientSetProceduralWeapon();
}*/



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