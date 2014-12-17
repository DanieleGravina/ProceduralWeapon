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

    entropy_kills = []
    entropy_dies = []

    initialize_server()

    stats = simulate_population()

    print(statistics)

    for key, val in stats.items() :
        entropy_kills += val[0]
        entropy_dies += val[1]

    print(str(entropy_kills))
    statistics_file.write(str(entropy_kills) + "\n")

    print(str(entropy_dies))
    statistics_file.write(str(entropy_dies) + "\n")


    final_statistics.update({"mean entropy kill " : statistics.mean(entropy_kills)})
    final_statistics.update({"variance entropy kill " : statistics.variance(entropy_kills)})
    final_statistics.update({"mean entropy_dies " : statistics.mean(entropy_dies) })
    final_statistics.update({"variance entropy_dies " : statistics.variance(entropy_dies) })

    for key, val in final_statistics.items():
        print(str(key) + " : " + str(val))
        statistics_file.write(str(key) + " : " + str(val) + "\n")

    plt.figure(1)

    plt.subplot(211)

    plt.xlabel('id bot')

    plt.ylabel('kill')

    plt.boxplot(entropy_kills, labels=list('K'))

    plt.subplot(212)

    plt.xlabel('id bot')

    plt.ylabel('dies')

    plt.boxplot(entropy_dies, labels=list('D'))

    plt.show()

    statistics_file.close()


main()