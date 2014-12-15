/**
 * To run this do the following:  run UnrealScriptTest.Test0010_Commandlet
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0010_Commandlet extends TestCommandletBase;

event int main( string Params )
{
   local int Retval;

   Retval = 1;

   LogInternal(" --= Test0010_Commandlet =--");


   Retval = Test0010(Params);

   return Retval;
}


function int Test0010( coerce int TestNumber )
{
   local int Retval;
   local Test0010_NativeObject ANativeClass;

   LogInternal("Running:  Test0010  (" $ TestNumber $ ")");


   ANativeClass = new(self) class'Test0010_NativeObject';

   LogInternal("ANativeClass: " $ ANativeClass);

   ANativeClass.PerformNativeTest(TestNumber);

   Retval = 0; // for now
   return Retval;
}

function TestInterface()
{
//	InterfaceObject.TestNativeFunction(InterfaceObject);
}

defaultproperties
{
   HelpDescription="regression testing for CIS"
   HelpUsage="gamename.exe UnrealScriptTest.Test0010_Commandlet"
   HelpParamNames(0)=
   HelpParamDescriptions(0)=
   LogToConsole=True
   Name="Default__Test0010_Commandlet"
   ObjectArchetype=TestCommandletBase'UnrealScriptTest.Default__TestCommandletBase'
}
