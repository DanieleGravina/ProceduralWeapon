from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [6.89, 0.1]
#default Spread = 0
SPREAD = [2.6, 2]
#default MaxAmmo = 40
AMMO = [37, 152]
#deafult ShotCost = 1
SHOT_COST = [8, 1]
#defualt Range 10000
RANGE = [94, 2]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [3138, 500]
#default damage = 1
DMG = [57, 100]
#default damgae radius = 10
DMG_RAD = [97, 100]
#default gravity = 1
GRAVITY = [-6.49, 10.51]

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


