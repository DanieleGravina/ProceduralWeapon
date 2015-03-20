from BalancedWeaponClient import BalancedWeaponClient
import time

###############
# Weapon ######
###############


ID = [0, 1]

weapon = [[], []]

weapon_file = open("weapons.txt", "r")

content = weapon_file.readlines()

temp = []

i = 0

for string in content:
    
    if "Weapon" in string or "Projectile" in string:
        split_spaces = string.split(" ")

        for splitted in split_spaces:
            if ":" in splitted:
                split_colon = splitted.split(":")
                temp += [float(split_colon[1])]
                if (len(temp) == 10):
                    weapon[i] += temp
                    temp = []
                    i += 1
print(weapon)

PORT = [3760]


def main():

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendStartMatch()
    client.SendClose()

    client = BalancedWeaponClient(PORT[0])

    client.SendInit()
    client.SendMaxDuration(1200)
    client.SendGoalScore(30)

    for i in range(2):
        client.SendWeaponParams(i, weapon[i][0], weapon[i][1], weapon[i][2], weapon[i][3], weapon[i][4])
        client.SendProjectileParams(weapon[i][5], weapon[i][6], weapon[i][7],weapon[i][8], weapon[i][9], 1)

    t0 = time.clock()

    client.SendStartMatch()

    client.WaitForBotStatics()

    if client.GetStatics() is None:
        print("server is not runnning")

    print(str(time.clock() - t0))

main()


