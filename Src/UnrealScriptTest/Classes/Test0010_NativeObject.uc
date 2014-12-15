/**
 * Part of the unrealscript execution and compilation regression framework.
 * Native class for testing and regressing issues with native unrealscript classes.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */

class Test0010_NativeObject extends Object
	native
	implements(Test0002_InterfaceNative);
























































































































 



#linenumber 12

var Test0002_InterfaceNative InterfaceMember;

var array<Test0002_InterfaceNative> InterfaceArray;

struct native export ConstructorStructString
{
	var		string		StringNeedCtor;
	var		int			IntNoCtor;
	var 	Test0002_InterfaceNative InterfaceVar;
};

struct native export ConstructorStructArray
{
	var		int				IntNoCtor;
	var		array<string>	StringArrayNeedCtor;
};


struct native export ConstructorStructCombo
{
	var float			FloatNoCtor;
	var array<string>	StringArrayNeedCtor;
	var string			StringNeedCtor;
	var int				IntNoCtor;
};

struct native NoCtorProps
{
	var int Foo1;
	var bool Foo2;
	var float Foo3;
};

/**
 * This struct is for testing a bug with struct inheritance
 */
struct native MyFirstStruct
{
	var int MyFirstInt;
	var float MyFirstFloat;
	var string MyFirstString;
};

struct native MyStruct extends MyFirstStruct
{
	var	int MyInt;
	var float MyFloat;
	var string MyStrings[5];
};

var ConstructorStructString DefaultStringStruct;
var ConstructorStructArray DefaultArrayStruct;
var ConstructorStructCombo DefaultComboStruct;

var array<MyStruct> MyArray;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native final function PerformNativeTest( int TestNumber );


event Test01_CallEventWithStruct( NoCtorProps NoCtor, ConstructorStructString StringParm, ConstructorStructArray ArrayParm, ConstructorStructCombo ComboParm, bool PaddingBool )
{
	LogInternal("StringParm.StringNeedCtor:'"$StringParm.StringNeedCtor$"'"@"StringParm.IntNoCtor:'"$StringParm.IntNoCtor$"'");
	LogInternal("ArrayParm.StringArrayNeedCtor[0]:'"$ArrayParm.StringArrayNeedCtor[0]$"'"@"ArrayParm.IntNoCtor:'"$ArrayParm.IntNoCtor$"'");
	LogInternal("ComboParm.StringArrayNeedCtor[0]:'"$ComboParm.StringArrayNeedCtor[0]$"'"@"ComboParm.StringNeedCtor:'"$ComboParm.StringNeedCtor$"'"@"ComboParm.IntNoCtor:'"$ComboParm.IntNoCtor$"'");
}

native final function Test02_PassNativeInterfaceToNativeFunction( Test0002_InterfaceNative InterfaceParm );

event Test03_CallEventWithNativeInterface( Test0002_InterfaceNative InterfaceParm )
{
	LogInternal(Name$"::"$GetFuncName()@"InterfaceParm:'"$InterfaceParm$"'");
}

native function TestNativeFunction( bool bBoolParm );

//======================================================================================================================
event TestInterfaceEvent( object ObjParam )
{
	TestObjectToInterfaceConversions();

	LogInternal("InterfaceRef:");
	LogInternal(DefaultStringStruct.InterfaceVar);

	InterfaceArray.Insert(0,1);
	InterfaceArray[0] = Test0002_InterfaceNative(ObjParam);
}

function TestObjectToInterfaceConversions()
{
	local Test0002_InterfaceNative InterfaceLocal;

	if ( InterfaceMember == Self )
	{
		LogInternal("InterfaceMember is Self!");
	}
	if ( Self == InterfaceMember )
	{
		LogInternal("InterfaceMember is Self!");
	}

	LogInternal("InterfaceMember:");

	/**
	using primitiveCast instead of InterfaceCast, resolving to InterfaceToBool, rather than InterfaceToString
		execInterfaceToBool
		execInstanceVariable
	*/
	LogInternal(InterfaceMember);

	InterfaceLocal = None;
	if ( InterfaceMember != None )
	{
		InterfaceLocal = InterfaceMember;
		InterfaceMember = None;
	}

	if ( None == InterfaceMember )
	{
		LogInternal("Successful!");
	}

	if ( InterfaceMember == Self )
	{
		LogInternal("InterfaceMember is Self!");
	}

	if ( InterfaceLocal == Self )
	{
		LogInternal("InterfaceLocal is Self, Interface => Obj");
	}

	if ( Self == InterfaceLocal )
	{
		LogInternal("InterfaceLocal is Self, Obj => Interface");
	}

	LogInternal("InterfaceArray[0]:'"$InterfaceArray[0]$"'");
	LogInternal("InterfaceLocal:'"$InterfaceLocal$"'");
}

//======================================================================================================================

event Test05_StructInheritance()
{

	local int test;

	test = MyArray[0].MyInt;


	LogInternal("test:" @ test);

	LogInternal("MyArray[0].MyInt:" @ MyArray[0].MyInt);
	LogInternal("MyArray[0].MyFloat" @ MyArray[0].MyFloat);
	LogInternal("MyArray[0].MyStrings[0]:" @ MyArray[0].MyStrings[0]);
	LogInternal("MyArray[0].MyStrings[1]:" @ MyArray[0].MyStrings[1]);
	LogInternal("MyArray[0].MyStrings[2]:" @ MyArray[0].MyStrings[2]);
	LogInternal("MyArray[0].MyFirstInt:" @ MyArray[0].MyFirstInt); // dies here
	LogInternal("MyArray[0].MyFirstFloat:" @ MyArray[0].MyFirstFloat);
	LogInternal("MyArray[0].MyFirstString:" @ MyArray[0].MyFirstString);
}

//======================================================================================================================

event Test06_InterfaceToObjectConversions()
{
	local Object ObjectLocal;
	local Test0002_InterfaceNative InterfaceLocal;

    local int ValidateMemoryInt;

	// give this variable a non-zero value so we can detect if its value is being overwritten
	ValidateMemoryInt = 10;


	ObjectLocal = Self;
	InterfaceLocal = Self;

	// verify that assigning an interface variable to an object variable works correctly
	ObjectLocal = InterfaceLocal;

	// output should be "10", but will be a pointer value if interface => object assignment isn't working correctly
	LogInternal("ValidateMemoryInt:'"$ValidateMemoryInt$"'");


	// now verify that the script compiler disallows conversions in out parms
	TestInterfaceObject_OutParmCompatibility(ObjectLocal, InterfaceLocal);	// this should work.
	//TestInterfaceObject_OutParmCompatibility(InterfaceLocal, ObjectLocal);	// this should not work.

	VerifyConversionFromInterfaceToObjectAsNativeParm( InterfaceLocal, 10 );
}

function TestInterfaceObject_OutParmCompatibility( out Object out_Object, out Test0002_InterfaceNative out_Interface )
{
	if ( out_Object == out_Interface )
	{
		// nothing - just here to make sure the function isn't removed by optimization
	}
}

/**
 * this method exists to verify that passing an interface variable as the value for an object parameter of a native function
 * works correctly.
 * The value of DummyInt will be a pointer value if this test fails
 */
native final function VerifyConversionFromInterfaceToObjectAsNativeParm( Object InObject, int DummyInt );

defaultproperties
{
   DefaultStringStruct=(StringNeedCtor="StringNeedCtorValue",IntNoCtor=5)
   DefaultArrayStruct=(IntNoCtor=10,StringArrayNeedCtor=("Value1","Value2"))
   DefaultComboStruct=(StringArrayNeedCtor=("Value3","Value4"),StringNeedCtor="StringValue")
   Name="Default__Test0010_NativeObject"
   ObjectArchetype=Object'Core.Default__Object'
}
