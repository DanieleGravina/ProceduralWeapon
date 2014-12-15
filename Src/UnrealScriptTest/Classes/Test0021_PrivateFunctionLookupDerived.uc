/**
 * Test calling a function which has the same name as a private function in a base class.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class Test0021_PrivateFunctionLookupDerived extends Test0021_PrivateFunctionLookupBase;























































































































 



#linenumber 7

// The derived version this function has a different number of parameters
function DifferentNumberOfParams( float DeltaTime )
{
	LogInternal(GetFuncName()@"DeltaTime:'"$DeltaTime$"'");
}

defaultproperties
{
   Name="Default__Test0021_PrivateFunctionLookupDerived"
   ObjectArchetype=Test0021_PrivateFunctionLookupBase'UnrealScriptTest.Default__Test0021_PrivateFunctionLookupBase'
}
