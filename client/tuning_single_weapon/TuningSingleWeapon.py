import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time


from decimal import *
from functools import partial
from operator import attrgetter

from Costants import NUM_BOTS
from Costants import NUM_SERVER
from Costants import INITIAL_PORT
from Costants import MAX_DURATION

from WeaponParameter import *

from BalancedWeaponClient import BalancedWeaponClient
from ClientThread import myThread
from ClusterProceduralWeapon import ClusterProceduralWeapon
from InitialPopulationSeed import getOneSeedWeapons

from math import log
from math import pow
from math import sqrt

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
ROF_MIN, ROF_MAX = RoF(MEDIUM)
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = Spread(LOW)
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = Ammo(MEDIUM)
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = ShotCost(VERY_HIGH)
#defualt Range 10000
RANGE_MIN, RANGE_MAX = Range(MEDIUM)

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = Speed(VERY_HIGH)
#default damage = 1
DMG_MIN, DMG_MAX = Damage(LOW)
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = DamageRad(LOW)
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = Gravity(LOW)

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN/100, GRAVITY_MAX/100)]

Weapon_Fixed = [1.05,  0.5,     30,      1,     8, 1350, 100,       42,      -1]

Weapon_Target = [1.1,   0.1,   30,      9,     2, 3500,  18,       20,      0]

print(limits)


N_CYCLES = 1
# size of the population
NUM_POP = 50

#MAX KILLS PER MATCH
MAX_KILLS = 20

#NUM OF NOT RUNNING SERVER
numServerCrashed = 0

def round_decorator(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            result = func(*args, **kargs)
            result = result/100
            return result
        return wrapper
    return decorator

toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", random.randint, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("attr_speed", random.randint, SPEED_MIN, SPEED_MAX)
toolbox.register("attr_dmg", random.randint, DMG_MIN, DMG_MAX)
toolbox.register("attr_dmg_rad", random.randint, DMG_RAD_MIN, DMG_RAD_MAX)
toolbox.register("attr_gravity", random.randint, GRAVITY_MIN, GRAVITY_MAX)

toolbox.decorate("attr_rof", round_decorator(0,1))
toolbox.decorate("attr_spread", round_decorator(0,1))
toolbox.decorate("attr_range", round_decorator(0,1))
toolbox.decorate("attr_gravity", round_decorator(0,1))

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                  toolbox.attr_shot_cost, toolbox.attr_range, toolbox.attr_speed,
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity ), n = 1)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def printWeapon(pop):
    i = 0
    for ind in pop :
        print("(" + str(i*2) + ")")
        i += 1
        print("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) )

        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    i = 0
    for ind in pop :
        pop_file.write("(" + str(i*2) + ")\n")
        i += 1
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) +"\n")

        pop_file.write("fitness: " + str(ind.fitness.values) + "\n")
        pop_file.write("*********************************************************" + "\n")
    pop_file.write("\n" + "============================================================================================================" + "\n")


def check_param(param, min, max):
    if param < min :
        param = min
    elif param > max :
        param = max

    return param

def check(param, n) :

    return check_param(param, limits[n][0], limits[n][1])

def checkBounds(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            offspring = func(*args, **kargs)
            for child in offspring:
                for i in range(len(child)):
                    child[i] = check(child[i], i)
            return offspring
        return wrapper
    return decorator

def initialize_server(PORT):
    clients = []

    for i in range(NUM_SERVER):
        clients.append(BalancedWeaponClient(PORT[i]))

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

def redo_simulation(indexToRedo, population, numServerCrashed, PORT):

    stats = {}
    threads = []
    # population index
    index = 0
    # flag to know if we have finished
    bSimulate = True

    temp = None

    while bSimulate:

        to_simulate = 0
        
        while to_simulate < NUM_SERVER - numServerCrashed and len(indexToRedo) != 0 :

            index = indexToRedo.pop()

            threads.append( myThread(index*2, "Thread-" + str(index), population, Weapon_Fixed, PORT[to_simulate]) )
            to_simulate += 1

        if len(indexToRedo) == 0 :
            bSimulate = False

        for t in threads:
            t.start()

        # Wait for all threads to complete
        for t in threads:
            temp = t.join()

            if temp != None :
                stats.update(temp)
            else :
                numServerCrashed += 1

                if NUM_SERVER - numServerCrashed == 0 :
                    bSimulate = False
                
                indexToRedo += [int(t.threadID/2)]

        threads = []

    return stats


# Run the simulation on the server side (UT3)
def simulate_population(population, numServerCrashed, PORT) :
    stats = {}
    #return stats, PORT, numServerCrashed
    threads = []
    # population index
    index = 0
    # flag to know if we have finished
    bSimulate = True

    temp = None

    indexToRedo = []

    to_simulate = 0

    while bSimulate:

        to_simulate = 0
        
        while to_simulate < NUM_SERVER - numServerCrashed and index < len(population) :

            if not population[index].fitness.valid :
                threads.append( myThread(index*2, "Thread-" + str(index), population, Weapon_Fixed, PORT[to_simulate]) )
                to_simulate += 1
            
            index += 1

        if index >= len(population) :
            bSimulate = False

        for t in threads:
            t.start()

        # Wait for all threads to complete
        for t in threads:
            temp = t.join()

            if temp != None :
                stats.update(temp)
            else :
                numServerCrashed += 1

                if NUM_SERVER - numServerCrashed == 0 :
                    bSimulate = False

                indexToRedo += [int(t.threadID/2)]
                PORT.remove(t.port)
                print(PORT)

        threads = []

    stats.update(redo_simulation(indexToRedo, population, numServerCrashed, PORT))

    return stats, PORT, numServerCrashed

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

def match_kills(index, statics) :

    total_kills = 0

    for key, val in statics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]

    total_kills = total_kills/MAX_KILLS

    return total_kills

def difference(index, pop) :

    total = 0
    diff = 0

    for j in range(9):
        norm1 = (pop[index][j] - limits[j][0])/(limits[j][1] - limits[j][0])
        norm2 = (Weapon_Fixed[j] - limits[j][0])/(limits[j][1] - limits[j][0])
        total = norm1 - norm2
        diff += pow(norm1 - norm2, 2)

    return sqrt(diff)/9



def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

# ATTENTION, you MUST return a tuple
def evaluate(index, statics, pop):
    #e = random.randint(0, 3)
    e = entropy(index*2, statics)
    print('entropy :' + str(index) + " " + str(e))
    e += match_kills(index*2, statics)
    e -= difference(index, pop)
    print('difference :' + str(index) + " " + str(difference(index, pop)))
    return e,


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutGaussian, mu = [0 for _ in range(9)],
                                              sigma  = [(limits[j][1] - limits[j][0])*0.1 for j in range(9)] , 
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

    PORT = INITIAL_PORT

    numServerCrashed = 0

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 10

    fitnesses = []
    gen_fitnesses = []
    statics = {}

    hof = tools.HallOfFame(1)

    initialize_server(PORT)

    statics, PORT, numServerCrashed = simulate_population(pop, numServerCrashed, PORT)

    logbook_file.write("Gen : " + str(0) + "\n")
    for key, val in statics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")

    for key, val in statics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, statics, pop)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    hof.update(pop)
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

        statics, PORT, numServerCrashed = simulate_population(offspring, numServerCrashed, PORT)

        logbook_file.write("Gen : " + str(g+1) + "\n")
        for key, val in statics.items():
                logbook_file.write(str(key) + " : " + str(val) + "\n")
        logbook_file.write("*********************************************************\n")

        fitnesses = []

        # Evaluate only invalid population
        index = 0
        fit = 0,
        while index < len(offspring):

            if not offspring[index].fitness.valid :
                fit = toolbox.evaluate(index, statics, offspring)
                fitnesses += [fit]
                offspring[index].fitness.values = fit

            index += 1

        # The population is entirely replaced by the offspring
        pop[:] = offspring

        hof.update(pop)
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

    print("best individual")
    printWeapon(hof)
    pop_file.write("best individual\n")
    writeWeapon(hof, pop_file)

    pop_file.close()
    logbook_file.close()

    cluster = ClusterProceduralWeapon(pop, pop)
    cluster.cluster()

main()