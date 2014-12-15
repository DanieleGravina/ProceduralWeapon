/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_SetCustomCharPart extends SequenceAction;

var()	UTCustomChar_Data.ECharPart		Part;
var()	string							PartID;

defaultproperties
{
   ObjName="Set Character Part"
   ObjCategory="CustomChar"
   Name="Default__UTSeqAct_SetCustomCharPart"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
