/**
 * if( ENUM == var )
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0013_IfEnumEqualEqualVarDerivedClass extends Test0013_IfEnumEqualEqualVar
   dependson( Test0013_IfEnumEqualEqualVar );



function EnumEqualEqualVar()
{

    local SomeEnumFoo AnEnum;

    AnEnum = SEF_ValOne;

 //   if( SEF_ValOne == AnEnum )  // does not compile
 //   {
 //      `log( "" );
 //   }

      LogInternal("AnEnum: " $ AnEnum);

}



function EnumTypeEnumEqualEqualVar()
{

    local SomeEnumFoo AnEnum;

    AnEnum = SEF_ValOne;

    //if( SomeEnumFoo.SEF_ValOne == AnEnum ) // does not compile
    //{
    //   `log( "" );
    //}

      LogInternal("AnEnum: " $ AnEnum);

}

defaultproperties
{
   Name="Default__Test0013_IfEnumEqualEqualVarDerivedClass"
   ObjectArchetype=Test0013_IfEnumEqualEqualVar'UnrealScriptTest.Default__Test0013_IfEnumEqualEqualVar'
}
