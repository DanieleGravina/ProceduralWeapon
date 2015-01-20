from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [0.83, 2.51]
#default Spread = 0
SPREAD = [0.99, 0.04]
#default MaxAmmo = 40
AMMO = [336, 16]
#deafult ShotCost = 1
SHOT_COST = [3, 2]
#defualt Range 10000
RANGE = [9.88, 10.8]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [10, 4446]
#default damage = 1
DMG = [50, 74]
#default damgae radius = 10
DMG_RAD = [31, 6]
#default gravity = 1
GRAVITY = [0.14, 0.04]

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


