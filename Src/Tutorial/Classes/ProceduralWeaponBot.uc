class ProceduralWeaponBot extends UTBot;

function Initialize(float InSkill, const out CharacterInfo BotInfo)
{
	Super.Initialize(InSkill, BotInfo);

	Aggressiveness = 1;
	BaseAggressiveness = Aggressiveness;
	Accuracy = 1;
	StrafingAbility = 1;
	CombatStyle = 1;
	Jumpiness = 0.25;
	Tactics = 1;
	ReactionTime = 0;

	`log("[ProcWeapBot] Initialize bot with default pars, skill: "$string(InSkill));
}