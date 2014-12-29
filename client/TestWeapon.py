from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [1, 1]
#default Spread = 0
SPREAD = [0.5, 0.5]
#default MaxAmmo = 40
AMMO = [999, 999]
#deafult ShotCost = 1
SHOT_COST = [55, 54]
#defualt Range 10000
RANGE = [50, 100]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [523, 20]
#default damage = 1
DMG = [61, 58]
#default damgae radius = 10
DMG_RAD = [35, 44]
#default gravity = 1
GRAVITY = [0, 0]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()

    for i in range(2):
        client.SendWeaponParams(i, ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i])

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()


