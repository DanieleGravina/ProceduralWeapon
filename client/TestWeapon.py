from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

ID = [0, 1]

#default Rof = 1
ROF = [2.2, 1.92]
#default Spread = 0
SPREAD = [0.5, 2.86]
#default MaxAmmo = 40
AMMO = [131, 200]
#deafult ShotCost = 1
SHOT_COST = [4, 9]
#defualt Range 10000
RANGE = [83, 17.4]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [7833, 174]
#default damage = 1
DMG = [74, 62]
#default damgae radius = 10
DMG_RAD = [62, 96]
#default gravity = 1
GRAVITY = [80, 4]
EXPLOSIVE = [192, 66]

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendMaxDuration(3600)
    client.SendGoalScore(20)

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


