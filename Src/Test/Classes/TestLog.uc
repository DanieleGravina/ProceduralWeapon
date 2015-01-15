class TestLog extends Actor;

FileWriter file;

string PlayerName;

var int LastWeaponID;

struct WeaponLog{
	var float time;
	var Vector firePosition;
	var Vector aim;
	var int shotcount;
};

struct ProjectileLog
{
	var float time;
	var float timeWeapon;
	var Vector hitLocation;
	var bool bDamaged;
	var bool bHasKilled;
};

struct InventoryLog
{
	var float time;
	var int WeaponId;
};

array<WeaponLog> weaponLogs;
array<ProjectileLog> projectileLogs;
array<InventoryLog> inventoryLogs;

function addWeaponLog(vector firePosition, vector aim, int shotcount)
{
	weaponLogs.add(1);

	weaponLogs[weaponLogs.length - 1].time = WorldInfo.TimeSeconds;
	weaponLogs[weaponLogs.length - 1].firePosition = firePosition;
	weaponLogs[weaponLogs.length - 1].aim = aim;
	weaponLogs[weaponLogs.length - 1].shotcount = shotcount;
}

function addProjectileLog(vector HitLocation, bool bDamaged, bool bHasKilled)
{
	ProjectileLog.add(1);

	projectileLogs[projectileLogs.length - 1].time = WorldInfo.TimeSeconds;
	projectileLogs[projectileLogs.length - 1].timeWeapon = weaponLogs[weaponLogs.length - 1].time;
	projectileLogs[projectileLogs.length - 1].hitLocation = HitLocation;
	projectileLogs[projectileLogs.length - 1].bDamaged = bDamaged;
	projectileLogs[projectileLogs.length - 1].bHasKilled = bHasKilled;

}

function addInventoryLog()
{
	inventoryLogs.add(1);

	if(LastWeaponID == 0){
		LastWeaponID = 1;
	}
	else{
		LastWeaponID = 0;
	}

	inventoryLogs[inventoryLogs.length - 1].time = WorldInfo.TimeSeconds;
	inventoryLogs[inventoryLogs.length - 1].WeaponId = LastWeaponID;

}

//TODO
function WriteLog()
{
	if(OpenFile("log" $ PlayerName, FWFileType.FWFT_Log, "txt", true, true))
	{
		for(i = 0; i < weaponLogs.length; i++)
		{
			Logf( "[" $ string(weaponLogs[i].time $ "]")
			Logf( "fire_position: " $ string([i].firePosition))
			Logf( "aim: " $ string(weaponLogs[i].aim))
			Logf( "shot_count: " $string(weaponLogs[i].shotcount))

			for(j = 0; j < projectileLogs.length; j++)
			{
				if(projectileLogs[projectileLogs.length - 1].timeWeapon == weaponLogs[weaponLogs.length - 1].time)
				{
					Logf( "[" $ string(projectileLogs[i].time $ "]")
					Logf( "hit_location: " $ string(projectileLogs[i].HitLocation))
					Logf( "has_hit: " $ string(projectileLogs[i].bDamaged))
					Logf( "has_killed: " $string(projectileLogs[i].bHasKilled))
				}
			}
		}

	}	


}


defaultproperties
{
	LastWeaponID = 0
}