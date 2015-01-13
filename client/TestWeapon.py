from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [9.7, 2.98]
#default Spread = 0
SPREAD = [0.36, 2.2]
#default MaxAmmo = 40
AMMO = [14, 530]
#deafult ShotCost = 1
SHOT_COST = [9, 10]
#defualt Range 10000
RANGE = [48.9, 74.79]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [5757, 7851]
#default damage = 1
DMG = [87, 64]
#default damgae radius = 10
DMG_RAD = [14, 72]
#default gravity = 1
GRAVITY = [-4.96, 9.65]

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


