/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleCTFGame extends UTCTFGame
	abstract;

// Returns whether a mutator should be allowed with this gametype
static function bool AllowMutator( string MutatorClassName )
{
	if ( (MutatorClassName ~= "UTGame.UTMutator_Instagib") || (MutatorClassName ~= "UTGame.UTMutator_WeaponsRespawn")
		|| (MutatorClassName ~= "UTGame.UTMutator_LowGrav") )
	{
		return false;
	}
	return Super.AllowMutator(MutatorClassName);
}

defaultproperties
{
   bStartWithLockerWeaps=True
   bAllowTranslocator=False
   bAllowHoverboard=True
   bMidGameHasMap=True
   Acronym="VCTF"
   Description="Cattura la Bandiera tradizionale, con veicoli e Hoverboard invece che con Teletrasportatori. La bandiera può essere trasportata in qualsiasi veicolo eccetto gli Hoverboard."
   MapPrefixes(0)="VCTF"
   GameName="Veicolo CLB"
   OnlineGameSettingsClass=Class'UTGame.UTGameSettingsVCTF'
   Name="Default__UTVehicleCTFGame"
   ObjectArchetype=UTCTFGame'UTGame.Default__UTCTFGame'
}
