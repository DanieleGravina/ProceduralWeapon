import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from functools import partial
from operator import attrgetter

from Costants import NUM_BOTS
from Costants import NUM_SERVER
from Costants import PORT

from BalancedWeaponClient import BalancedWeaponClient
from ClientThread import myThread

from math import log

from deap import base
from deap import creator
from deap import tools

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

###############
# Weapon ######
###############

#default Rof = 100
ROF_MIN, ROF_MAX = 1, 1000
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 50
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 999
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 100
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 1, 1000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 1, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 1, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = -20, 20

limits = [(ROF_MIN, ROF_MAX), (SPREAD_MIN, SPREAD_MAX), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN, RANGE_MAX),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX)]


N_CYCLES = 2
# size of the population
NUM_POP = 50

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

        print("Weapon "+ " Rof:" + str(ind[9]/100) + " Spread:" + str(ind[10]/10) + " MaxAmmo:" + str(ind[11]) 
            + " ShotCost:" + str(ind[12]) + " Range:" + str(ind[13]) )
        print("Projectile "+ " Speed:" + str(ind[14]) + " Damage:" + str(ind[15]) + " DamageRadius:" + str(ind[16])
            + " Gravity:" + str(ind[17]) )

        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    for ind in pop :
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]/100) + " Spread:" + str(ind[1]/10) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) +"\n")

        pop_file.write("Weapon "+ " Rof:" + str(ind[9]/100) + " Spread:" + str(ind[10]/10) + " MaxAmmo:" + str(ind[11]) 
            + " ShotCost:" + str(ind[12]) + " Range:" + str(ind[13]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[14]) + " Damage:" + str(ind[15]) + " DamageRadius:" + str(ind[16])
            + " Gravity:" + str(ind[17]) + "\n")

        pop_file.write("fitness: " + str(ind.fitness.values) + "\n")
        pop_file.write("*********************************************************" + "\n")
    pop_file.write("\n" + "============================================================================================================" + "\n")


def check_param(param, min, max):
    if param < min :
        param = min
    elif param > max :
        param = max

def check(param, n) :

    check_param(param, limits[n % 9][0], limits[n % 9][1])

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

def initialize_server():
    clients = []

    for i in range(NUM_SERVER):
        clients.append(BalancedWeaponClient(PORT[i]))

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

# Run the simulation on the server side (UT3)
def simulate_population(population) :

    stats = {}
    threads = []
    # population index
    index = 0
    # flag to know if we have finished
    bSimulate = True

    while bSimulate:

        to_simulate = 0
        
        while to_simulate < NUM_SERVER and index < len(population) :

            if not population[index].fitness.valid :
                threads.append( myThread(index*2, "Thread-" + str(index), population, PORT[to_simulate]) )
                to_simulate += 1
            
            index += 1

        if index >= len(population) :
            bSimulate = False

        for t in threads:
            t.start()

        # Wait for all threads to complete
        for t in threads:
            stats.update(t.join())

        threads = []


    return stats

def entropy(index, statics) :

    e = 0

    total_kills = 0
    total_dies = 0

    for key, val in statics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(index, index + NUM_BOTS):
        e += evaluate_entropy(i, statics, total_kills, total_dies, NUM_BOTS)

    return e


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

# ATTENTION, you MUST return a tuple
def evaluate(index, statics):

    e = entropy(index*2, statics)
    print('entropy :' + str(index) + " " + str(e))
    return e,


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutUniformInt, low = [limits[j][0] for j in range(9)] + [limits[j][0] for j in range(9)],
                                                up  = [limits[j][1] for j in range(9)] + [limits[j][1] for j in range(9)], 
                                                indpb = 0.1)

toolbox.register("select", tools.selTournament, tournsize = 3)

toolbox.decorate("mate", checkBounds(0,1))
toolbox.decorate("mutate", checkBounds(0,1))

toolbox.register("evaluate", evaluate)

stats = tools.Statistics(key=lambda ind: ind.fitness.values)

stats.register("avg", numpy.mean)
stats.register("std", numpy.std)
stats.register("min", numpy.min)
stats.register("max", numpy.max)

logbook = tools.Logbook()

def main():

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 20

    fitnesses = []
    gen_fitnesses = []
    statics = {}

    initialize_server()

    statics = simulate_population(pop)

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, statics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    record = stats.compile(pop)
    logbook.record(gen = 0, **record)

    logbook.header = "gen", "avg", "std", "min", "max"

    print(logbook)

    for g in range(NGEN - 1):

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

        statics = simulate_population(offspring)

        fitnesses = []

        # Evaluate only invalid population
        index = 0
        fit = 0,
        while index < len(offspring):

            if not offspring[index].fitness.valid :
                fit = toolbox.evaluate(index, statics)
                fitnesses += [fit]
                offspring[index].fitness.values = fit

            index += 1

        # The population is entirely replaced by the offspring
        pop[:] = offspring

        record = stats.compile(pop)

        printWeapon(pop)

        writeWeapon(pop, pop_file)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "avg", "std", "min", "max"

        print(logbook)

    plt.figure(1)

    gen = logbook.select("gen")
    fit_avg = logbook.select("avg")
    fit_max = logbook.select("max")
    fit_min = logbook.select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Entropy")

    plt.show()

    log_string = str(logbook)

    writeWeapon(pop, pop_file)

    logbook_file.write(log_string)

    pop_file.close()
    logbook_file.close()


main()