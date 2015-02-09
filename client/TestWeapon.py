from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

ID = [0, 1]

#default Rof = 1
ROF = [2.46, 0.92]
#default Spread = 0
SPREAD = [0.44, 0.45]
#default MaxAmmo = 40
AMMO = [406, 918]
#deafult ShotCost = 1
SHOT_COST = [8, 4]
#defualt Range 10000
RANGE = [55, 18]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [4258, 2883]
#default damage = 1
DMG = [85, 57]
#default damgae radius = 10
DMG_RAD = [80, 81]
#default gravity = 1
GRAVITY = [0, 6]
EXPLOSIVE = [1.5, 11]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendMaxDuration(1200)
    client.SendGoalScore(30)

    for i in range(2):
        client.SendWeaponParams(i, ROF[1 - i], SPREAD[1 - i], AMMO[1 - i], SHOT_COST[1 - i], RANGE[1 - i])
        client.SendProjectileParams(SPEED[1 - i], DMG[1 - i], DMG_RAD[1 - i], GRAVITY[1 - i], EXPLOSIVE[1 - i])
        #client.SendWeaponParams(ID[i], ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        #client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i], EXPLOSIVE[i])

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()


