class ProceduralProjectile extends UTProjectile;

function Init(vector Direction)
{
	local string playerName;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	AccelRate = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Damage;
	CheckRadius = ServerGame(WorldInfo.Game).GetPPParameters(playerName).DamageRadius;
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
	CheckRadius = ServerGame(WorldInfo.Game).GetPPParameters(playerName).DamageRadius;
	TossZ = ServerGame(WorldInfo.Game).GetPPParameters(playerName).Gravity;
	LifeSpan = ServerGame(WorldInfo.Game).GetPWParameters(playername).Range;
	
	MaxSpeed = Speed;
	
}

defaultproperties
{
   bCheckProjectileLight=True
   AmbientSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireTravelCue'
   ExplosionSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue'
   ProjFlightTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
   ProjExplosionTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball_Impact'
   MaxEffectDistance=7000.000000
   CheckRadius=40.000000
   ProjectileLightClass=Class'UTGame.UTShockBallLight'
   Speed=1150.000000
   MaxSpeed=1150.000000
   Damage=55.000000
   MomentumTransfer=70000.000000
   MyDamageType=Class'Tutorial.UTDmgType_Procedural'
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bNetTemporary=False
   bCollideComplex=False
   bProjTarget=True
   LifeSpan=8.000000
   CollisionComponent=CollisionCylinder
   Name="Default__Procedural_Projectile"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}