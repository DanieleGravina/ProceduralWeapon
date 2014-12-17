import threading
import statistics
import time

from math import log

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

        entropy_kill = []
        entropy_dies = []

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

            total_kills = result[0][0] + result[1][0]
            total_dies = result[0][1] + result[1][1]

            p_kills_1 = 0  if total_kills == 0 else result[0][0]/total_kills
            p_dies_1 = 0 if total_dies == 0 else result[0][1]/total_dies

            p_kills_2 = 0  if total_kills == 0 else result[1][0]/total_kills
            p_dies_2 = 0 if total_dies == 0 else result[1][1]/total_dies

            entropy_kill_1 = p_kills_1*log(p_kills_1, NUM_BOTS) if p_kills_1 != 0 else 0

            entropy_dies_1 = p_dies_1*log(p_dies_1, NUM_BOTS) if p_dies_1 != 0 else 0

            entropy_kill_2 = p_kills_2*log(p_kills_2, NUM_BOTS) if p_kills_2 != 0 else 0

            entropy_dies_2 = p_dies_2*log(p_dies_2, NUM_BOTS) if p_dies_2 != 0 else 0

            entropy_kill += [-(entropy_kill_1 + entropy_kill_2)]
            entropy_dies += [-(entropy_dies_1 + entropy_dies_2)]

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()

        self.stats.update( {self.threadID : [entropy_kill, entropy_dies] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats