import threading
from BalancedWeaponClient import BalancedWeaponClient
from Costants import NUM_BOTS
from Costants import MAX_DURATION
from Costants import GOAL_SCORE
import time

class myThread (threading.Thread):
    def __init__(self, threadID, name, population, port):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.population = population
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.port = port

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()
        self.client.SendMaxDuration(MAX_DURATION)
        self.client.SendGoalScore(GOAL_SCORE)

        index =  self.threadID
        population = self.population

        t0 = 0

        i = int(index/2)

        self.client.SendWeaponParams(index, population[i][0], population[i][1], population[i][2], population[i][3], population[i][4])

        self.client.SendProjectileParams(population[i][5], population[i][6], population[i][7], population[i][8])

        self.client.SendWeaponParams(index + 1, population[i][9], population[i][10], population[i][11], population[i][12], population[i][13])

        self.client.SendProjectileParams(population[i][14], population[i][15], population[i][16], population[i][17])

        self.client.SendStartMatch()

        t0 = time.clock()

        self.client.WaitForBotStatics()

        print(str(self.threadID) + " " + str(time.clock() - t0))

        self.stats = self.client.GetStatics()

        if self.stats != None:
            print(self.stats)

    def join(self):
        threading.Thread.join(self)
        return self.stats