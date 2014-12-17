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


N_CYCLES = 1
NUM_SERVER = 8
NUM_BOTS = 4

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

def eval_entropy(data):

    p = 0
    e = 0

    total = sum(data)

    for d in data:
        p = d/total if total != 0 else 0
        e += p*log(p, NUM_BOTS) if p != 0 else 0

    return -e


def entropy(data, pop):

    result = []

    for i in range(pop):
        result += [eval_entropy( [data[j][i] for j in range(NUM_BOTS)])]

    return result

def log_stats(file, string, stats, i, f):
    
    print(string)
    file.write(string + "\n")

    for index in range(i ,f):
        print(str(stats[index]))
        file.write( str(stats[index]) + "\n")




def main():

    statics_file = open("statics.txt", "w")

    statics = {}

    final_statistics = []

    kills_1x = [[] for _ in range(NUM_BOTS)]
    dies_1x = [[] for _ in range(NUM_BOTS)]
    kills_5x = [[] for _ in range(NUM_BOTS)]
    dies_5x = [[] for _ in range(NUM_BOTS)]
    kills_12x = [[] for _ in range(NUM_BOTS)]
    dies_12x = [[] for _ in range(NUM_BOTS)]

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :
        if key < 5 :
            for j in range(NUM_BOTS) :
                kills_1x[j] += val[j]
                dies_1x[j] += val[j+NUM_BOTS]

        elif key < 7 :
            for j in range(NUM_BOTS) :
                kills_5x[j] += val[j]
                dies_5x[j] += val[j+NUM_BOTS]
        elif key == 7 :
            for j in range(NUM_BOTS) :
                kills_12x[j] += val[j]
                dies_12x[j] += val[j+NUM_BOTS]

    print("kills")
    statics_file.write("kills\n")
    for vector in kills_1x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    for vector in kills_5x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    for vector in kills_12x:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies")
    statics_file.write("dies\n")
    for vector in dies_1x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    for vector in dies_5x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    for vector in dies_12x:
        print(vector)
        statics_file.write(str(vector) + "\n")


    final_statistics += [[statistics.mean(kills_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_1x, 25)), statistics.variance(entropy(kills_1x, 25))]

    log_stats(statics_file, "kill 1x", final_statistics, 0, 4)

    final_statistics += [[statistics.mean(dies_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_1x, 25)), statistics.variance(entropy(dies_1x, 25))]

    log_stats(statics_file, "dies 1x", final_statistics, 4, 8)

    final_statistics += [[statistics.mean(kills_5x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_5x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_5x, 25)), statistics.variance(entropy(kills_5x, 25))]

    log_stats(statics_file, "kill 5x",final_statistics, 8, 12)

    final_statistics += [[statistics.mean(dies_5x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_5x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_5x, 25)), statistics.variance(entropy(dies_5x, 25))]

    log_stats(statics_file, "dies 5x",final_statistics, 12, 16)
    
    final_statistics += [[statistics.mean(kills_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_12x, 25)), statistics.variance(entropy(kills_12x, 25))]

    log_stats(statics_file, "kill 12x",final_statistics, 16, 20)

    final_statistics += [[statistics.mean(dies_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_12x, 25)), statistics.variance(entropy(dies_12x, 25))]

    log_stats(statics_file, "dies 12x",final_statistics, 20, 24)


    plt.figure(1)

    plt.subplot(231)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x')

    plt.ylim(0, 30)

    plt.boxplot(kills_1x, labels=list('1234'))

    plt.subplot(232)

    plt.xlabel('id bot')

    plt.ylabel('kill 5x')

    plt.ylim(0, 30)

    plt.boxplot(kills_5x, labels=list('1234'))

    plt.subplot(233)

    plt.xlabel('id bot')

    plt.ylabel('kill 12x')

    plt.ylim(0, 30)

    plt.boxplot(kills_12x, labels=list('1234'))

    plt.subplot(234)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x')

    plt.ylim(0, 30)

    plt.boxplot(dies_1x, labels=list('1234'))

    plt.subplot(235)

    plt.xlabel('id bot')

    plt.ylabel('dies 5x')

    plt.ylim(0, 30)

    plt.boxplot(dies_5x, labels=list('1234'))

    plt.subplot(236)

    plt.xlabel('id bot')

    plt.ylabel('dies 12x')

    plt.ylim(0, 30)

    plt.boxplot(dies_12x, labels=list('1234'))




    plt.figure(2)

    plt.subplot(231)

    plt.ylabel('entropy 1x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_1x, 25), labels=list('K'))

    plt.subplot(232)

    plt.ylabel('entropy 5x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_5x, 25), labels=list('K'))

    plt.subplot(233)

    plt.ylabel('entropy 12x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_12x, 25), labels=list('K'))

    plt.subplot(234)

    plt.ylabel('entropy 1x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_1x, 25), labels=list('D'))

    plt.subplot(235)

    plt.ylabel('entropy 5x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_5x, 25), labels=list('D'))

    plt.subplot(236)

    plt.ylabel('entropy 12x')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_12x, 25), labels=list('D'))



    plt.show()

    statics_file.close()


main()