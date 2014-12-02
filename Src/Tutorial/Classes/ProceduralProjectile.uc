class ProceduralProjectile extends UTProj_ShockBall;

function Initialize()
{
	local string playerName;
	
	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	Speed = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Damage;
	DamageRadius = ServerGame(WorldInfo.Game).GetPPParameters(playerName).DamageRadius;
	CustomGravityScaling = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Gravity;
	
	MaxSpeed = Speed;
	
}

defaultproperties
{
}