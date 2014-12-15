/**
 * Part of the unrealscript execution and compilation regression framework.
 * Native class for testing and regressing issues with native unrealscript classes.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */

class Test0011_NativeObjectBoolOrder extends Object
	native;
























































































































 



#linenumber 11

var()	bool	bMemberBoolA, bMemberBoolB, bMemberBoolC;

native function PerformBoolOrderTest();

native function bool NativeTestBoolOrderFunction( bool BoolParm );

event NativeTestBoolOrderEvent( bool EventBoolParm )
{

	local bool bLocalBoolLiteral, bLocalBoolParm, bLocalBoolMemberTrue, bLocalBoolMemberFalse;

	LogInternal("InputBoolValue:'"$EventBoolParm$"'");
	LogInternal("");

	bLocalBoolLiteral = NativeTestBoolOrderFunction(true);
	LogInternal("LiteralBoolResult:'"$bLocalBoolLiteral$"'");
	LogInternal("");

	bLocalBoolParm = NativeTestBoolOrderFunction(EventBoolParm);
	LogInternal("InputBoolResult:'"$bLocalBoolParm$"'");
	LogInternal("");

	bLocalBoolMemberTrue = NativeTestBoolOrderFunction(bMemberBoolC);
	LogInternal("bLocalBoolMemberTrue:'"$bLocalBoolMemberTrue$"'");
	LogInternal("");

	bLocalBoolMemberFalse = NativeTestBoolOrderFunction(bMemberBoolB);
	LogInternal("bLocalBoolMemberFalse:'"$bLocalBoolMemberFalse$"'");
	LogInternal("");

}

defaultproperties
{
   bMemberBoolA=True
   bMemberBoolC=True
   Name="Default__Test0011_NativeObjectBoolOrder"
   ObjectArchetype=Object'Core.Default__Object'
}
