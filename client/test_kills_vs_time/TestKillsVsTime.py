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
from InitialPopulationSeed import Weapons

from math import log


N_CYCLES = 1
NUM_SERVER = 8
NUM_BOTS = 2

N_SERVER_SPEED_1 = 4

population = [9, 9, 9, 9, 9, 9, 9, 9]

statics = {}

speed1 = "8x"
speed2 = "10x"


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
                          [random.randint(5, 10) for _ in range(population[i])], #kill1
                          [random.randint(5, 10) for _ in range(population[i])], #kill2
                          [random.randint(1, 2) for _ in range(population[i])], #dies1
                          [random.randint(1, 2) for _ in range(population[i])], #dies2
                          [random.randint(1000, 2000) for _ in range(population[i])]] #time
                          })

    return stats
    '''

    threads = []
    GoalScore = 40
    TestWeapon = [Weapons[i] for i in range(2)]

    print(TestWeapon)

    for i in range(NUM_SERVER):

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population[i], TestWeapon, GoalScore) )

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


def entropy(data):

    result = []

    for i in range(len(data[0])):
        result += [eval_entropy( [data[j][i] for j in range(NUM_BOTS)])]

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

    kills_1x = [[] for _ in range(NUM_BOTS)]
    dies_1x = [[] for _ in range(NUM_BOTS)]
    times_1x = [[]]
    kills_12x = [[] for _ in range(NUM_BOTS)]
    dies_12x = [[] for _ in range(NUM_BOTS)]
    times_12x = [[]]

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :
        if key < N_SERVER_SPEED_1 :
            for j in range(NUM_BOTS) :
                kills_1x[j] += val[j]
                dies_1x[j] += val[j+NUM_BOTS]
            times_1x[0] += val[NUM_BOTS*2]

        else :
            for j in range(NUM_BOTS) :
                kills_12x[j] += val[j]
                dies_12x[j] += val[j+NUM_BOTS]
            times_12x[0] += val[NUM_BOTS*2]

    print("kills")
    statics_file.write("kills\n")
    print(speed1)
    statics_file.write(speed1 + "\n")
    for vector in kills_1x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    print(speed2)
    statics_file.write(speed2+ "\n")
    for vector in kills_12x:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("dies")
    statics_file.write("dies\n")
    print(speed1)
    statics_file.write(speed1 + "\n")
    for vector in dies_1x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    print(speed2)
    statics_file.write(speed2 + "\n")
    for vector in dies_12x:
        print(vector)
        statics_file.write(str(vector) + "\n")

    print("time")
    statics_file.write("time\n")
    print(speed1)
    statics_file.write(speed1 + "\n")
    for vector in times_1x:
        print(vector)
        statics_file.write(str(vector) + "\n")
    print(speed2)
    statics_file.write(speed2 + "\n")
    for vector in times_12x:
        print(vector)
        statics_file.write(str(vector) + "\n")


    final_statistics += [[statistics.mean(kills_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_1x)), statistics.variance(entropy(kills_1x))]

    log_stats(statics_file, "kill " + speed1 + "[1)mean , 2)var, 3)entropy mean, 4)entropy var]", final_statistics, 0, 4)

    final_statistics += [[statistics.mean(dies_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_1x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_1x)), statistics.variance(entropy(dies_1x))]

    log_stats(statics_file, "dies " + speed1 + "[1)mean , 2)var, 3)entropy mean, 4)entropy var]", final_statistics, 4, 8)

    final_statistics += [statistics.mean(times_1x[0])]
    final_statistics += [statistics.variance(times_1x[0])]

    log_stats(statics_file, "time "+ speed1 + "[1)mean , 2)var]", final_statistics, 8, 10)
    
    final_statistics += [[statistics.mean(kills_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(kills_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(kills_12x)), statistics.variance(entropy(kills_12x))]

    log_stats(statics_file, "kill " + speed2 + "[1)mean , 2)var, 3)entropy mean, 4)entropy var]",final_statistics, 10, 14)

    final_statistics += [[statistics.mean(dies_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [[statistics.variance(dies_12x[i]) for i in range(NUM_BOTS)]]
    final_statistics += [statistics.mean(entropy(dies_12x)), statistics.variance(entropy(dies_12x))]

    log_stats(statics_file, "dies " + speed2 + "[1)mean , 2)var, 3)entropy mean, 4)entropy var]",final_statistics, 14, 18)

    final_statistics += [statistics.mean(times_12x[0])]
    final_statistics += [statistics.variance(times_12x[0])]

    log_stats(statics_file, "time " + speed1 + "[1)mean , 2)var]", final_statistics, 18, 20)


    plt.figure(1)

    plt.subplot(221)

    plt.xlabel('id bot')

    plt.ylabel('kill ' + speed1)

    plt.ylim(0, 40)

    plt.boxplot(kills_1x, labels=list('12'))

    plt.subplot(222)

    plt.xlabel('id bot')

    plt.ylabel('kill '+ speed2)

    plt.ylim(0, 40)

    plt.boxplot(kills_12x, labels=list('12'))

    plt.subplot(223)

    plt.xlabel('id bot')

    plt.ylabel('dies '+ speed1)

    plt.ylim(0, 40)

    plt.boxplot(dies_1x, labels=list('12'))

    plt.subplot(224)

    plt.xlabel('id bot')

    plt.ylabel('dies '+ speed2)

    plt.ylim(0, 40)

    plt.boxplot(dies_12x, labels=list('12'))


    plt.figure(3)

    plt.subplot(121)

    plt.ylabel('time '+ speed1)

    plt.ylim(0, 3000)

    plt.boxplot(times_1x[0], labels=[speed1])

    plt.subplot(122)

    plt.ylabel('time '+ speed2)

    plt.ylim(0, 3000)

    plt.boxplot(times_12x[0], labels=[speed2])



    plt.figure(2)

    plt.subplot(221)

    plt.ylabel('entropy '+ speed1)

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_1x), labels=["kill "+ speed1])

    plt.subplot(222)

    plt.ylabel('entropy '+ speed1)

    plt.ylim(0, 1)

    plt.boxplot(entropy(kills_12x), labels=["kills "+ speed1])

    plt.subplot(223)

    plt.ylabel('entropy '+ speed1)

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_1x), labels=["dies "+ speed2])

    plt.subplot(224)

    plt.ylabel('entropy '+ speed2)

    plt.ylim(0, 1)

    plt.boxplot(entropy(dies_12x), labels=["dies "+ speed2])



    plt.show()

    statics_file.close()


main()