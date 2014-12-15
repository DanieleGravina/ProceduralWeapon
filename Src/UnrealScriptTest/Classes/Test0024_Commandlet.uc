/**
 * Driver commandlet for testing delegate boolean comparison functionality.
 *
 * Copyright 2007 Epic Games, Inc. All Rights Reserved
 */
class Test0024_Commandlet extends TestCommandletBase;

delegate CommandletDelegate( int i )
{
	LogInternal("here i am in the commandlet delegate!");
}

event int Main( string Parms )
{
	local Test0024_DelegateComparison TestObj;

	TestObj = new class'Test0024_DelegateComparison';

	TestObj.DelegateExample(Self);
	return 0;
}

function CommandletDelegateFunction( int Param1 )
{
	LogInternal("CommandletDelegateFunction - Param1:" $ Param1);
}

defaultproperties
{
   LogToConsole=True
   Name="Default__Test0024_Commandlet"
   ObjectArchetype=TestCommandletBase'UnrealScriptTest.Default__TestCommandletBase'
}
