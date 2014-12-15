/**
 * This action changes the visibility of a widget
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_ChangeVisibility extends UIAction;

var()	bool	bVisible;

defaultproperties
{
   bVisible=True
   ObjName="Change Visibility"
   Name="Default__UIAction_ChangeVisibility"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
