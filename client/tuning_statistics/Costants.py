# num bot in the server side
NUM_BOTS = 2

#server listen ports
PORT1 = 3742
PORT2 = 3743
PORT3 = 3744
PORT4 = 3745
PORT5 = 3746

INITIAL_PORT = [PORT1, PORT2, PORT3, PORT4, PORT5, 3747, 3748, 3749, 3750, 3751]
PORT = INITIAL_PORT

#num of server
NUM_SERVER = 10

MAX_DURATION = 1200
GOAL_SCORE = 30

TIMEOUT = 200 #1200 : 8 (MAX_DURATION / GAMESPEED)



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