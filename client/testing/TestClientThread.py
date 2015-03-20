import threading
import statistics
import time
import random

from BalancedWeaponClient import BalancedWeaponClient

NUM_BOTS = 2

class TestClientThread (threading.Thread):
    def __init__(self, threadID, name, port, iterations, weapons, GoalScore):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.iterations = iterations
        self.port = port
        self.weapon = weapons
        self.GoalScore = GoalScore

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()
        self.client.SendTestKillsVsTime()
        self.client.SendGoalScore(self.GoalScore)
        self.client.SendMaxDuration(100000000)

        result = {}

        kills1 = []
        dies1 = []
        kills2 = []
        dies2 = []

        t0 = 0
        times = []

        weapon = self.weapon

        for i in range(self.iterations):

            for j in range (NUM_BOTS):
                index = j
                self.client.SendWeaponParams(index, weapon[index][0], weapon[index][1], weapon[index][2], weapon[index][3], weapon[index][4])
                self.client.SendProjectileParams( weapon[index][5],  weapon[index][6],  weapon[index][7],  weapon[index][8], weapon[index][9])

            self.client.SendStartMatch()

            t0 = time.clock()

            self.client.WaitForBotStatics()

            times.append(time.clock() - t0)

            print(str(self.threadID) + " " + str(time.clock() - t0))

            result = self.client.GetStatics()

            print(str(self.threadID) + " " + str(result))

            kills1.append(result[0][0])
            dies1.append(result[0][1])

            kills2.append(result[1][0])
            dies2.append(result[1][1])

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()
            self.client.SendTestKillsVsTime()
            self.client.SendGoalScore(self.GoalScore)
            self.client.SendMaxDuration(100000000)

        self.stats.update( {self.threadID : [kills1, kills2, dies1, dies2, times] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats