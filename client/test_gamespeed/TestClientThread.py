import threading
import statistics
import time

from BalancedWeaponClient import BalancedWeaponClient

NUM_BOTS = 4

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
        kills3 = []
        dies3 = []
        kills4 = []
        dies4 = []

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

            print(str(self.threadID) + " " + str(result))

            kills1.append(result[0][0])
            dies1.append(result[0][1])

            kills2.append(result[1][0])
            dies2.append(result[1][1])

            kills3.append(result[2][0])
            dies3.append(result[2][1])

            kills4.append(result[3][0])
            dies4.append(result[3][1])

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()

        self.stats.update( {self.threadID : [kills1, kills2, kills3, kills4, dies1, dies2, dies3, dies4] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats