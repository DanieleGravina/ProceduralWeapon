from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [1.08, 0.5]
#default Spread = 0
SPREAD = [2.18, 0.5]
#default MaxAmmo = 40
AMMO = [457, 145]
#deafult ShotCost = 1
SHOT_COST = [1.43, 9]
#defualt Range 10000
RANGE = [1, 98.28]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [2527, 1000]
#default damage = 1
DMG = [84, 19]
#default damgae radius = 10
DMG_RAD = [0, 96]
#default gravity = 1
GRAVITY = [13.63, -19.71]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()

    for i in range(2):
        #client.SendWeaponParams(i, ROF[1 - i], SPREAD[1 - i], AMMO[1 - i], SHOT_COST[1 - i], RANGE[1 - i])
        #client.SendProjectileParams(SPEED[1 - i], DMG[1 - i], DMG_RAD[1 - i], GRAVITY[1 - i])
        client.SendWeaponParams(i, ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i])

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()

