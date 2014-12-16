import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import statistics

from Costants import NUM_BOTS
from Costants import PORT

from BalancedWeaponClient import BalancedWeaponClient
from TestVarianceClientThread import TestClientThread

from math import log


messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'
messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'


NUM_SERVER = 5

statics = {}


def initialize_server():

    clients = []

    for i in range(NUM_SERVER):
        clients.append(BalancedWeaponClient(PORT[i]))

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

# Run the simulation on the server side (UDK)
def simulate_population() :

    stats = {}

    '''

    for i in range(5):
        population = 2

        stats.update({i : [ [random.randint(5, 10) for _ in range(population)],
                            [random.randint(5, 10) for _ in range(population)],
                            [random.randint(5, 10) for _ in range(population)],
                            [random.randint(5, 10) for _ in range(population)],]})

    return stats
    '''

    threads = []
    population = 2

    for i in range(NUM_SERVER):

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def main():

    statistics_file = open("statics.txt", "w")

    stats = {}

    final_statistics = {}

    kills = [[], []]
    dies = [[], []]

    initialize_server()

    stats = simulate_population()

    print(statistics)

    for key, val in stats.items() :
        for j in range(2) :
            kills[j] += val[j]
            dies[j] += val[j+2]


    final_statistics.update({"mean kill " : [statistics.mean(kills[i]) for i in range(2)]})
    final_statistics.update({"variance kill " : [statistics.variance(kills[i]) for i in range(2)]})

    for key, val in final_statistics.items():
        print(str(key) + " : " + str(val))
        statistics_file.write(str(key) + " : " + str(val) + "\n")

    plt.figure(1)

    plt.subplot(211)

    plt.xlabel('id bot')

    plt.ylabel('kill')

    plt.boxplot(kills, labels=list('12'))

    plt.subplot(212)

    plt.xlabel('id bot')

    plt.ylabel('dies')

    plt.boxplot(dies, labels=list('12'))

    plt.show()

    statistics_file.close()


main()