from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

ID = [0, 1]

#default Rof = 1
ROF = [5.47, 2.03]
#default Spread = 0
SPREAD = [1.11, 0.42]
#default MaxAmmo = 40
AMMO = [746, 219]
#deafult ShotCost = 1
SHOT_COST = [7, 9]
#defualt Range 10000
RANGE = [7.36, 51.94]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [1, 802]
#default damage = 1
DMG = [28, 51]
#default damgae radius = 10
DMG_RAD = [50, 59]
#default gravity = 1
GRAVITY = [25, 67]
EXPLOSIVE = [81, 45.75]

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


