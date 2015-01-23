class TestLog extends Actor
	dependson(TestGame);

var FileWriter file;

var int ID;

var int LastWeaponID;

var string PlayerName;

//states
var int StateCurrent;

var float t0;

const SIMULATION = 0;
const ENDGAME  = 1;

struct WeaponLog{
	var float time;
	var Vector firePosition;
	var Rotator aim;
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
function int AddWeaponLog(vector firePosition, Rotator aim)
{
	if(StateCurrent == SIMULATION)
	{

		weaponLogs.add(1);

		weaponLogs[weaponLogs.length - 1].time = WorldInfo.TimeSeconds - t0;
		weaponLogs[weaponLogs.length - 1].firePosition = firePosition;
		weaponLogs[weaponLogs.length - 1].aim = aim;

		return weaponLogs.length - 1;

	}

	return 0;
}

function AddProjectileLog(vector HitLocation, bool bDamaged, bool bHasKilled, int IdWeapon)
{
	if(StateCurrent == SIMULATION)
	{

		projectileLogs.add(1);

		projectileLogs[projectileLogs.length - 1].time = WorldInfo.TimeSeconds - t0;
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

		inventoryLogs.add(1);

		if(LastWeaponID == 0){
			LastWeaponID = 1;
		}
		else{
			LastWeaponID = 0;
		}

		inventoryLogs[inventoryLogs.length - 1].time = WorldInfo.TimeSeconds - t0;
		inventoryLogs[inventoryLogs.length - 1].WeaponId = LastWeaponID;
	}

}


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

	if(file.OpenFile(("log" $ string(ID)), FWFT_Log, ".txt", true, true))
	{
		WriteWeaponParameters();

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

function WriteWeaponParameters()
{
	local array<PWParameters> weapPar;
	local array<PPParameters> projPar;
	local int i;

	weapPar = TestGame(WorldInfo.Game).GetPWParameters(PlayerName);
	projPar = TestGame(WorldInfo.Game).GetPPParameters(PlayerName);

	file.Logf("Player : "$PlayerName);

	for(i = 0; i < weapPar.length; i++)
	{

		file.Logf("ID :" $ string(i));
		file.Logf("Rof " $ string(weapPar[i].RoF));
		file.Logf("Spread " $ string(weapPar[i].Spread));
		file.Logf("MaxAmmo " $ string(weapPar[i].MaxAmmo));
		file.Logf("Shotcost " $ string(weapPar[i].Shotcost));
		file.Logf("Range " $ string(weapPar[i].Range));

		file.Logf("Speed " $ string(projPar[i].Speed));
		file.Logf("Damage " $ string(projPar[i].Damage));
		file.Logf("DamageRadius " $ string(projPar[i].DamageRadius));
		file.Logf("Gravity " $ string(projPar[i].Gravity));
		file.Logf("Explosion " $ string(projPar[i].Explosive));
	}

}

function writeWeapon(WeaponLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "fire_position: " $ string(l.firePosition));
	file.Logf( "aim: " $ string(l.aim));
	file.Logf( "\n");
}

function writeProjectile(ProjectileLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "time_weapon: " $ string(l.timeWeapon));
	file.Logf( "hit_location: " $ string(l.HitLocation));
	file.Logf( "has_hit: " $ string(l.bDamaged));
	file.Logf( "has_killed: " $string(l.bHasKilled));
	file.Logf( "\n");
}

function writeInventory(InventoryLog l)
{
	file.Logf( "[" $ string(l.time) $ "]");
	file.Logf( "switch_to: " $ string(l.WeaponId));
	file.Logf( "\n");
}


defaultproperties
{
	LastWeaponID = 0

	t0 = 0

	StateCurrent = SIMULATION;
}