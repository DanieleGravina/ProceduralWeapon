from BalancedWeaponClient import BalancedWeaponClient
from Costants import PORT

###############
# Weapon ######
###############

#default Rof = 100
ROF = [332, 135]
#default Spread = 0
SPREAD = [430, 390]
#default MaxAmmo = 40
AMMO = [978, 13]
#deafult ShotCost = 1
SHOT_COST = [9, 8]
#defualt Range 10000
RANGE = [93858, 93858]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [9069, 9069]
#default damage = 1
DMG = [93, 93]
#default damgae radius = 10
DMG_RAD = [21, 21]
#default gravity = 1
GRAVITY = [53, 22]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()

    for i in range(2):
        client.SendWeaponParams(i, ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])
        client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i])

    client.SendStartMatch()

    client.WaitForBotStatics()

main()


