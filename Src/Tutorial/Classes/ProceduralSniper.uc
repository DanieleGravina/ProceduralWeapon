class ProceduralSniper extends UTWeap_SniperRifle;

//Cannot pickup any different weapon from default one
function bool DenyPickupQuery(class<Inventory> ItemClass, Actor Pickup)
{
	
	if(ClassIsChildOf(ItemClass, class 'UTWeapon'))
	{
		AddAmmo(MaxAmmoCount);
		return true;
	}
	else
	{
		return false;
	}
}