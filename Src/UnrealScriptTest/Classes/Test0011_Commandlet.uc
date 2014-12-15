/**
 *  To run this do the following:  run UnrealScriptTest.Test0011_Commandlet
 *
 * Part of the unrealscript execution and compilation regression framework.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */

class Test0011_Commandlet extends TestCommandletBase;























































































































 



#linenumber 10

event int Main( string Parms )
{
	PerformBoolOrderTest();

	return 0;
}


final function PerformBoolOrderTest()
{
	local Test0011_NativeObjectBoolOrder TestObj;

	TestObj = new(self) class'Test0011_NativeObjectBoolOrder';

	TestObj.PerformBoolOrderTest();
}

defaultproperties
{
   HelpDescription="regression testing for CIS"
   HelpUsage="gamename.exe UnrealScriptTest.Test0011_Commandlet"
   HelpParamNames(0)=
   HelpParamDescriptions(0)=
   LogToConsole=True
   Name="Default__Test0011_Commandlet"
   ObjectArchetype=TestCommandletBase'UnrealScriptTest.Default__TestCommandletBase'
}
