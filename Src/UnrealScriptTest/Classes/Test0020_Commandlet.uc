/**
 *  To run this do the following:  run UnrealScriptTest.Test0020_Commandlet
 *
 * Part of the unrealscript execution and compilation regression framework.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class Test0020_Commandlet extends TestCommandletBase;























































































































 



#linenumber 9

event int Main( string Parms )
{
	PerformStructSerializationTest();

	return 0;
}


final function PerformStructSerializationTest()
{
	local Test0020_StructDefaults TestObj;

	TestObj = new(self) class'Test0020_StructDefaults';

	TestObj.LogPropertyValues();
}

defaultproperties
{
   HelpDescription="regression testing for CIS"
   HelpUsage="gamename.exe UnrealScriptTest.Test0020_Commandlet"
   HelpParamNames(0)=
   HelpParamDescriptions(0)=
   LogToConsole=True
   Name="Default__Test0020_Commandlet"
   ObjectArchetype=TestCommandletBase'UnrealScriptTest.Default__TestCommandletBase'
}
