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
NUM_BOTS = 2

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
    population = [2, 2, 2, 2, 12, 12, 24, 125]
    
    for i in range(NUM_SERVER):

        stats.update({i : [
                          [random.randint(2, 5) for _ in range(population[i])],
                          [random.randint(2, 5) for _ in range(population[i])],
                          [random.randint(2, 5) for _ in range(population[i])],
                          [random.randint(2, 5) for _ in range(population[i])]]
                          })

    return stats
    '''
    
    threads = []
    population = [2, 2, 2, 2, 12, 12, 24, 125]

    for i in range(NUM_SERVER): 

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population[i]) )

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

    kills_1x_2400 = [[] for _ in range(NUM_BOTS)]
    dies_1x_2400 = [[] for _ in range(NUM_BOTS)]
    kills_1x_300 = [[] for _ in range(NUM_BOTS)]
    dies_1x_300 = [[] for _ in range(NUM_BOTS)]
    kills_12x_2400 = [[] for _ in range(NUM_BOTS)]
    dies_12x_2400 = [[] for _ in range(NUM_BOTS)]
    kills_12x_300 = [[] for _ in range(NUM_BOTS)]
    dies_12x_300 = [[] for _ in range(NUM_BOTS)]

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :
        if key < 4 :
            for j in range(NUM_BOTS) :
                kills_1x_2400[j] += val[j] 
                dies_1x_2400[j] += val[j+NUM_BOTS] 

        elif key < 6 :
            for j in range(NUM_BOTS) :
                kills_1x_300[j] += val[j]
                dies_1x_300[j] += val[j+NUM_BOTS]

        elif key < 7 :
            for j in range(NUM_BOTS) :
                kills_12x_2400[j] += val[j]
                dies_12x_2400[j] += val[j+NUM_BOTS]

        else :
            for j in range(NUM_BOTS) :
                kills_12x_300[j] += val[j]
                dies_12x_300[j] += val[j+NUM_BOTS]

    print("kills")
    statics_file.write("kills\n")


    print("kills 1x 2400 ")
    statics_file.write("kills 1x 2400\n") 

    for vector in kills_1x_2400:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("kills 1x 300")
    statics_file.write("kills 1x 300\n")

    for vector in kills_1x_300:
        print(vector)
        statics_file.write(str(vector) + "\n")
    
    print("kills 12x 2400")
    statics_file.write("kills 12x 2400\n")
    for vector in kills_12x_2400:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("kills 12x 300")
    statics_file.write("kills 12x 300\n")
    for vector in kills_12x_300:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies")
    statics_file.write("dies\n")

    print("dies 1x 2400")
    statics_file.write("dies_1x_2400\n")
    for vector in dies_1x_2400:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 1x 300")
    statics_file.write("dies_1x_300\n")
    for vector in dies_1x_300:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 12x 2400")
    statics_file.write("dies_12x_2400\n")
    for vector in dies_12x_2400:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies 12x 300")
    statics_file.write("dies 12x 300\n")
    for vector in dies_12x_300:
        print(vector)
        statics_file.write(str(vector) + "\n")



    final_statistics += [[statistics.mean(kills_1x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_1x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_1x_2400, 8)), statistics.variance(entropy(kills_1x_2400, 8))]

    log_stats(statics_file, "kill 1x 2400", final_statistics, 0, 4)

    final_statistics += [[statistics.mean(dies_1x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_1x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_1x_2400, 8)), statistics.variance(entropy(dies_1x_2400, 8))]

    log_stats(statics_file, "dies 1x 2400", final_statistics, 4, 8)

    final_statistics += [[statistics.mean(kills_1x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_1x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_1x_300, 24)), statistics.variance(entropy(kills_1x_300, 24))]

    log_stats(statics_file, "kill 1x 300",final_statistics, 8, 12)

    final_statistics += [[statistics.mean(dies_1x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_1x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_1x_300, 24)), statistics.variance(entropy(dies_1x_300, 24))]

    log_stats(statics_file, "dies 1x 300",final_statistics, 12, 16)
    
    final_statistics += [[statistics.mean(kills_12x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_12x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_12x_2400, 24)), statistics.variance(entropy(kills_12x_2400, 24))]

    log_stats(statics_file, "kill 12x 2400",final_statistics, 16, 20)

    final_statistics += [[statistics.mean(dies_12x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_12x_2400[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_12x_2400, 24)), statistics.variance(entropy(dies_12x_2400, 24))]

    log_stats(statics_file, "dies 12x 2400",final_statistics, 20, 24)

    final_statistics += [[statistics.mean(kills_12x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_12x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_12x_300, 125)), statistics.variance(entropy(kills_12x_300, 125))]

    log_stats(statics_file, "kill 12x 300",final_statistics, 24, 28)

    final_statistics += [[statistics.mean(dies_12x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_12x_300[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_12x_300, 125)), statistics.variance(entropy(dies_12x_300, 125))]

    log_stats(statics_file, "dies 12x 300",final_statistics, 28, 32)

    plt.figure(1)

    plt.subplot(241)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x 2400')

    plt.ylim(0, 50)

    plt.boxplot(kills_1x_2400, labels=list('12'))

    plt.subplot(242)

    plt.xlabel('id bot')

    plt.ylabel('kill 1x 300')

    plt.ylim(0, 50)

    plt.boxplot(kills_1x_300, labels=list('12'))

    plt.subplot(243)

    plt.xlabel('id bot')

    plt.ylabel('kill 12x 2400')

    plt.ylim(0, 50)

    plt.boxplot(kills_12x_2400, labels=list('12'))

    plt.subplot(244)

    plt.xlabel('id bot')

    plt.ylabel('kill 12x 300')

    plt.ylim(0, 50)

    plt.boxplot(kills_12x_300, labels=list('12'))

    plt.subplot(245)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x 2400')

    plt.ylim(0, 50)

    plt.boxplot(dies_1x_2400, labels=list('12'))

    plt.subplot(246)

    plt.xlabel('id bot')

    plt.ylabel('dies 1x 300')

    plt.ylim(0, 50)

    plt.boxplot(dies_1x_300, labels=list('12'))

    plt.subplot(247)

    plt.xlabel('id bot')

    plt.ylabel('dies 12x 2400')

    plt.ylim(0, 50)

    plt.boxplot(dies_12x_2400, labels=list('12'))

    plt.subplot(248)

    plt.xlabel('id bot')

    plt.ylabel('dies 12x 300')

    plt.ylim(0, 50)

    plt.boxplot(dies_12x_300, labels=list('12'))




    plt.figure(2)

    plt.subplot(241)

    plt.ylabel('entropy 1x 2400')

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_1x_2400, 8), labels=list('K'))

    plt.subplot(242)

    plt.ylabel('entropy 1x 300')

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_1x_300, 24), labels=list('K'))

    plt.subplot(243)

    plt.ylabel('entropy 12x 2400')

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_12x_2400, 24), labels=list('K'))

    plt.subplot(244)

    plt.ylabel('entropy 12x 300')

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_12x_300, 125), labels=list('K'))

    plt.subplot(245)

    plt.ylabel('entropy 1x 2400')

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_1x_2400, 8), labels=list('D'))

    plt.subplot(246)

    plt.ylabel('entropy 1x 300')

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_1x_300, 24), labels=list('D'))

    plt.subplot(247)

    plt.ylabel('entropy 12x 2400')

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_12x_2400, 24), labels=list('D'))

    plt.subplot(248)

    plt.ylabel('entropy 12x 300')

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_12x_300, 125), labels=list('D'))

    plt.show()

    statics_file.close()


main()