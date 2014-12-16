class ProceduralProjectile extends UTProj_ShockBall;

function Init(vector Direction)
{
	local string playerName;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	Speed = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Damage;
	DamageRadius = ServerGame(WorldInfo.Game).GetPPParameters(playerName).DamageRadius;
	TossZ = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Gravity;
	LifeSpan = ServerGame(WorldInfo.Game).GetPWParameters(playername).Range;
	
	MaxSpeed = Speed;

	Super.Init(Direction);
}

function Initialize()
{
	local string playerName;
	
	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	AccelRate = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Damage;
	DamageRadius = ServerGame(WorldInfo.Game).GetPPParameters(playerName).DamageRadius;
	TossZ = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Gravity;
	LifeSpan = ServerGame(WorldInfo.Game).GetPWParameters(playername).Range;
	
	MaxSpeed = Speed;
	
}

defaultproperties
{
}