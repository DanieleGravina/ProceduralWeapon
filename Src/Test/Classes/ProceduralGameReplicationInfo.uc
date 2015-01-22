class ProceduralGameReplicationInfo extends UTGameReplicationInfo
	DependsOn(TestGame);

const NUM_WEAPON = 4;

/* array of weapon parameters */
var BotParTriple mapBotPar[NUM_WEAPON];

simulated function array<PWParameters> GetPWParameters(string botName)
{
	local int i;
	local array<PWParameters> result;
	
	for(i = 0; i < NUM_WEAPON; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			result.Add(1);
			result[result.length - 1] =  mapBotPar[i].weapPars;
		}
	}

	return result;
	
}

simulated function array<PPParameters> GetPPParameters(string botName)
{
	local int i;
	local array<PPParameters> result;
	
	for(i = 0; i < NUM_WEAPON; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			result.Add(1);
			result[result.length - 1] =  mapBotPar[i].projPars;
		}
	}

	return result;
}

replication
{
	if (bNetInitial || bNetDirty)
		mapBotPar ;

}