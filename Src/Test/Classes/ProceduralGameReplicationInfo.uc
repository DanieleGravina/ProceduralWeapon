class ProceduralGameReplicationInfo extends UTGameReplicationInfo
	DependsOn(TestGame);

const NUM_BOTS = 2;

/* array of weapon parameters */
var BotParTriple mapBotPar[NUM_BOTS];

var PPParameters tempPP;
var PWParameters tempPW;

simulated function SetPWParameters(string botName)
{
	local int i;
	
	for(i = 0; i < NUM_BOTS; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPW =  mapBotPar[i].weapPars;
			break;
		}
	}
	
}

simulated function SetPPParameters(string botName)
{
	local int i;
	
	for(i = 0; i < NUM_BOTS; ++i)
	{
		if(mapBotPar[i].botName == botName)
		{
			tempPP = mapBotPar[i].projPars;
			break;
		}
	}	
	
}

simulated function PWParameters GetPWParameters()
{
	return tempPW;
}

simulated function PPParameters GetPPParameters()
{
	return tempPP;
}

replication
{
	if (bNetInitial || bNetDirty)
		mapBotPar ;

}