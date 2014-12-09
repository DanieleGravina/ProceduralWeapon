import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from Costants import NUM_BOTS
from BalancedWeaponClient import BalancedWeaponClient
from ClientThread import myThread
from itertools import repeat

from math import log
from math import pow
from math import sqrt
from math import fsum

from deap import base
from deap import creator
from deap import tools

creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

PORT1 = 3742
PORT2 = 3743
PORT3 = 3744
PORT4 = 3745
PORT5 = 3746

WEIGHT = 100

###############
# Weapon ######
###############

#default Rof = 100
ROF_MIN, ROF_MAX = 1, 500
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 50
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 1000
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 10
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 10, 100000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 10, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 1, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = 1, 100

limits = [(ROF_MIN, ROF_MAX), (SPREAD_MIN, SPREAD_MAX), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN, RANGE_MAX),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX)]


N_CYCLES = 1
# size of the population
NUM_POP = 10

toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", random.randint, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("attr_speed", random.randint, SPEED_MIN, SPEED_MAX)
toolbox.register("attr_dmg", random.randint, DMG_MIN, DMG_MAX)
toolbox.register("attr_dmg_rad", random.randint, DMG_RAD_MIN, DMG_RAD_MAX)
toolbox.register("attr_gravity", random.randint, GRAVITY_MIN, GRAVITY_MAX)

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                  toolbox.attr_shot_cost, toolbox.attr_range, toolbox.attr_speed,
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity ), n = N_CYCLES)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def printWeapon(pop):
    print("\n")
    for ind in pop :
        print("Weapon "+ " Rof:" + "{0:.2f}".format(ind[0]/100) + " Spread:" + "{0:.2f}".format(ind[1]/10) + " MaxAmmo:" + "{0:.2f}".format(ind[2]) 
            + " ShotCost:" + "{0:.2f}".format(ind[3]) + " Range:" + "{0:.2f}".format(ind[4]) )
        print("Projectile "+ " Speed:" + "{0:.2f}".format(ind[5]) + " Damage:" + "{0:.2f}".format(ind[6]) + " DamageRadius:" + "{0:.2f}".format(ind[7])
            + " Gravity:" + "{0:.2f}".format(ind[8]) )
        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    pop_file.write("\n")
    for ind in pop :
        pop_file.write("Weapon "+ " Rof:" + "{0:.2f}".format(ind[0]/100) + " Spread:" + "{0:.2f}".format(ind[1]/10) + " MaxAmmo:" + "{0:.2f}".format(ind[2]) 
            + " ShotCost:" + "{0:.2f}".format(ind[3]) + " Range:" + "{0:.2f}".format(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + "{0:.2f}".format(ind[5]) + " Damage:" + "{0:.2f}".format(ind[6]) + " DamageRadius:" + "{0:.2f}".format(ind[7])
            + " Gravity:" + "{0:.2f}".format(ind[8]) + "\n")
        pop_file.write("fitness: " + str(ind.fitness.values) + "\n")
        pop_file.write("*********************************************************" + "\n")



def check_param(param, min, max):

    if param < min :
        param = min
    elif param > max :
        param = max

def check(param, n) :

    check_param(param, limits[n][0], limits[n][1])

def checkBounds(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            offspring = func(*args, **kargs)
            for child in offspring:
                for i in range(len(child)):
                    check(child[i], i)
            return offspring
        return wrapper
    return decorator

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
def simulate_population(population, statics) :

    stats = {}
    threads = []

    # Create new threads
    thread1 = myThread(0, "Thread-1", population, statics, PORT1)
    thread2 = myThread(2, "Thread-2", population, statics, PORT2)
    thread3 = myThread(4, "Thread-3", population, statics, PORT3)
    thread4 = myThread(6, "Thread-4", population, statics, PORT4)
    thread5 = myThread(8, "Thread-5", population, statics, PORT5)

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

def entropy(index, statics) :

    e = 0

    total_kills = 0
    total_dies = 0

    if index % 2 != 0 :
        ind = index - 1
    else :
        ind = index

    for key, val in statics.items():
        if key >= ind and key < ind + NUM_BOTS :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(ind, ind + NUM_BOTS):
        e += evaluate_entropy(i, statics, total_kills, total_dies, NUM_BOTS)

    if index == ind :

        suicides = statics[index][1] - statics[index + 1][0]

    else :

        suicides = statics[index - 1][1] - statics[index][0]

    e -= suicides*0.1

    if e < 0 :
        e = 0

    return e 


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

def evaluate_difference(index, population):

    if index % 2 != 0 :
        ind = index - 1
    else :
        ind = index

    diff = 0

    for j in range(9):
        den = limits[j][1] - limits[j][0]
        norm1 = (population[ind][j] - limits[j][0])/den
        norm2 = (population[ind + 1][j] - limits[j][0])/den
        diff += pow(norm1 - norm2, 2)

    result = sqrt(diff)

    return result

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e = entropy(index, statics)
    #e = random.randint(0,2)
    print('entropy :' + str(index) + " " + str(e))
    diff = evaluate_difference(index, population)
    print(' difference :' + str(index) + " " + str(diff))
    return e, diff


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutUniformInt, low = [limits[j][0] for j in range(9)],
                                                up  = [limits[j][1] for j in range(9)], 
                                                indpb = 0.1)

toolbox.register("select", tools.selTournament, tournsize = 2)

toolbox.decorate("mate", checkBounds(0,1))
toolbox.decorate("mutate", checkBounds(0,1))

toolbox.register("evaluate", evaluate)


stats1 = tools.Statistics(key=lambda ind: ind.fitness.values[0])

stats1.register("avg", numpy.mean)
stats1.register("std", numpy.std)
stats1.register("min", numpy.min)
stats1.register("max", numpy.max)

stats2 = tools.Statistics(key=lambda ind: ind.fitness.values[1])

stats2.register("avg", numpy.mean)
stats2.register("std", numpy.std)
stats2.register("min", numpy.min)
stats2.register("max", numpy.max)

mstats = tools.MultiStatistics(entropy=stats1, diff=stats2)

logbook = tools.Logbook()

def main():

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 20

    fitnesses = []
    statics = {}

    initialize_threads()

    statics = simulate_population(pop, statics)

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit


    record = mstats.compile(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "diff"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["diff"].header = "min", "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN):

        # Select the next generation individuals
        offspring = toolbox.select(pop, 2)
        # Clone the selected individuals
        offspring = list(map(toolbox.clone, offspring))

        while len(offspring) < len(pop) :

           child1 = toolbox.clone(toolbox.select(pop, 1))
           child2 = toolbox.clone(toolbox.select(pop, 1))

           if random.random() < CXPB:
               toolbox.mate(child1[0], child2[0])
               del child1[0].fitness.values
               del child2[0].fitness.values

           if random.random() < MUTPB:
               toolbox.mutate(child1[0])
               toolbox.mutate(child2[0])

           offspring += child1
           offspring += child2

        statics = simulate_population(offspring, statics)

        fit = 0, 0

        for individual in offspring:
           del individual.fitness.values

        for i in range(len(offspring)) :
           fit = toolbox.evaluate(i, offspring, statics)
           fitnesses += [fit]
           offspring[i].fitness.values = fit

        # The population is entirely replaced by the offspring
        pop[:] = offspring

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "diff"
        logbook.chapters["entropy"].header = "min", "avg", "max"
        logbook.chapters["diff"].header = "min", "avg", "max"

        print(logbook)

    log_string = str(logbook)

    writeWeapon(pop, pop_file)

    logbook_file.write(log_string)

    pop_file.close()
    logbook_file.close()

    gen = logbook.select("gen")
    fit_max = logbook.chapters["entropy"].select("avg")
    size_avgs = logbook.chapters["entropy"].select("max")
    fit_min = logbook.chapters["entropy"].select("min")

    fig, ax1 = plt.subplots()
    line1 = ax1.plot(gen, fit_max, "b-", label="Avg Fitness")
    ax1.set_xlabel("Generation")
    ax1.set_ylabel("Fitness", color="b")
    for tl in ax1.get_yticklabels():
        tl.set_color("b")

    ax2 = ax1.twinx()
    line2 = ax2.plot(gen, size_avgs, "r-", label="Max fitness")
    ax2.set_ylabel("Max fitness", color="r")
    for tl in ax2.get_yticklabels():
        tl.set_color("r")

    lns = line1 + line2 
    labs = [l.get_label() for l in lns]
    ax1.legend(lns, labs, loc="center right")

    plt.figure(1)

    plt.plot(gen, fit_max, "b-", label="Max Fitness")


    plt.show()


main()