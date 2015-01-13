import threading
from BalancedWeaponClient import BalancedWeaponClient
from Costants import NUM_BOTS
from Costants import MAX_DURATION

class myThread (threading.Thread):
    def __init__(self, threadID, name, population, fixedWeapon, port):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.population = population
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.port = port
        self.fixedWeapon = fixedWeapon

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()
        self.client.SendMaxDuration(MAX_DURATION)

        index =  self.threadID
        population = self.population

        i = int(index/2)

        self.client.SendWeaponParams(index, population[i][0], population[i][1], population[i][2], population[i][3], population[i][4])

        self.client.SendProjectileParams(population[i][5], population[i][6], population[i][7], population[i][8])

        self.client.SendWeaponParams(index + 1, self.fixedWeapon[0], self.fixedWeapon[1], self.fixedWeapon[2], self.fixedWeapon[3], self.fixedWeapon[4])

        self.client.SendProjectileParams(self.fixedWeapon[5], self.fixedWeapon[6], self.fixedWeapon[7], self.fixedWeapon[8])

        self.client.SendStartMatch()

        self.client.WaitForBotStatics()

        self.stats = self.client.GetStatics()

        if self.stats != None:
            print(self.stats)

    def join(self):
        threading.Thread.join(self)
        return self.stats