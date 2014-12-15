/**
 * Performs various tests for struct defaults
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/
class Test0020_StructDefaults extends TestClassBase
	editinlinenew;























































































































 



#linenumber 8

struct TestNestedStruct
{
	var()	int		NestedStructInt;

structdefaultproperties
{
	NestedStructInt=100
}

};

struct TestStruct
{
	var() int TestInt;
	var() float TestFloat;
	var() TestNestedStruct TestMemberStruct;
	var() TestNestedStruct TestMemberStruct2;

structdefaultproperties
{
	TestInt=8
	TestFloat=2.0f
	TestMemberStruct2=(NestedStructInt=300)
}
};




var() TestStruct	StructVar_NoDefaults;
var() TestStruct	StructVar_ClassDefaults;


var() int			ClassIntVar;
var() string		ClassStringVar;

final function LogPropertyValues( optional TestStruct ParameterStruct )
{

	local TestStruct LocalTestStruct;

	LogInternal("ClassIntVar:'"$ClassIntVar$"'");
	LogInternal("ClassStringVar:'"$ClassStringVar$"'");

	LogInternal("LocalTestStruct.TestInt:'"$LocalTestStruct.TestInt$"'");
	LogInternal("LocalTestStruct.TestFloat:'"$LocalTestStruct.TestFloat$"'");
	LogInternal("LocalTestStruct.TestMemberStruct.NestedStructInt:'"$LocalTestStruct.TestMemberStruct.NestedStructInt$"'");
	LogInternal("LocalTestStruct.TestMemberStruct2.NestedStructInt:'"$LocalTestStruct.TestMemberStruct2.NestedStructInt$"'");

	LogInternal("ParameterStruct.TestInt:'"$ParameterStruct.TestInt$"'");
	LogInternal("ParameterStruct.TestFloat:'"$ParameterStruct.TestFloat$"'");
	LogInternal("ParameterStruct.TestMemberStruct.NestedStructInt:'"$ParameterStruct.TestMemberStruct.NestedStructInt$"'");
	LogInternal("ParameterStruct.TestMemberStruct2.NestedStructInt:'"$ParameterStruct.TestMemberStruct2.NestedStructInt$"'");


	LogInternal("StructVar_NoDefaults.TestInt:'"$StructVar_NoDefaults.TestInt$"'");
	LogInternal("StructVar_NoDefaults.TestFloat:'"$StructVar_NoDefaults.TestFloat$"'");
	LogInternal("StructVar_NoDefaults.TestMemberStruct.NestedStructInt:'"$StructVar_NoDefaults.TestMemberStruct.NestedStructInt$"'");
	LogInternal("StructVar_NoDefaults.TestMemberStruct2.NestedStructInt:'"$StructVar_NoDefaults.TestMemberStruct2.NestedStructInt$"'");

	LogInternal("StructVar_ClassDefaults.TestInt:'"$StructVar_ClassDefaults.TestInt$"'");
	LogInternal("StructVar_ClassDefaults.TestFloat:'"$StructVar_ClassDefaults.TestFloat$"'");
	LogInternal("StructVar_ClassDefaults.TestMemberStruct.NestedStructInt:'"$StructVar_ClassDefaults.TestMemberStruct.NestedStructInt$"'");
	LogInternal("StructVar_ClassDefaults.TestMemberStruct2.NestedStructInt:'"$StructVar_ClassDefaults.TestMemberStruct2.NestedStructInt$"'");


}

defaultproperties
{
   StructVar_NoDefaults=(TestInt=8,TestFloat=2.000000,TestMemberStruct=(NestedStructInt=100),TestMemberStruct2=(NestedStructInt=300))
   StructVar_ClassDefaults=(TestInt=16,TestFloat=10.000000,TestMemberStruct=(NestedStructInt=100),TestMemberStruct2=(NestedStructInt=300))
   ClassIntVar=16
   ClassStringVar="ClassStringDefault"
   Name="Default__Test0020_StructDefaults"
   ObjectArchetype=TestClassBase'UnrealScriptTest.Default__TestClassBase'
}
