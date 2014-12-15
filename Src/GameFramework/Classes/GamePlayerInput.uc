/**
 * GamePlayerInput
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class GamePlayerInput extends PlayerInput within GamePlayerController
	config(Input)
	transient
	native;

defaultproperties
{
   Name="Default__GamePlayerInput"
   ObjectArchetype=PlayerInput'Engine.Default__PlayerInput'
}
