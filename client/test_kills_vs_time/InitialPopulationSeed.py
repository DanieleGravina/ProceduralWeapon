import random

NUM_WEAPONS = 9

selected = 0


Weapons = []

		   #Rof Spread Ammo ShotCost Range Speed Dmg DmgRad Gravity 
Weapons += [[1,   0,      100,      1,     2, 1000,  10,       20,      0]]

Weapons += [[1.1,   0.1,   30,      1,     2, 3500,  18,       20,      0]]

#Enforcer
Weapons += [[0.36,  0.03, 100,      1,     2, 10000, 10,       20,      0]]

#Sniper
Weapons += [[1.33,  0,     40,      1,     10, 20000, 50,       20,      0]]

#Rocket launcher
Weapons += [[1.05,  0.5,     30,      1,     8, 1350, 100,       42,      -1]]

#Avril
Weapons += [[4,     0,     15,      1,       8, 500,  100,         20,      -2]]

#Instagib
Weapons += [[1.1,     0,     1,      0,     8, 20000,  1000,         20,      0]]

#Link Gun
Weapons += [[0.16,     0,     220,      1,     3, 5000,  26,         24,      0]]

#Shock rifle
Weapons += [[0.6,     0,     50,      1,     3, 1150,  55,         40,      0]]

available = [i for i in range(len(Weapons))]

def getTwoSeedWeapons():

	global available

	if len(available) == 0:
		available = [i for i in range(len(Weapons))]

	i = random.randint(0, len(available) - 1)
	index_first = available[i]
	available.remove(available[i])

	if len(available) == 0:
		available = [i for i in range(len(Weapons))]

	j = random.randint(0, len(available) - 1)
	index_second = available[j]
	available.remove(available[j])

	return Weapons[index_first] + Weapons[index_second]

