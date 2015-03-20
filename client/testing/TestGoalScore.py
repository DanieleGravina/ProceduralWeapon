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
NUM_BOTS = 2

population = [5, 5, 5, 5, 5, 5, 5, 5]

NUM_SERVER = len(population)

statics = {}

speed1 = "1x"
speed2 = "8x"


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

    weapon = [[], []]

    weapon_file = open("weapons.txt", "r")

    content = weapon_file.readlines()

    temp = []

    i = 0

    for string in content:
        
        if "Weapon" in string or "Projectile" in string:
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if ":" in splitted:
                    split_colon = splitted.split(":")
                    temp += [float(split_colon[1])]
                    if (len(temp) == 10):
                        weapon[i] += temp
                        temp = []
                        i += 1

    threads = []
    GoalScore = [20, 20, 40, 40, 80, 80, 160, 160]
    TestWeapon = weapon

    print(TestWeapon)

    for i in range(NUM_SERVER):

        threads.append( TestClientThread(i, "Thread-" + str(i), PORT[i], population[i], TestWeapon, GoalScore[i]) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())



    return stats

def main():

    statics_file = open("statistics.txt", "w")

    statics = {}

    final_statistics = []

    initialize_server()

    statics = simulate_population()

    print(statics)

    for key, val in statics.items() :

        statics_file.write(str(key + 1) + "\n")
        statics_file.write(str(val[0]) + "\n")
        statics_file.write(str(val[1]) + "\n")
        statics_file.write(str(val[2]) + "\n")
        statics_file.write(str(val[3]) + "\n")
        statics_file.write(str(val[4]) + "\n")
        statics_file.write("***************************************************************************\n")

    statics_file.close()


main()