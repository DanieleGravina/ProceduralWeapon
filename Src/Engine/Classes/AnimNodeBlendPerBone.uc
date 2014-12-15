/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class AnimNodeBlendPerBone extends AnimNodeBlend
	native(Anim);


/** If TRUE, blend will be done in local space. */
var()	const		bool			bForceLocalSpaceBlend;

/** List of branches to mask in from child2 */
var()				Array<Name>		BranchStartBoneName;

/** per bone weight list, built from list of branches. */
var					Array<FLOAT>	Child2PerBoneWeight;

/** Required bones for local to component space conversion */
var					Array<BYTE>		LocalToCompReqBones;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Children(0)=(Name="Source")
   Children(1)=(Name="Target")
   Name="Default__AnimNodeBlendPerBone"
   ObjectArchetype=AnimNodeBlend'Engine.Default__AnimNodeBlend'
}
