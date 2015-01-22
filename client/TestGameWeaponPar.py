from BalancedWeaponClient import BalancedWeaponClient
import time

#Test 
# 0 -> RocketLauncher
# 1 -> Flack tuned, flack normal

###############
# Weapon ######
###############

ID = [0, 1, 1]

#default Rof = 1
ROF = [1.05, 1.3, 1.1]
#default Spread = 0
SPREAD = [0.1, 0.23, 0.1]
#default MaxAmmo = 40
AMMO = [30, 218, 30]
#deafult ShotCost = 1
SHOT_COST = [1, 8, 9]
#defualt Range 10000
RANGE = [8, 17.4, 2]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [1350, 3937, 3500]
#default damage = 1
DMG = [100, 27, 18]
#default damgae radius = 10
DMG_RAD = [42, 18, 20]
#default gravity = 1
GRAVITY = [-1, -5.12, 0]
EXPLOSIVE = [220, 0, 0]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()

    for i in range(len(ID)):
        #client.SendWeaponParams(i, ROF[1 - i], SPREAD[1 - i], AMMO[1 - i], SHOT_COST[1 - i], RANGE[1 - i])
        #client.SendProjectileParams(SPEED[1 - i], DMG[1 - i], DMG_RAD[1 - i], GRAVITY[1 - i])
        client.SendWeaponParams(ID[i], ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i], EXPLOSIVE[i])

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()


