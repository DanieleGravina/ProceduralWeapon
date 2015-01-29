class ProceduralProjectile2 extends ProceduralProjectile;

function Init(vector Direction)
{
	local string playerName;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	ServerGame(WorldInfo.Game).SetPPParameters(playerName);
	
	Speed = ServerGame(WorldInfo.Game).GetPPParameters().Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters().Damage;
	bWideCheck = true;
	CheckRadius = ServerGame(WorldInfo.Game).GetPPParameters().DamageRadius;
	LifeSpan = ServerGame(WorldInfo.Game).GetPWParameters().Range;
	DamageRadius = ServerGame(WorldInfo.Game).GetPPParameters().Explosive;

   Velocity += Normal(Direction)*Speed;

   MaxSpeed = Speed;

   Acceleration.Z = ServerGame(WorldInfo.Game).GetPPParameters().Gravity;

/*
	`log("[ProceduralProjectile] AccelRate "$string(AccelRate));
	`log("[ProceduralProjectile] Damage "$string(Damage));
	`log("[ProceduralProjectile] CheckRadius "$string(CheckRadius));
	`log("[ProceduralProjectile] TossZ "$string(TossZ));
	`log("[ProceduralProjectile] LifeSpan "$string(LifeSpan));	
*/
}

defaultproperties
{
   Physics = PHYS_Falling
   AccelRate = 0
}