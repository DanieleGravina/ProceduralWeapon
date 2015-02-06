# num bot in the server side
NUM_BOTS = 2

INITIAL_PORT = [3742, 3743, 3744, 3745, 3746, 3747, 3748, 3749, 3750, 3751]
PORT = INITIAL_PORT

#num of server
NUM_SERVER = 10

MAX_DURATION = 1800
GOAL_SCORE = 30

TIMEOUT = 100000 #1200 : 8 (MAX_DURATION / GAMESPEED)



###############
# Weapon ######
###############

#default Rof = 100
ROF_MIN, ROF_MAX = 10, 1000
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 300
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 999
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 9
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 100, 10000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 1, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 0, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = -100, 100
#Explosion
EXPLOSIVE_MIN, EXPLOSIVE_MAX = 0, 300


DELTA_TIME = 2
DISTANCE = 3
KILL_STREAK = 4

MAXIMIZE = 1.0
MINIMIZE = -1.0

Weapons = []

		   #Rof Spread Ammo ShotCost Range Speed Dmg DmgRad Gravity Explosive

		   #Rocket Launcher

Weapons += [[1.05,  0.1,     30,      1,     8, 1350, 100,       42,      -1, 220]]

			#Flack

Weapons += [[1.1,   0.1,   30,      9,     2, 3500,  18,       20,      0, 0]]