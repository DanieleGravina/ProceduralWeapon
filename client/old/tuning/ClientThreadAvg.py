import threading
from BalancedWeaponClient import BalancedWeaponClient
from Costants import NUM_BOTS
from Costants import MAX_DURATION

class myThread (threading.Thread):
    def __init__(self, threadID, name, population, port):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.population = population
        self.client = BalancedWeaponClient(port)
        self.stats = {}
        self.port = port
        self.iterations = 2

    def run(self):
        print("Starting " + self.name)

        self.client.SendInit()

        self.client.SendMaxDuration(MAX_DURATION)

        index =  self.threadID
        population = self.population

        stat = {}
        result = []
        kills1 = 0
        kills2 = 0
        dies1 = 0
        dies2 = 0

        i = int(index/2)

        for i in range(self.iterations):

            self.client.SendWeaponParams(index, population[i][0], population[i][1], population[i][2], population[i][3], population[i][4])

            self.client.SendProjectileParams(population[i][5], population[i][6], population[i][7], population[i][8])

            self.client.SendWeaponParams(index + 1, population[i][9], population[i][10], population[i][11], population[i][12], population[i][13])

            self.client.SendProjectileParams(population[i][14], population[i][15], population[i][16], population[i][17])

            self.client.SendStartMatch()

            self.client.WaitForBotStatics()

            stat = self.client.GetStatics()

            if stat != None:
                result += [stat]
            else :
                self.stats = None
                return

            self.client = BalancedWeaponClient(self.port)
            self.client.SendInit()

        for ind in result:
            kills1 += ind[index][0]
            dies1 += ind[index][1]
            kills2 += ind[index + 1][0]
            dies2 += ind[index + 1][1]

        kills1 = int(kills1/self.iterations)
        kills2 = int(kills2/self.iterations)
        dies1 = int(dies1/self.iterations)
        dies2 = int(dies2/self.iterations)


        self.stats.update( {index : (kills1, dies1)} )
        self.stats.update( {index + 1 : (kills2, dies2)} )

        if self.stats != None:
            print(self.stats)

    def join(self):
        threading.Thread.join(self)
        return self.stats