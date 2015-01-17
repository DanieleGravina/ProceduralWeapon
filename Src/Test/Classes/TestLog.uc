class TestLog extends Actor;

var FileWriter file;

var string PlayerName;

var int LastWeaponID;

//states
var int StateCurrent;

const SIMULATION = 0;
const ENDGAME  = 1;

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

var array<WeaponLog> weaponLogs;
var array<ProjectileLog> projectileLogs;
var array<InventoryLog> inventoryLogs;

/*Add log of weapon firing, return the index for projectile identification*/
function int AddWeaponLog(vector firePosition, vector aim, int shotcount)
{
	if(StateCurrent == SIMULATION)
	{
		`log("[TestLog] Add Weapon log");

		weaponLogs.add(1);

		weaponLogs[weaponLogs.length - 1].time = WorldInfo.TimeSeconds;
		weaponLogs[weaponLogs.length - 1].firePosition = firePosition;
		weaponLogs[weaponLogs.length - 1].aim = aim;
		weaponLogs[weaponLogs.length - 1].shotcount = shotcount;

		return weaponLogs.length - 1;

	}
}

function AddProjectileLog(vector HitLocation, bool bDamaged, bool bHasKilled, int IdWeapon)
{
	if(StateCurrent == SIMULATION)
	{
		`log("[TestLog] Add projectileLog log");

		projectileLogs.add(1);

		projectileLogs[projectileLogs.length - 1].time = WorldInfo.TimeSeconds;
		projectileLogs[projectileLogs.length - 1].timeWeapon = weaponLogs[IdWeapon].time;
		projectileLogs[projectileLogs.length - 1].hitLocation = HitLocation;
		projectileLogs[projectileLogs.length - 1].bDamaged = bDamaged;
		projectileLogs[projectileLogs.length - 1].bHasKilled = bHasKilled;
	}

}

function addInventoryLog()
{
	if(StateCurrent == SIMULATION)
	{
		`log("[TestLog] Add inventoryLog log");

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

}

//TODO
function WriteLog(string statistics)
{
	local int i, j, k;
	local bool bFinish;

	i = 0;
	j = 0;
	k = 0;

	StateCurrent = ENDGAME;

	bFinish = false;

	file = Spawn(class'FileWriter');

	if(file.OpenFile(("log" $ PlayerName), FWFT_Log, ".txt", true, true))
	{
		while(!bFinish)
		{
			if( i < weaponLogs.length)
			{
				if(j < projectileLogs.length && projectileLogs[j].time < weaponLogs[i].time)
				{
					if(k < inventoryLogs.length && inventoryLogs[k].time < projectileLogs[j].time)
					{
						writeInventory(inventoryLogs[k]);
						k++;
					}
					else
					{
						writeProjectile(projectileLogs[j]);
						j++;
					}
				}
				else
				{
					if(k < inventoryLogs.length && inventoryLogs[k].time < weaponLogs[i].time)
					{
						writeInventory(inventoryLogs[k]);
						k++;
					}
					else
					{
						writeWeapon(weaponLogs[i]);
						i++;
					}
				}
			}
			else
			{
				if(j < projectileLogs.length)
				{
					if(k < inventoryLogs.length && inventoryLogs[k].time < projectileLogs[j].time)
					{
						writeInventory(inventoryLogs[k]);
						k++;
					}
					else
					{
						writeProjectile(projectileLogs[j]);
						j++;
					}	
				}
				else{

					if(k < inventoryLogs.length)
					{
						writeInventory(inventoryLogs[k]);
						k++;
					}
					else
					{
						bFinish = true;
					}

				}
			}
		}

		file.Logf(statistics);

		file.CloseFile();
	}


}

function writeWeapon(WeaponLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "fire_position: " $ string(l.firePosition));
	file.Logf( "aim: " $ string(l.aim));
	file.Logf( "shot_count: " $string(l.shotcount));
}

function writeProjectile(ProjectileLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "time_weapon: " $ string(l.timeWeapon));
	file.Logf( "hit_location: " $ string(l.HitLocation));
	file.Logf( "has_hit: " $ string(l.bDamaged));
	file.Logf( "has_killed: " $string(l.bHasKilled));
}

function writeInventory(InventoryLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "switch_to: " $ string(l.WeaponId));
}


defaultproperties
{
	LastWeaponID = 0

	StateCurrent = SIMULATION;
}