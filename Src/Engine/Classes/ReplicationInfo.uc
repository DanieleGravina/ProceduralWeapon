//=============================================================================
// ReplicationInfo.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ReplicationInfo extends Info
	abstract
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   RemoteRole=ROLE_SimulatedProxy
   bAlwaysRelevant=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__ReplicationInfo"
   ObjectArchetype=Info'Engine.Default__Info'
}
