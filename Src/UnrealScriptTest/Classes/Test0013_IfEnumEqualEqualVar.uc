/**
 * if( ENUM == var )
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 **/

class Test0013_IfEnumEqualEqualVar extends Object;


enum SomeEnumFoo
{
	SEF_ValOne,
	SEF_ValTwo
};


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

    if( SomeEnumFoo.SEF_ValOne == AnEnum )
    {
       LogInternal("");
    }

      LogInternal("AnEnum: " $ AnEnum);
}

defaultproperties
{
   Name="Default__Test0013_IfEnumEqualEqualVar"
   ObjectArchetype=Object'Core.Default__Object'
}
