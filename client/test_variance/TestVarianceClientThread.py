import threading
import statistics
import time

from BalancedWeaponClient import BalancedWeaponClient

NUM_BOTS = 2

#default Rof = 100
ROF = [100, 100]
#default Spread = 0
SPREAD = [1, 1]
#default MaxAmmo = 40
AMMO = [100, 100]
#deafult ShotCost = 1
SHOT_COST = [1, 1]
#defualt Range 10000
RANGE = [10, 10]

###################
# Projectile ######
###################

#default speed = 1000
SPEED = [1000, 1000]
#default damage = 1
DMG = [50, 50]
#default damgae radius = 10
DMG_RAD = [21, 21]
#default gravity = 1
GRAVITY = [0, 0]

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

            for i in range (NUM_BOTS):
                self.client.SendWeaponParams(i, ROF[i], SPREAD[i], AMMO[i], SHOT_COST[i], RANGE[i])

            for i in range (NUM_BOTS):
                self.client.SendProjectileParams(SPEED[i], DMG[i], DMG_RAD[i], GRAVITY[i])

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