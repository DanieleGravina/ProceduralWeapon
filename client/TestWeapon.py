from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############


ID = [0, 1]

#default Rof = 1
ROF = [2.03, 20]
#default Spread = 0
SPREAD = [0.86, 0.29]
#default MaxAmmo = 40
AMMO = [131, 492]
#deafult ShotCost = 1
SHOT_COST = [6, 3]
#defualt Range 10000
RANGE = [4, 29]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [206, 7297]
#default damage = 1
DMG = [89, 1]
#default damgae radius = 10
DMG_RAD = [79, 75]
#default gravity = 1
GRAVITY = [-23, 18]
EXPLOSIVE = [30, 55]

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


