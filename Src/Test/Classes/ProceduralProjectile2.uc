class ProceduralProjectile2 extends ProceduralProjectile;

var vector myDirection;

function SetProceduralProjectile(int WeaponID)
{
	local string playerName;
	local array<PWParameters> weaponPars;
	local array<PPParameters> projPars;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	weaponPars = TestGame(WorldInfo.Game).GetPWParameters(playerName);
	projPars = TestGame(WorldInfo.Game).GetPPParameters(playerName);
	
	Speed = projPars[WeaponID].Speed;
	Damage = projPars[WeaponID].Damage;
	bWideCheck = true;
	CheckRadius = projPars[WeaponID].DamageRadius;
	LifeSpan = weaponPars[WeaponID].Range;
	DamageRadius = projPars[WeaponID].Explosive;

	Velocity += Normal(myDirection)*Speed;

    MaxSpeed = Speed;

    Acceleration.Z = projPars[WeaponID].Gravity;
}

function Init(vector Direction)
{
	myDirection = Direction;
	super.Init(Direction);
}

defaultproperties
{
   Physics = PHYS_Falling
   AccelRate = 0
}