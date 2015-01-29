from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############

ID = [0, 1, 1]

#default Rof = 1
ROF = [1.05, 0.81]
#default Spread = 0
SPREAD = [0.1, 0.21]
#default MaxAmmo = 40
AMMO = [30, 215]
#deafult ShotCost = 1
SHOT_COST = [1, 9]
#defualt Range 10000
RANGE = [8, 13.55]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [1350, 2000]
#default damage = 1
DMG = [100, 23.57]
#default damgae radius = 10
DMG_RAD = [42, 8]
#default gravity = 1
GRAVITY = [0, -25]
EXPLOSIVE = [220, 0]

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


