class ProceduralProjectile2 extends ProceduralProjectile;

var int myWeaponID;

function SetProceduralProjectile(int WeaponID)
{
	myWeaponID = WeaponID;
}

function Init(vector Direction)
{
	local string playerName;
	local array<PWParameters> weaponPars;
	local array<PPParameters> projPars;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	weaponPars = TestGame(WorldInfo.Game).GetPWParameters(playerName);
	projPars = TestGame(WorldInfo.Game).GetPPParameters(playerName);
	
	Speed = projPars[myWeaponID].Speed;
	Damage = projPars[myWeaponID].Damage;
	bWideCheck = true;
	CheckRadius = projPars[myWeaponID].DamageRadius;
	LifeSpan = weaponPars[myWeaponID].Range;
	DamageRadius = projPars[myWeaponID].Explosive;

    Velocity += Normal(Direction)*Speed;

    MaxSpeed = Speed;

    Acceleration.Z = projPars[myWeaponID].Gravity;
}

defaultproperties
{
   myWeaponID = 0
   Physics = PHYS_Falling
   AccelRate = 0
}