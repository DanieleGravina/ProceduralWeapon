import threading
import statistics
import time
import random

from BalancedWeaponClient import BalancedWeaponClient

NUM_BOTS = 2

#default Rof = 1
ROF = [0.5, 1.75]
#default Spread = 0
SPREAD = [7.6, 0.8]
#default MaxAmmo = 40
AMMO = [853, 949]
#deafult ShotCost = 1
SHOT_COST = [100, 689]
#defualt Range 10000
RANGE = [23.5, 73]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [8452, 5559]
#default damage = 1
DMG = [72, 78]
#default damgae radius = 10
DMG_RAD = [5, 12]
#default gravity = 1
GRAVITY = [-16, -12]

class TestClientThread (threading.Thread):
    def __init__(self, threadID, name, port, iterations):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.iterations = iterations
        self.port = port

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()

        result = {}

        kills1 = []
        dies1 = []
        kills2 = []
        dies2 = []

        t0 = 0

        for i in range(self.iterations):

            for j in range(NUM_BOTS):
                self.client.SendWeaponParams(j, ROF[j], SPREAD[j], AMMO[j], SHOT_COST[j], RANGE[j])
                self.client.SendProjectileParams(SPEED[j], DMG[j], DMG_RAD[j], GRAVITY[j])

            self.client.SendStartMatch()

            t0 = time.clock()

            self.client.WaitForBotStatics()

            print(str(self.threadID) + " " + str(time.clock() - t0))

            result = self.client.GetStatics()

            print(str(self.threadID) + " " + str(result))

            kills1.append(result[0][0])
            dies1.append(result[0][1])

            kills2.append(result[1][0])
            dies2.append(result[1][1])

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()

        self.stats.update( {self.threadID : [kills1, kills2, dies1, dies2] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats