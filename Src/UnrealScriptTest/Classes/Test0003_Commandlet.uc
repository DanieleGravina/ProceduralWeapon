/**
 * To run this do the following:  run UnrealScriptTest.Test0003_Commandlet
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0003_Commandlet extends TestCommandletBase;


event int main( string Params )
{
   local int Retval;

   Retval = 1;

   LogInternal(" --= Test0003_Commandlet =--");


   Retval = Test0003();

   return Retval;
}


function int Test0003()
{
   local int Retval;
   local Test0003_DerivedClass AClass;
   local Test0003_Interface AnInterface;


   LogInternal("Running:  Test0003");

   AClass = new(self) class'Test0003_DerivedClass';
   AnInterface = Test0003_Interface(AClass);

   // need some EQUAL tests here eventually
//   if( AnInterface.Test0003_FunctionA() ){ return 1; }

	if( AnInterface.Test0003_FunctionB() != TRUE ){ return 1; }

	if( AnInterface.Test0003_FunctionC() != "Test0003_FunctionC()" ){ return 1; }

	if( AnInterface.Test0003_FunctionD() != 1 ){ return 1; }

	if( AnInterface.Test0003_FunctionE() != 1.0f ){ return 1; }

	if( AnInterface.Test0003_FunctionF() != 1 ){ return 1; }


   // if we have made it this far then return 0
   Retval = 0;
   return Retval;
}

defaultproperties
{
   HelpDescription="regression testing for CIS"
   HelpUsage="gamename.exe UnrealScriptTest.Test0003_Commandlet"
   HelpParamNames(0)=
   HelpParamDescriptions(0)=
   LogToConsole=True
   Name="Default__Test0003_Commandlet"
   ObjectArchetype=TestCommandletBase'UnrealScriptTest.Default__TestCommandletBase'
}
