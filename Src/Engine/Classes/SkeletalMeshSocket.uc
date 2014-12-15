/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SkeletalMeshSocket extends Object
	native
	hidecategories(Object)
	hidecategories(Actor);
	
/** 
 *	Defines a named attachment location on the SkeletalMesh. 
 *	These are set up in editor and used as a shortcut instead of specifying 
 *	everything explicitly to AttachComponent in the SkeletalMeshComponent.
 *	The Outer of a SkeletalMeshSocket should always be the SkeletalMesh.
 */

var()	const editconst	name			SocketName;
var()	const editconst name			BoneName;
var()					vector			RelativeLocation;
var()					rotator			RelativeRotation;
var()					vector			RelativeScale;
	
var()	editoronly					SkeletalMesh			PreviewSkelMesh;
var()	const editconst	transient	SkeletalMeshComponent	PreviewSkelComp;
var()	editoronly					StaticMesh				PreviewStaticMesh;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   RelativeScale=(X=1.000000,Y=1.000000,Z=1.000000)
   Name="Default__SkeletalMeshSocket"
   ObjectArchetype=Object'Core.Default__Object'
}
