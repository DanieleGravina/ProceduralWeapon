import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from Costants import NUM_BOTS
from Costants import PORT

from BalancedWeaponClient import BalancedWeaponClient
from TestClientThread import TestClientThread

from math import log


messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'
messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'


N_CYCLES = 1
NUM_SERVER = 7

statics = {1:(), 2:(), 3:(), 4:(), 5:()}


def initialize_server():
    clients = []

    for i in range(NUM_SERVER):
        clients.append(BalancedWeaponClient(PORT[i]))

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

# Run the simulation on the server side (UDK)
def simulate_population(population, statics) :

    stats = {}
    threads = []

    for i in range(NUM_SERVER):
        threads.append( myThread(i*2, "Thread-" + str(i), population, statics, PORT[i]) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def main():

    statics_file = open("statics.txt", "w")

    statics = {}

    initialize_threads()

    statics = simulate_population(25)

    print(statics)

    for key, val in statics.items() :
        statics_file.write(str(key) + ":" + str(val) + "\n")

    l1 = []
    l2 = []
    l3 = []
    l4 = []

    for key, val in statics.items() :
        l1.append(val[0])
        l2.append(val[1])
        l3.append(val[2])
        l4.append(val[3])


    plt.figure(1)

    plt.boxplot([l1, l3, l2, l4], labels=list('ABCD'))


    plt.show()

    statics_file.close()


main()