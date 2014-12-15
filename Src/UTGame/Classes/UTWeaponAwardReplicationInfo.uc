class UTWeaponAwardReplicationInfo extends ReplicationInfo;

var repnotify UTPlayerReplicationInfo WeaponAwards[10];

replication
{
	if (bNetDirty)
		WeaponAwards;
}

simulated event ReplicatedEvent(name VarName)
{
	local int i;
	local UTPlayerReplicationInfo PRI;

	if ( VarName == 'WeaponAwards' )
	{
		for( i=0; i<WorldInfo.GRI.PRIArray.Length; i++ )
		{
			PRI = UTPlayerReplicationInfo( WorldInfo.GRI.PRIArray[i] );
			if( PRI != none )
			{
				PRI.WeaponAwardIndex = -1;
			}
		}
		for ( i=0; i<10; i++ )
		{
			if ( WeaponAwards[i] != None )
			{
				WeaponAwards[i].WeaponAwardIndex = i;
			}
		}
	}
}
	

defaultproperties
{
   TickGroup=TG_DuringAsyncWork
   NetUpdateFrequency=1.000000
   LifeSpan=10.000000
   Name="Default__UTWeaponAwardReplicationInfo"
   ObjectArchetype=ReplicationInfo'Engine.Default__ReplicationInfo'
}
