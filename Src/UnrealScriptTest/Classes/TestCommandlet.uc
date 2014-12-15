/**
 * To run this do the following:  run UnrealScriptTest.TestCommandlet
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class TestCommandlet extends CommandLet;

event int main( string Params )
{
   LogInternal(" --= TestCommandlet =--");

   LogInternal("You should run each of the indiv test commandlets to test the various runtime regressions.");

   return 0;
}

defaultproperties
{
   HelpDescription="regression testing for CIS"
   HelpUsage="gamename.exe UnrealScriptTest.TestCommandlet"
   HelpParamNames(0)=
   HelpParamDescriptions(0)=
   Name="Default__TestCommandlet"
   ObjectArchetype=Commandlet'Core.Default__Commandlet'
}
