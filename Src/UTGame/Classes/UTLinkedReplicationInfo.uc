/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTLinkedReplicationInfo extends ReplicationInfo
	abstract
	native
	nativereplication;

var UTLinkedReplicationInfo NextReplicationInfo;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	// Variables the server should send to the client.
	if ( bNetInitial && (Role==ROLE_Authority) )
		NextReplicationInfo;
}

defaultproperties
{
   NetUpdateFrequency=1.000000
   Name="Default__UTLinkedReplicationInfo"
   ObjectArchetype=ReplicationInfo'Engine.Default__ReplicationInfo'
}
