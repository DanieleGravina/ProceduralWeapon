/**
 * Testing extending a base class implementing an interface and having
 * a derived class overriding a subset of the functions
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0004_DerivedClass extends Test0004_BaseClass;


function Test0004_FunctionA()
{
  LogInternal("");
}

defaultproperties
{
   Name="Default__Test0004_DerivedClass"
   ObjectArchetype=Test0004_BaseClass'UnrealScriptTest.Default__Test0004_BaseClass'
}
