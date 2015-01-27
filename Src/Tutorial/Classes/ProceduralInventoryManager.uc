class ProceduralInventoryManager extends UTInventoryManager;

var bool bIsFirstWeapon;

simulated function bool AddInventory(Inventory NewItem, optional bool bDoNotActivate)
{
	local int reloadCount;

	//`log("[ProcInvManager] before add inv");


	if( (NewItem != None) && !NewItem.bDeleteMe )
	{
		if(ProceduralWeapon(NewItem) != none)
		{
			if(bIsFirstWeapon)
			{
				//`log("[ProcInvManager] add procedural weapon");
				bIsFirstWeapon = false;
				return super.AddInventory(NewItem, bDoNotActivate);
			}
			else
			{
				reloadCount = ProceduralWeapon(Instigator.Weapon).MaxAmmoCount/4 + 1;
				ProceduralWeapon(Instigator.Weapon).AddAmmo(reloadCount);
				//`log("[ProcInvManager] added ammo");
				Instigator.TriggerEventClass(class'SeqEvent_GetInventory', NewItem);
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
	bIsFirstWeapon = true;
}