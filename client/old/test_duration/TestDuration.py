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
NUM_SERVER = 5
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
    for i in range(5):
        if i < 1 :
            population = 1
        else :
            population = 12

        stats.update({i : [
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)],
                          [random.randint(1, 30) for _ in range(population)]]
                          })

    return stats
    '''
    threads = []
    population = 0

    for i in range(NUM_SERVER):
        if i < 1 :
            population = 1
        else :
            population = 12

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

    kills_1x_1200 = [[] for _ in range(NUM_BOTS)]
    dies_1x_1200 = [[] for _ in range(NUM_BOTS)]
    kills_1x_100 = [[] for _ in range(NUM_BOTS)]
    dies_1x_100 = [[] for _ in range(NUM_BOTS)]
    kills_12x_1200 = [[] for _ in range(NUM_BOTS)]
    dies_12x_1200 = [[] for _ in range(NUM_BOTS)]

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :
        if key < 1 :
            for j in range(NUM_BOTS) :
                for k in range(24) : 
                    kills_1x_1200[j] += val[j] 
                    dies_1x_1200[j] += val[j+NUM_BOTS] 

        elif key < 3 :
            for j in range(NUM_BOTS) :
                kills_1x_100[j] += val[j]
                dies_1x_100[j] += val[j+NUM_BOTS]
        elif key < 5 :
            for j in range(NUM_BOTS) :
                kills_12x_1200[j] += val[j]
                dies_12x_1200[j] += val[j+NUM_BOTS]

    print("kills")
    statics_file.write("kills\n")


    print("kills 1x 1200 ")
    statics_file.write("kills 1x 1200\n") 

    for vector in kills_1x_1200:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("kills 1x 100")
    statics_file.write("kills 1x 100\n")

    for vector in kills_1x_100:
        print(vector)
        statics_file.write(str(vector) + "\n")
    
    print("kills 12x 1200")
    statics_file.write("kills 12x 1200\n")
    for vector in kills_12x_1200:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies")
    statics_file.write("dies\n")

    print("dies 1x 1200")
    statics_file.write("dies_1x_1200\n")
    for vector in dies_1x_1200:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 1x 100")
    statics_file.write("dies_1x_100\n")
    for vector in dies_1x_100:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 12x 1200")
    statics_file.write("dies_12x_1200\n")
    for vector in dies_12x_1200:
        print(vector)
        statics_file.write(str(vector) + "\n")


    final_statistics += [[statistics.mean(kills_1x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.mean(kills_1x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [entropy(kills_1x_1200, 1), [0]]

    log_stats(statics_file, "kill 1x 1200", final_statistics, 0, 4)

    final_statistics += [[statistics.mean(dies_1x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.mean(dies_1x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [entropy(dies_1x_1200, 1), [0]]

    log_stats(statics_file, "dies 1x 1200", final_statistics, 4, 8)

    final_statistics += [[statistics.mean(kills_1x_100[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_1x_100[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_1x_100, 24)), statistics.variance(entropy(kills_1x_100, 24))]

    log_stats(statics_file, "kill 1x 100",final_statistics, 8, 12)

    final_statistics += [[statistics.mean(dies_1x_100[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_1x_100[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_1x_100, 24)), statistics.variance(entropy(dies_1x_100, 24))]

    log_stats(statics_file, "dies 1x 100",final_statistics, 12, 16)
    
    final_statistics += [[statistics.mean(kills_12x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_12x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_12x_1200, 24)), statistics.variance(entropy(kills_12x_1200, 24))]

    log_stats(statics_file, "kill 12x 1200",final_statistics, 16, 20)

    final_statistics += [[statistics.mean(dies_12x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_12x_1200[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_12x_1200, 24)), statistics.variance(entropy(dies_12x_1200, 24))]

    log_stats(statics_file, "dies 12x 1200",final_statistics, 20, 24)

    final_statistics += [[statistics.mean([y/z for y,z in zip(kills_1x_100[i],kills_1x_1200[i])]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance([y/z for y,z in zip(kills_1x_100[i],kills_1x_1200[i])]) for i in range(NUM_BOTS)]]
    final_statistics += [ statistics.mean( [y/z for y,z in zip(entropy(kills_1x_1200, 24), entropy(kills_1x_100, 24))] ) ]
    final_statistics += [ statistics.variance( [y/z for y,z in zip(entropy(kills_1x_1200, 24), entropy(kills_1x_100, 24))] ) ]

    log_stats(statics_file, "kill 1x 100 / kills 1x 1200", final_statistics, 24, 28)

    final_statistics += [[statistics.mean([y/z for y,z in zip(dies_1x_100[i], dies_1x_1200[i])]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance([y/z for y,z in zip(dies_1x_100[i], dies_1x_1200[i])]) for i in range(NUM_BOTS)]]
    final_statistics += [ statistics.mean( [y/z for y,z in zip(entropy(dies_1x_1200, 24), entropy(dies_1x_100, 24))] ) ]
    final_statistics += [ statistics.variance( [y/z for y,z in zip(entropy(dies_1x_1200, 24), entropy(dies_1x_100, 24))] ) ]

    log_stats(statics_file, "dies 1x 100 / dies 1x 1200", final_statistics, 28, 32)

    mean_kill = statistics.mean([statistics.mean([y/z for y,z in zip(kills_1x_100[i],kills_1x_1200[i])]) for i in range(NUM_BOTS)])
    mean_dies = statistics.mean([statistics.mean([y/z for y,z in zip(dies_1x_100[i], dies_1x_1200[i])]) for i in range(NUM_BOTS)])

    print("mean_kill")
    print(mean_kill)
    print("mean_dies")
    print(mean_dies)

    for i in range(len(kills_1x_100)) :
        for j in range(len(kills_1x_100[i])) :
            kills_1x_100[i][j] *= 5.98

    for i in range(len(dies_1x_100)) :
        for j in range(len(dies_1x_100[i])) :
            dies_1x_100[i][j] *= 5.96

    print("kills 1x 100 scaled")
    statics_file.write("kills 1x 100 scaled\n")

    for vector in kills_1x_100:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 1x 100 scaled")
    statics_file.write("dies_1x_100 scaled\n")

    for vector in dies_1x_100:
        print(vector)
        statics_file.write(str(vector) + "\n")


    plt.figure(1)

    plt.subplot(231)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x 1200')

    plt.ylim(0, 50)

    plt.boxplot(kills_1x_1200, labels=list('1234'))

    plt.subplot(232)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x 100')

    plt.ylim(0, 50)

    plt.boxplot(kills_1x_100, labels=list('1234'))

    plt.subplot(233)

    plt.xlabel('id bot')

    plt.ylabel('kill 12x 1200')

    plt.ylim(0, 50)

    plt.boxplot(kills_12x_1200, labels=list('1234'))

    plt.subplot(234)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x 1200')

    plt.ylim(0, 50)

    plt.boxplot(dies_1x_1200, labels=list('1234'))

    plt.subplot(235)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x 100')

    plt.ylim(0, 50)

    plt.boxplot(dies_1x_100, labels=list('1234'))

    plt.subplot(236)

    plt.xlabel('id bot')

    plt.ylabel('dies 12x 1200')

    plt.ylim(0, 50)

    plt.boxplot(dies_12x_1200, labels=list('1234'))




    plt.figure(2)

    plt.subplot(231)

    plt.ylabel('entropy 1x 100')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_1x_1200, 24), labels=list('K'))

    plt.subplot(232)

    plt.ylabel('entropy 1x 100')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_1x_100, 24), labels=list('K'))

    plt.subplot(233)

    plt.ylabel('entropy 12x 1200')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(kills_12x_1200, 24), labels=list('K'))

    plt.subplot(234)

    plt.ylabel('entropy 1x 1200')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_1x_1200, 24), labels=list('D'))

    plt.subplot(235)

    plt.ylabel('entropy 1x 100')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_1x_100, 24), labels=list('D'))

    plt.subplot(236)

    plt.ylabel('entropy 12x 1200')

    plt.ylim(0.7, 1)

    plt.boxplot(entropy(dies_12x_1200, 24), labels=list('D'))

    plt.show()

    statics_file.close()


main()