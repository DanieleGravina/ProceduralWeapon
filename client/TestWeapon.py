from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#default Rof = 1
ROF = [2, 0.714]
#default Spread = 0
SPREAD = [0.1, 0.65]
#default MaxAmmo = 40
AMMO = [23, 365]
#deafult ShotCost = 1
SHOT_COST = [2, 2]
#defualt Range 10000
RANGE = [3.35, 0.52]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [17, 892]
#default damage = 1
DMG = [63, 18]
#default damgae radius = 10
DMG_RAD = [37, 23]
#default gravity = 1
GRAVITY = [-0.68, 0.06]

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


