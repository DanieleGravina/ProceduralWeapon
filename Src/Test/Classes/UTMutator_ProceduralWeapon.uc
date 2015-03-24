class UTMutator_ProceduralWeapon extends UTMutator;

function bool CheckReplacement(Actor Other)
{
	local UTWeaponPickupFactory WeaponPickup;
	local UTWeaponLocker Locker;
	local UTAmmoPickupFactory AmmoPickup, NewAmmo;
	local int i;
	local class<UTAmmoPickupFactory> NewAmmoClass;

	WeaponPickup = UTWeaponPickupFactory(Other);
	if (WeaponPickup != None)
	{
		if (WeaponPickup.WeaponPickupClass != None)
		{
			WeaponPickup.WeaponPickupClass = class'ProceduralWeapon';
			WeaponPickup.InitializePickup();
		}
	}
	else
	{
		Locker = UTWeaponLocker(Other);
		if (Locker != None)
		{
			for (i = 0; i < Locker.Weapons.length; i++)
			{
				if (Locker.Weapons[i].WeaponClass != None)
				{
					Locker.ReplaceWeapon(i, class 'ProceduralWeapon');
				}
			}
		}
		else
		{
			AmmoPickup = UTAmmoPickupFactory(Other);
			if (AmmoPickup != None)
			{	
				NewAmmoClass = class 'UTProceduralAmmoPickupFactory';
				
				if (NewAmmoClass.default.bStatic || NewAmmoClass.default.bNoDelete)
				{
					// transform the current ammo into the desired class
					AmmoPickup.TransformAmmoType(NewAmmoClass);
					return true;
				}
				else
				{
					// spawn the new ammo, link it to the old, then disable the old one
					NewAmmo = AmmoPickup.Spawn(NewAmmoClass);
					NewAmmo.OriginalFactory = AmmoPickup;
					AmmoPickup.ReplacementFactory = NewAmmo;
					return false;
				}
			}
		}
	}

	return true;
}

defaultproperties
{
   GroupNames(0)="WEAPONMOD"
   Begin Object Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_ProceduralWeapon"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}