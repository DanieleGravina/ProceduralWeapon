import threading
import statistics
import time
import random

from BalancedWeaponClient import BalancedWeaponClient

NUM_BOTS = 2
MAX_DURATION = 2000

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
        self.client.SendMaxDuration(MAX_DURATION)

        result = {}

        delta_time = [[], []]
        distance = [[], []]
        kill_streak = [[], []]
        precision = [[], []]

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

            for bot in range(2):
                delta_time[bot].append(result[bot][2])
                distance[bot].append(result[bot][3])
                kill_streak[bot].append(result[bot][4])
                precision[bot].append(result[bot][5])

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()
            self.client.SendTestKillsVsTime()
            self.client.SendGoalScore(self.GoalScore)
            self.client.SendMaxDuration(MAX_DURATION)

        self.stats.update( {self.threadID : [delta_time, distance, kill_streak, precision] } )


    def join(self):
        threading.Thread.join(self)
        return self.stats