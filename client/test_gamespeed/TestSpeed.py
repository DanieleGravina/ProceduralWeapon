import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from Costants import NUM_BOTS
from Costants import PORT1, PORT2, PORT3, PORT4, PORT5

from BalancedWeaponClient import BalancedWeaponClient
from TestClientThread import TestClientThread

from math import log


messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'
messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

PORT1 = 3742
PORT2 = 3743
PORT3 = 3744
PORT4 = 3745
PORT5 = 3746


N_CYCLES = 1

statics = {1:(), 2:(), 3:(), 4:(), 5:()}


def initialize_threads():
    clients = []

    
    # workaround to initialize properly server mode of UDK
    client1 = BalancedWeaponClient(PORT1)
    client2 = BalancedWeaponClient(PORT2)
    client3 = BalancedWeaponClient(PORT3)
    client4 = BalancedWeaponClient(PORT4)
    client5 = BalancedWeaponClient(PORT5)


    clients.append(client1)
    clients.append(client2)
    clients.append(client3)
    clients.append(client4)
    clients.append(client5)

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()


# Run the simulation on the server side (UDK)
def simulate_population(iterations) :

    stats = {}
    threads = []

    # Create new threads
    thread1 = TestClientThread(0, "Thread-1", PORT1, iterations)
    thread2 = TestClientThread(2, "Thread-2", PORT2, iterations*5)
    thread3 = TestClientThread(4, "Thread-3", PORT3, iterations*10)
    thread4 = TestClientThread(6, "Thread-4", PORT4, iterations*10)
    thread5 = TestClientThread(8, "Thread-5", PORT5, iterations*10)

    # Start new Threads
    thread1.start()
    thread2.start()
    thread3.start()
    thread4.start()
    thread5.start()

    # Add threads to thread list
    threads.append(thread1)
    threads.append(thread2)
    threads.append(thread3)
    threads.append(thread4)
    threads.append(thread5)

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats



def main():

    statics = {}

    initialize_threads()

    statics = simulate_population(4)

    print(statics)

    l1 = []
    l2 = []
    l3 = []
    l4 = []

    for key, val in statics.items() :
        if key%2 == 0:
            l1.append(val[0])
            l2.append(val[1])
            l3.append(val[2])
            l4.append(val[3])


    plt.figure(1)

    plt.boxplot([l1, l2, l3, l4], labels=list('ABCD'))


    plt.show()


main()