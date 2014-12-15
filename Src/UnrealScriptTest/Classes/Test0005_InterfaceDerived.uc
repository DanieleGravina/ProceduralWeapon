/**
 * Test interfaces extending a base interface and having a class implement
 * both of the base and derived's methods
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

interface Test0005_InterfaceDerived extends Test0005_InterfaceBase;


function string derivedFoo();

defaultproperties
{
   Name="Default__Test0005_InterfaceDerived"
   ObjectArchetype=Test0005_InterfaceBase'UnrealScriptTest.Default__Test0005_InterfaceBase'
}
