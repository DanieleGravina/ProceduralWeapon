/**
 * Demonstrates and verifies boolean comparison functionality for delegates.
 *
 * Copyright 2007 Epic Games, Inc. All Rights Reserved
 */
class Test0024_DelegateComparison extends TestClassBase;

var Test0024_Commandlet CommandletOwner;

delegate ComparisonDelegate( int Param1 )
{
	LogInternal("Executing the default body for ComparisonDelegate");
}

function TestDelegateParam( delegate<ComparisonDelegate> MyDelegate )
{
	LogInternal("Here we are in TestDelegateParm");

	if ( MyDelegate != None )
	{
		LogInternal("MyDelegate has a value");
	}

	if ( ComparisonDelegate != None )
	{
		LogInternal("ComparisonDelegate is assigned a value!");
	}

	if ( MyDelegate == ComparisonDelegate )
	{
		LogInternal("MyDelegate value is same as ComparisonDelegate");
	}
	else if ( MyDelegate == DelegateFunction )
	{
		LogInternal("MyDelegate assigned to DelegateFunction");
	}
//	else if ( MyDelegate == SomeOtherDelegate )
//	{
//		`log("This should be a compiler error");
//	}

	if ( MyDelegate == CommandletOwner.CommandletDelegateFunction )
	{
		LogInternal("MyDelegate is assigned to CommandletOwner's CommandletDelegateFunction");
	}

	MyDelegate( 10 );
}

function DelegateFunction( int Param1 )
{
	LogInternal("DelegateFunction - Param1:" $ Param1);
}

function DelegateExample( Test0024_Commandlet Owner )
{
	CommandletOwner = Owner;

	LogInternal("First call ======================");
	TestDelegateParam(DelegateFunction);

	LogInternal("");
	LogInternal("Second Call ======================");
	TestDelegateParam(None);

	CommandletOwner.CommandletDelegate = CommandletOwner.CommandletDelegateFunction;

	LogInternal("");
	LogInternal("Third Call =====================");
	TestDelegateParam(CommandletOwner.CommandletDelegateFunction);
}

delegate SomeOtherDelegate( bool bFoo );

defaultproperties
{
   __ComparisonDelegate__Delegate=Default__Test0024_DelegateComparison.DelegateFunction
   Name="Default__Test0024_DelegateComparison"
   ObjectArchetype=TestClassBase'UnrealScriptTest.Default__TestClassBase'
}
