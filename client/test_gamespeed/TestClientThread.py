import threading
import statistics
import time

from BalancedWeaponClient import BalancedWeaponClient
from Costants import NUM_BOTS

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'

messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

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
                self.client.SendWeaponParams(i, 100, 0, 40, 1, 10000)

            for i in range (NUM_BOTS):
                self.client.SendProjectileParams(1000, 1, 10, 1)

            self.client.SendStartMatch()

            t0 = time.clock()

            self.client.WaitForBotStatics()

            print(str(self.threadID) + " " + str(time.clock() - t0))

            result = self.client.GetStatics()

            kills1.append(result[0][0] + result[1][0])
            dies1.append(result[0][1] + result[1][1])

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()

        avg1_k = sum(kills1)/len(kills1)

        std1_k = statistics.stdev(kills1)

        avg1_d = sum(dies1)/len(dies1)

        std1_d = statistics.stdev(dies1)

        self.stats.update( {self.threadID : [avg1_k, std1_k, avg1_d, std1_d] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats