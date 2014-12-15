/**
 * if( var == ENUM )
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0012_IfVarEqualEqualEnumDerivedClass extends Test0012_IfVarEqualEqualEnum
  dependson( Test0012_IfVarEqualEqualEnum );



function VarEqualEqualEnum()
{
    local SomeEnumFoo AnEnum;

    AnEnum = SEF_ValOne;

    if( AnEnum == SEF_ValOne )  // compiles
    {
       LogInternal("");
    }

}

function VarEqualEqualEnumTypeEnum()
{

    local SomeEnumFoo AnEnum;

    AnEnum = SEF_ValOne;

    //if( AnEnum == SomeEnumFoo.SEF_ValOne )  // does not compile
    //{
    //    `log( "" );
    //}

   LogInternal("AnEnum: " $ AnEnum);

}

defaultproperties
{
   Name="Default__Test0012_IfVarEqualEqualEnumDerivedClass"
   ObjectArchetype=Test0012_IfVarEqualEqualEnum'UnrealScriptTest.Default__Test0012_IfVarEqualEqualEnum'
}
