from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

#Test (test multi tuning 4)
# 0 -> 1 tune test 3 (low speed), 2 flack
# 1 -> 1 tune test 3 (low range), 2 rocket launcher


ID = [1, 0, 0, 1]

#default Rof = 1
ROF = [0.14, 1.1, 0.72, 1.05]
#default Spread = 0
SPREAD = [0.06, 0.1, 0.44, 0.1]
#default MaxAmmo = 40
AMMO = [50, 30, 395, 30]
#deafult ShotCost = 1
SHOT_COST = [1, 9, 7, 1]
#defualt Range 10000
RANGE = [5.18, 2, 0.43, 8]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [8, 3500, 677, 1350]
#default damage = 1
DMG = [63, 18, 17, 100]
#default damgae radius = 10
DMG_RAD = [45, 20, 21, 42]
#default gravity = 1
GRAVITY = [-0.02, 16.76, -0.72, -1]

EXPLOSIVE = [0, 0, 0, 220]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()

    for i in range(len(ID)):
        client.SendWeaponParams(ID[len(ID) - 1 - i], ROF[len(ID) - 1 - i], SPREAD[len(ID) - 1 - i], AMMO[len(ID) - 1 - i], SHOT_COST[len(ID) - 1 - i], RANGE[len(ID) - 1 - i])
        client.SendProjectileParams(SPEED[len(ID) - 1 - i], DMG[len(ID) - 1 - i], DMG_RAD[len(ID) - 1 - i], GRAVITY[len(ID) - 1 - i],  EXPLOSIVE[len(ID)- 1 - i])
        #client.SendWeaponParams(ID[i], ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        #client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i], EXPLOSIVE[i])

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()


