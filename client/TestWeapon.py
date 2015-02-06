from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############


ID = [0, 1]

#default Rof = 1
ROF = [1.26, 2.19]
#default Spread = 0
SPREAD = [1.29, 1.86]
#default MaxAmmo = 40
AMMO = [958, 381]
#deafult ShotCost = 1
SHOT_COST = [9, 8]
#defualt Range 10000
RANGE = [41.49, 12.92]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [8775, 1436]
#default damage = 1
DMG = [60, 54]
#default damgae radius = 10
DMG_RAD = [21, 26]
#default gravity = 1
GRAVITY = [-100, -63]
EXPLOSIVE = [7, 12]

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


