class MyInventoryManager extends InventoryManager;

var bool bIsFirstWeapon;

simulated function bool AddInventory(Inventory NewItem, optional bool bDoNotActivate)
{
	if( (NewItem != None) && !NewItem.bDeleteMe )
	{
		if(ProceduralWeapon(NewItem) != none)
		{
			if(bIsFirstWeapon)
			{
				bIsFirstWeapon = false;
				return super.AddInventory(NewItem, bDoNotActivate);
			}
			
			if(Instigator.Weapon != none)
			{
				Instigator.Weapon.AddAmmo(class'ProceduralWeapon'.default.AmmoCount);
				return true;
			}
		
			return false;
		}
		else
		{
			return super.AddInventory(NewItem, bDoNotActivate);
		}
	}
	
	return false;
}

defaultproperties
{
	bIsFirstWeapon = true;
}