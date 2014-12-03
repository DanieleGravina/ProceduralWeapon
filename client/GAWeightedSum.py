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

from deap import base
from deap import creator
from deap import tools

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'
messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

PORT1 = 3742
PORT2 = 3743
PORT3 = 3744
PORT4 = 3745

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
RANGE_MIN, RANGE_MAX = 100, 100000

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


N_CYCLES = 1
# size of the population
NUM_POP = 8

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
    for ind in pop :
        print("Weapon "+ " Rof:" + str(ind[0]/100) + " Spread:" + str(ind[1]/10) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) )
        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")


def check_param(param, min, max):
    if param < min :
        param = min
    elif param > max :
        param = max

def check(param, n) :
    if n == 0:
        check_param(param, ROF_MIN, ROF_MAX)
    elif n == 1:
        check_param(param, SPREAD_MIN, SPREAD_MAX)
    elif n == 2:
        check_param(param, AMMO_MIN, AMMO_MAX)
    elif n == 3:
        check_param(param, SHOT_COST_MIN, SHOT_COST_MAX)
    elif n == 4:
        check_param(param, RANGE_MIN, RANGE_MAX)
    elif n == 5:
        check_param(param, SPEED_MIN, SPEED_MAX)
    elif n == 6:
        check_param(param, DMG_MIN, DMG_MAX)
    elif n == 7:
        check_param(param, DMG_RAD_MIN, DMG_RAD_MAX)
    elif n == 8:
        check_param(param, GRAVITY_MIN, GRAVITY_MAX)

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

# Run the simulation on the server side (UDK)
def simulate_population(population, statics) :

    stats = {}
    threads = []

    # Create new threads
    thread1 = myThread(0, "Thread-1", population, statics, PORT1)
    thread2 = myThread(2, "Thread-2", population, statics, PORT2)
    thread3 = myThread(4, "Thread-3", population, statics, PORT3)
    thread4 = myThread(6, "Thread-4", population, statics, PORT4)

    # Start new Threads
    thread1.start()
    thread2.start()
    thread3.start()
    thread4.start()

    # Add threads to thread list
    threads.append(thread1)
    threads.append(thread2)
    threads.append(thread3)
    threads.append(thread4)

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def entropy(index, statics) :

    e = 0

    total_kills = 0
    total_dies = 0

    ind = int(index/NUM_BOTS)

    for key, val in statics.items():
        if key >= ind and key < ind + NUM_BOTS :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(ind, ind + NUM_BOTS):
        e += evaluate_entropy(i, statics, total_kills, total_dies, NUM_BOTS)

    return e 


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

def evaluate_difference(index, population, entropy):

    ind = int(index/NUM_BOTS)

    p1 = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    p2 = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    e = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    if entropy == 0 :
        return entropy

    for i in range(len(population)):
        if i >= ind and i < ind + NUM_BOTS :
            for j in range(9):
                p1[j] = population[i][j]/(population[i][j] + population[i+1][j])
                p2[j] = population[i+1][j]/(population[i][j] + population[i+1][j])
                e[j] = -( p1[j]*log(p1[j], 2) + p2[j]*log(p2[j], 2) )
                if e[j] != 0 :
                    entropy += (1/e[j])*1/18

    return entropy

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e = entropy(index, statics)
    print('entropy :' + str(index) + " " + str(e))
    result = evaluate_difference(index, population, e)
    return result,


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutGaussian, mu    = [100, 0 , 40, 1, 10000, 1000, 1, 10, 1], 
                                              sigma = [ 10, 1,   1, 1,   100,   10, 1,  1, 1], 
                                              indpb = 0.1)

toolbox.register("select", tools.selTournament, tournsize=2)

toolbox.decorate("mate", checkBounds(0,1))
toolbox.decorate("mutate", checkBounds(0,1))

toolbox.register("evaluate", evaluate)

stats = tools.Statistics(key=lambda ind: ind.fitness.values)

stats.register("avg", numpy.mean)
stats.register("std", numpy.std)
stats.register("min", min)
stats.register("max", max)

logbook = tools.Logbook()

def main():

    pop_file = open("population.pkl", "w")
    logbook_file = open("logbook.pkl", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 20

    fitnesses = []
    gen_fitnesses = []
    statics = {}
    clients = []

    # workaround to initialize properly server mode of UDK
    client1 = BalancedWeaponClient(PORT1)
    client2 = BalancedWeaponClient(PORT2)
    client3 = BalancedWeaponClient(PORT3)
    client4 = BalancedWeaponClient(PORT4)

    clients.append(client1)
    clients.append(client2)
    clients.append(client3)
    clients.append(client4)

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

    statics = simulate_population(pop, statics)

    print(statics)

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    print(fitnesses)

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    record = stats.compile(pop)
    print(record)
    logbook.record(gen = 0, **record)

    logbook.header = "gen", "avg", "std", "min", "max"

    print(logbook)

    for g in range(NGEN):

        # Select the next generation individuals
        offspring = toolbox.select(pop, len(pop))
        # Clone the selected individuals
        offspring = list(map(toolbox.clone, offspring))

        # Apply crossover and mutation on the offspring
        for child1, child2 in zip(offspring[::2], offspring[1::2]):
            if random.random() < CXPB:
                toolbox.mate(child1, child2)
                del child1.fitness.values
                del child2.fitness.values

        for mutant in offspring:
            if random.random() < MUTPB:
                toolbox.mutate(mutant)
                del mutant.fitness.values

        statics = simulate_population(offspring, statics)

        fit = 0,

        for i in range(len(offspring)) :
            if not offspring[i].fitness.valid :
                fit = toolbox.evaluate(i, offspring, statics)
                fitnesses += [fit]
                offspring[i].fitness.values = fit

        print(fitnesses)

        # The population is entirely replaced by the offspring
        pop[:] = offspring

        record = stats.compile(pop)

        printWeapon(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "avg", "std", "min", "max"

        print(logbook)

    print(pop)

    gen = logbook.select("gen")
    fit_max = logbook.select("avg")
    size_avgs = logbook.select("max")

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

    plt.show()

    pop_string = str(pop)
    log_string = str(logbook)

    pop_file.write(pop_string)
    logbook_file.write(log_string)

    pop_file.close()
    logbook_file.close()


main()