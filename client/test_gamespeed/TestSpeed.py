import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import statistics

from Costants import NUM_BOTS
from Costants import PORT

from BalancedWeaponClient import BalancedWeaponClient
from TestClientThread import TestClientThread

from math import log


messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'
messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'


N_CYCLES = 1
NUM_SERVER = 8

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
    for i in range(8):
        if i < 5 :
            population = 5
        elif i == 5 :
            population = 12
        elif i == 6 :
            population = 13
        else :
            population = 25

        stats.update({i : [
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)],
                          [random.randint(5, 10) for _ in range(population)]]
                          })

    return stats
    '''

    threads = []
    population = 0

    for i in range(NUM_SERVER):
        if i < 5 :
            population = 5
        elif i == 5 :
            population = 12
        elif i == 6 :
            population = 13
        else :
            population = 25

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def main():

    statics_file = open("statics.txt", "w")

    statics = {}

    final_statistics = {}

    kills_1x = [[], [], [], []]
    dies_1x = [[], [], [], []]
    kills_5x = [[], [], [], []]
    dies_5x = [[], [], [], []]
    kills_12x = [[], [], [], []]
    dies_12x = [[], [], [], []]

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :
        if key < 5 :
            for j in range(4) :
                kills_1x[j] += val[j]
                dies_1x[j] += val[j+4]

        elif key < 7 :
            for j in range(4) :
                kills_5x[j] += val[j]
                dies_5x[j] += val[j+4]
        elif key == 7 :
            for j in range(4) :
                kills_12x[j] += val[j]
                dies_12x[j] += val[j+4]


    final_statistics.update({"mean kill 1x" : [statistics.mean(kills_1x[i]) for i in range(4)]})
    final_statistics.update({"variance kill 1x" : [statistics.variance(kills_1x[i]) for i in range(4)]})

    final_statistics.update({"mean dies 1x" : [statistics.mean(kills_1x[i]) for i in range(4)]})
    final_statistics.update({"variance dies 1x" : [statistics.variance(dies_1x[i]) for i in range(4)]})

    final_statistics.update({"mean kill 5x" : [statistics.mean(kills_5x[i]) for i in range(4)]})
    final_statistics.update({"variance kill 5x" : [statistics.variance(kills_5x[i]) for i in range(4)]})

    final_statistics.update({"mean dies 5x" : [statistics.mean(dies_5x[i]) for i in range(4)]})
    final_statistics.update({"variance dies 5x" : [statistics.variance(dies_5x[i]) for i in range(4)]})
    
    final_statistics.update({"mean kill 12x" : [statistics.mean(kills_12x[i]) for i in range(4)]})
    final_statistics.update({"variance kill 12x" : [statistics.variance(kills_12x[i]) for i in range(4)]})

    final_statistics.update({"mean dies 12x" : [statistics.mean(dies_12x[i]) for i in range(4)]})
    final_statistics.update({"variance dies 12x" : [statistics.variance(dies_12x[i]) for i in range(4)]})

    for key, val in final_statistics.items():
        print(key + " : " + val)
        statics_file.write(key + " : " + val + "\n")

    plt.figure(1)

    plt.subplot(231)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x')

    plt.boxplot(kills_1x, labels=list('1234'))

    plt.subplot(232)

    plt.xlabel('id bot')

    plt.ylabel('kill 5x')

    plt.boxplot(kills_5x, labels=list('1234'))

    plt.subplot(233)

    plt.xlabel('id bot')

    plt.ylabel('kill 12x')

    plt.boxplot(kills_12x, labels=list('1234'))

    plt.subplot(234)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x')

    plt.boxplot(dies_1x, labels=list('1234'))

    plt.subplot(235)

    plt.xlabel('id bot')

    plt.ylabel('dies 5x')

    plt.boxplot(dies_5x, labels=list('1234'))

    plt.subplot(236)

    plt.xlabel('id bot')

    plt.ylabel('dies 12x')

    plt.boxplot(dies_12x, labels=list('1234'))


    plt.show()

    statics_file.close()


main()