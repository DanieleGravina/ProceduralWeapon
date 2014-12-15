/**
 * Changes the datastore binding for a widget.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetDatastoreBinding extends UIAction_DataStore;

var() string	NewMarkup;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="New Markup",PropertyName="NewMarkup",MinVars=1,MaxVars=255)
   ObjName="Set Datastore Binding"
   Name="Default__UIAction_SetDatastoreBinding"
   ObjectArchetype=UIAction_DataStore'Engine.Default__UIAction_DataStore'
}
