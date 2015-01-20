class ProceduralProjectile extends UTProjectile;

var TestLog myLog;
var int IdWeapon;

function SetTestLog(TestLog log, int IdWeap)
{
    myLog = log;
    IdWeapon = IdWeap;
}

simulated function Init(vector Direction)
{
	local string playerName;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	TestGame(WorldInfo.Game).SetPPParameters(playerName);
	
	AccelRate = TestGame(WorldInfo.Game).GetPPParameters().Speed;
	Damage = TestGame(WorldInfo.Game).GetPPParameters().Damage;
	bWideCheck = true;
	CheckRadius = TestGame(WorldInfo.Game).GetPPParameters().DamageRadius;
	TossZ = TestGame(WorldInfo.Game).GetPPParameters().Gravity;
	LifeSpan = TestGame(WorldInfo.Game).GetPWParameters().Range;

	Speed = AccelRate;
	
	MaxSpeed = Speed;

/*
	`log("[ProceduralProjectile] AccelRate "$string(AccelRate));
	`log("[ProceduralProjectile] Damage "$string(Damage));
	`log("[ProceduralProjectile] CheckRadius "$string(CheckRadius));
	`log("[ProceduralProjectile] TossZ "$string(TossZ));
	`log("[ProceduralProjectile] LifeSpan "$string(LifeSpan));	
*/
	Super.Init(Direction);
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	local bool bHasKilled;
	local string killer, killed;

	if(myLog != None)
	{
		killer = InstigatorController.PlayerReplicationInfo.playername;
		killed = PWPawn(Other).PlayerReplicationInfo.playername;
	}

	bHasKilled = false;

	Super.ProcessTouch(Other, HitLocation, HitNormal);

	if(myLog != None)
	{
		if(PWPawn(Other).Health <= 0)
		{
			bHasKilled = true;
		}

		myLog.AddProjectileLog(HitLocation, true, bHasKilled, IdWeapon);

		if(bHasKilled)
		{
			TestGame(WorldInfo.Game).SendPawnDied(killed, killer);
		}
	}
}

simulated singular event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	if(myLog != None)
	{
		myLog.AddProjectileLog(Wall.Location, false, false, IdWeapon);
	}

	ImpactedActor = Wall;

	if ( !Wall.bStatic && !Wall.bWorldGeometry )
	{
		if ( DamageRadius == 0 )
		{
			Wall.TakeDamage( Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		}
	}

	Explode(Location, HitNormal);
	ImpactedActor = None;
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
   MyDamageType=Class'Test.UTDmgType_Procedural'
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