class ProceduralWeaponBot extends UTBot;

//Simulation uses only one type of bot
function Initialize(float InSkill, const out CharacterInfo BotInfo)
{
	local UTPlayerReplicationInfo PRI;
	local CustomCharData BotCharData;

	Skill = FClamp(InSkill, 0, 7);

	Aggressiveness = -0.95;
	BaseAggressiveness = Aggressiveness;
	Accuracy = -4.5;
	StrafingAbility = 1;
	CombatStyle = 0.5;
	Jumpiness = -1;
	Tactics = 0;
	ReactionTime = 0;

	// copy visual properties
	PRI = UTPlayerReplicationInfo(PlayerReplicationInfo);
	if (PRI != None)
	{
		// If we have no 'based on' char ref, just fill it in with this char. Thing like VoiceClass look at this.
		BotCharData = BotInfo.CharData;
		if(BotCharData.BasedOnCharID == "")
		{
			BotCharData.BasedOnCharID = BotInfo.CharID;
		}

		PRI.SetCharacterData(BotCharData);
	}

	ResetSkill();

	`log("[ProcWeapBot] Initialize bot with default pars, skill: "$string(Skill));
}