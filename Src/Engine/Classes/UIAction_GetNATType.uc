/**
 * This action gets the NAT type of the current network system.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetNATType extends UIAction
	native(inherit)
	config(UI);


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Debug bool to force this action to always return NAT_Open. */
var	config	bool	bAlwaysOpen;

/**
 * Gets the current NAT type from the online system.
 * @param OutNATType	Storage variable for our NAT type.
 * @return TRUE if we got a NAT type, FALSE otherwise.
 */
event bool GetNATType(out ENATType OutNATType)
{
	local bool Result;
	local OnlineSubsystem OnlineSub;
	local OnlineSystemInterface SystemInterface;

	Result = false;

	// Figure out if we have an online subsystem registered
	OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
	if (OnlineSub != None)
	{
		SystemInterface = OnlineSub.SystemInterface;
		if (SystemInterface != None)
		{
			// Get status
			OutNATType = SystemInterface.GetNATType();
			Result = true;
		}
	}

	return Result;
}

defaultproperties
{
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Unknown")
   OutputLinks(1)=(LinkDesc="Open")
   OutputLinks(2)=(LinkDesc="Moderate")
   OutputLinks(3)=(LinkDesc="Strict")
   ObjName="Get NAT Type"
   ObjCategory="Online"
   Name="Default__UIAction_GetNATType"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
