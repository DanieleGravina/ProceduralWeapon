import os,sys,inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0,parentdir) 

import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import statistics

from Costants import *

from TestClientThread import TestClientThread
from BalancedWeaponClient import BalancedWeaponClient

from math import log


N_CYCLES = 1
NUM_SERVER = 5
NUM_BOTS = 2

population = [2, 2, 2, 2, 2]
GOAL_SCORE = 40
MAX_DURATION = 2400

statics = {}

speed1 = "8x"


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
    for i in range(NUM_SERVER):

        stats.update({i : [
                          [random.randint(24, 26) for _ in range(population[i])], #kills1
                          [random.randint(24, 26) for _ in range(population[i])], #kills2
                          [random.randint(24, 26) for _ in range(population[i])], #dies1
                          [random.randint(24, 26) for _ in range(population[i])]  #dies2
                          ]
                          })

    return stats
    '''

    threads = []
    TestWeapon = []
    #TestWeapon = [Weapons[i] for i in range(2)]

    TestWeapon += [Weapons[0]]

    best_cluster = open("best_cluster.txt", "r")

    data = []

    content = best_cluster.readlines()

    temp = []

    for string in content:
        
        if "Weapon" in string or "Projectile" in string:
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if ":" in splitted:
                    split_colon = splitted.split(":")
                    temp += [float(split_colon[1])]
                    if (len(temp) == 10):
                        data += [temp]
                        temp = []

    TestWeapon += [ [float("{0:.2f}".format(ind)) for ind in list(numpy.mean(data, axis = 0))] ]

    #TestWeapon += [Weapons[1]]


    print(TestWeapon)

    for i in range(NUM_SERVER):

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population[i], TestWeapon, GOAL_SCORE, MAX_DURATION) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def match_suicides(kills, dies) :
    suicides = 0
    #suicides += (dies[1]/2 - kills[0]/2)
    suicides += (dies[1] - kills[0])
    return suicides

def eval_entropy(kills, dies):

    p = 0
    e = 0

    total = sum(kills)

    for d in kills:
        p = d/total if total != 0 else 0
        e += p*log(p, NUM_BOTS) if p != 0 else 0

    return -e + total/GOAL_SCORE + pow(9/10, match_suicides(kills, dies))


def entropy(kills, dies):

    result = []

    for i in range(len(kills[0])):
        result += [eval_entropy( [kills[j][i] for j in range(NUM_BOTS)], [dies[j][i] for j in range(NUM_BOTS)])]

    return result

def log_stats(file, string, stats, i, f):
    
    print(string)
    file.write("\n" + string + "\n")

    n = 1

    for index in range(i ,f):
        print(str(n) + ") " + str(stats[index]))
        file.write(str(n) + ") " + str(stats[index]) + "\n")
        n += 1

def main():

    statics_file = open("statics.txt", "w")

    statics = {}

    final_statistics = []

    kills_8x = [[] for _ in range(NUM_BOTS)]
    dies_8x = [[] for _ in range(NUM_BOTS)]

    initialize_server()

    statics = simulate_population()

    print(statics)

    statics_file.write("Results\n")

    for key, val in statics.items() :

        statics_file.write(str(val) + "\n")

        for j in range(NUM_BOTS):
            kills_8x[j] += val[j]
            dies_8x[j] += val[j + NUM_BOTS]

    print("kills")
    statics_file.write("\nkills 1) first bot 2) second bot\n")
    for vector in kills_8x:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies")
    statics_file.write("\ndies 1) first bot 2) second bot\n")
    for vector in dies_8x:
        print(vector)
        statics_file.write(str(vector) + "\n")

    
    final_statistics += [[statistics.mean(kills_8x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_8x[i]) for i in range(NUM_BOTS)]]

    log_stats(statics_file, "kill [1)mean , 2)var]", final_statistics, 0, 2)

    final_statistics += [[statistics.mean(dies_8x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_8x[i]) for i in range(NUM_BOTS)]]

    log_stats(statics_file, "dies [1)mean , 2)var]", final_statistics, 2, 4)

    final_statistics += [statistics.mean(entropy(kills_8x, dies_8x)), statistics.variance(entropy(kills_8x, dies_8x))]
    log_stats(statics_file, "fitness (entropy + total kill + suicides) [1)mean , 2)var]", final_statistics, 4, 6)


    plt.figure(figsize=(16, 9))

    plt.subplot(221)

    plt.xlabel('id bot')

    plt.ylabel('kill ')

    plt.ylim(0, GOAL_SCORE)

    plt.boxplot(kills_8x, labels=list('12'))

    plt.subplot(222)

    plt.xlabel('id bot')

    plt.ylabel('dies ')

    plt.ylim(0, GOAL_SCORE)

    plt.boxplot(dies_8x, labels=list('12'))


    plt.subplot(223)

    plt.ylabel('fitness ')

    plt.ylim(0, 3)

    plt.boxplot(entropy(kills_8x, dies_8x))

    statics_file.close()

    plt.savefig("simulation.png", bbox_inches='tight', dpi = 200)
    plt.close()


if __name__ == '__main__':
    main()