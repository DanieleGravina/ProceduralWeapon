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

Weapon_1 = [RoF(MEDIUM), Spread(LOW), Ammo(LOW), ShotCost(LOW), Range(MEDIUM), 
            Speed(VERY_HIGH), Damage(LOW), DamageRad(LOW), Gravity(LOW)]

Weapon_Fixed = [1.05,  0.5,     30,      1,     8, 1350, 100,       42,      -1]

limits = []

for i in range(len(Weapon_1)):
   if i == 0 or i == 1 or i == 4 or i == 8 :
    limits += [(Weapon_1[i][0]/100, Weapon_1[i][1]/100)]
   else :
    limits += [(Weapon_1[i][0], Weapon_1[i][1])]

print(limits)


N_CYCLES = 1
# size of the population
NUM_POP_SEED = 25
NUM_POP_RANDOM = 25

#MAX KILLS PER MATCH
MAX_KILLS = 50

#NUM OF NOT RUNNING SERVER
numServerCrashed = 0


def TuningIndividual(container):

    result = []

    for i in range(len(Weapon_1)):
        if i == 0 or i == 1 or i == 4 or i == 8 :
            result += [random.randint(Weapon_1[i][0], Weapon_1[i][1]) / 100]
        else :
            result += [random.randint(Weapon_1[i][0], Weapon_1[i][1])]

    return container(result[i] for i in range(len(result)))

def SeedIndividual(container):
    result = getOneSeedWeapons()
    return container(result[i] for i in range(len(result)))


toolbox.register("individual", TuningIndividual, creator.Individual)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

toolbox.register("individual_guess", SeedIndividual, creator.Individual)
toolbox.register("population_guess", tools.initRepeat, list, toolbox.individual_guess)

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



def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

# ATTENTION, you MUST return a tuple
def evaluate(index, statics):
    #e = random.randint(0, 2)
    e = entropy(index*2, statics)
    print('entropy :' + str(index) + " " + str(e))
    e += match_kills(index*2, statics)
    return e,


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutGaussian, mu = [0 for _ in range(9)],
                                              sigma  = [(limits[j][1] - limits[j][0])*0.05 for j in range(9)] , 
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

    pop = toolbox.population(n = NUM_POP_RANDOM)
    pop += toolbox.population_guess(n = NUM_POP_SEED)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 20

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
        fitnesses += [toolbox.evaluate(i, statics)]

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
                fit = toolbox.evaluate(index, statics)
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