import threading
from BalancedWeaponClient import BalancedWeaponClient
from Costants import NUM_BOTS

class myThread (threading.Thread):
    def __init__(self, threadID, name, population, statics, port):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.population = population
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.statics = statics

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()

        index =  self.threadID
        population = self.population

        if not population[index].fitness.valid or not population[index + 1].fitness.valid :

            for i in range (index, NUM_BOTS + index):
                self.client.SendWeaponParams(i, population[i][0], population[i][1], population[i][2], population[i][3], population[i][4])

            for i in range (index, NUM_BOTS + index):
                self.client.SendProjectileParams(population[i][5], population[i][6], population[i][7], population[i][8])

            self.client.SendStartMatch()

            self.client.WaitForBotStatics()

            self.stats = self.client.GetStatics()

            print(self.stats)

        else :
            self.stats[index] = self.statics[index]
            self.stats[index + 1] = self.statics[index + 1]

    def join(self):
        threading.Thread.join(self)
        return self.stats