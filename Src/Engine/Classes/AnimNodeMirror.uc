/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class AnimNodeMirror extends AnimNodeBlendBase
	native(Anim)
	hidecategories(Object);

var()	bool	bEnableMirroring;
	
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
	

defaultproperties
{
   bEnableMirroring=True
   Children(0)=(Name="Child",Weight=1.000000)
   bFixNumChildren=True
   Name="Default__AnimNodeMirror"
   ObjectArchetype=AnimNodeBlendBase'Engine.Default__AnimNodeBlendBase'
}
