import os,sys,inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0,parentdir) 

import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import itertools
import threading

from Costants import *

from BalancedWeaponClient import BalancedWeaponClient
from SimulationThread import SimulationThread
from itertools import repeat

from math import log
from math import pow
from math import sqrt
from math import fsum

from deap import base
from deap import creator
from deap import tools
from deap.tools.emo import assignCrowdingDist

creator.create("FitnessMax", base.Fitness, weights = (1.0,))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

def round_decorator(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            result = func(*args, **kargs)
            result = result/100
            return result
        return wrapper
    return decorator

N_CYCLES = 2

#####################################################################

#################
#GA PARAMETERS###
#################


# size of the population
NUM_POP = 100

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.6, 0.1, 25 #160 min

#eta c (5-50), eta_m (5-20)
ETA_C, ETA_M = 10, 5

#####################################################################

# Custum random parameter generator for special effect 
def custumRandom(min, max):

    return random.randint(min, max)

    op_choice = random.random()

    m = min

    if min < 0 :
        m = (min + max) / 2

    if op_choice <= 0.25 :
        return m
    else :
        return random.randint(min, max)


toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", custumRandom, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("attr_speed", random.randint, SPEED_MIN, SPEED_MAX)
toolbox.register("attr_dmg", random.randint, DMG_MIN, DMG_MAX)
toolbox.register("attr_dmg_rad", random.randint, DMG_RAD_MIN, DMG_RAD_MAX)
toolbox.register("attr_gravity", custumRandom, GRAVITY_MIN, GRAVITY_MAX)
toolbox.register("attr_explosive", custumRandom, EXPLOSIVE_MIN, EXPLOSIVE_MAX)

toolbox.decorate("attr_rof", round_decorator(0,1))
toolbox.decorate("attr_spread", round_decorator(0,1))
toolbox.decorate("attr_range", round_decorator(0,1))

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                  toolbox.attr_shot_cost, toolbox.attr_range, toolbox.attr_speed,
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity, 
                  toolbox.attr_explosive ), n = N_CYCLES)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def printWeapon(pop):
    i = 0
    for ind in pop :
        print("(" + str(i*2) + ")")
        i += 1
        print("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]))

        print("Weapon "+ " Rof:" + str(ind[10]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
            + " ShotCost:" + str(ind[13]) + " Range:" + str(ind[14]) )
        print("Projectile "+ " Speed:" + str(ind[15]) + " Damage:" + str(ind[16]) + " DamageRadius:" + str(ind[17])
            + " Gravity:" + str(ind[18]) + " Explosive:" + str(ind[19]))

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
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) +"\n")

        pop_file.write("Weapon "+ " Rof:" + str(ind[10]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
            + " ShotCost:" + str(ind[13]) + " Range:" + str(ind[14]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[15]) + " Damage:" + str(ind[16]) + " DamageRadius:" + str(ind[17])
            + " Gravity:" + str(ind[18]) + " Explosive:" + str(ind[19]) + "\n")

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

    return check_param(param, limits[n % 10][0], limits[n % 10][1])

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

def initialize_server(port): 
    clients = []

    for i in range(len(port)):
        clients.append(BalancedWeaponClient(port[i]))

    for c in clients :
        c.SendMaxDuration(MAX_DURATION)
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

# Run the simulation on the server side (UT3)
def simulate_population(population, port) :

    stats = {}
    pop = {}
    threads = []

    #return stats, port

    num_server = len(port)
    
    lock = threading.Lock()

    for i in range(len(population)):

        if not population[i].fitness.valid :
            pop.update({i*2 : population[i]})

    while len(pop) != 0 :

        for i in range(num_server):
            threads.append( SimulationThread(pop, i, port, lock) )

        for t in threads:
            t.start()

        for t in threads:
            stats.update(t.join())

        del threads

        threads = []

        num_server = len(port)

    return stats, port

def match_kills(index, statistics) :

    total_kills = 0

    for key, val in statistics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]

    return total_kills

def match_suicides(index, statistics) :
    suicides = 0
    suicides += statistics[index][1] - statistics[index + 1][0]
    suicides += statistics[index + 1][1] - statistics[index][0]

    return suicides

def entropy(index, statistics) :

    e = 0

    total_kills = 0
    total_dies = 0

    for key, val in statistics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(index, index + NUM_BOTS):
        e += evaluate_entropy(i, statistics, total_kills, total_dies, NUM_BOTS)

    print(str(index) + " entropy " + str(e) +
             " kills " + str(total_kills/GOAL_SCORE) + " suicides " + str(pow(9/10, match_suicides(index, statistics))))

    return e + total_kills/GOAL_SCORE + pow(9/10, match_suicides(index, statistics))

def evaluate_entropy(index, statistics, total_kills, total_dies, N) :

    kills = statistics[index][0]

    p_kills = 0 if total_kills == 0 else kills/total_kills

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    return -entropy_kill

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statistics):
    #e = random.randint(0 ,3)
    e = entropy(index*2, statistics)

    return e,

def customCrossover(ind1, ind2):

    return tools.cxSimulatedBinaryBounded(ind1,
                                            ind2,
                                            eta = ETA_C, 
                                            low  = [limits[j][0] for j in range(10)] + [limits[j][0] for j in range(10)], 
                                            up = [limits[j][1] for j in range(10)] + [limits[j][1] for j in range(10)])


toolbox.register("mate", customCrossover)


toolbox.register("mutate", tools.mutPolynomialBounded, eta = ETA_M,
                                                       low  = [limits[j][0] for j in range(10)] + [limits[j][0] for j in range(10)], 
                                                       up = [limits[j][1] for j in range(10)] + [limits[j][1] for j in range(10)],
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

hof = tools.HallOfFame(1)

def eaSimple(pop, gen, port, logbook_file):

    offspring = toolbox.select(pop, len(pop))
    # Clone the selected individuals
    offspring = list(map(toolbox.clone, offspring))
    
    # Apply crossover and mutation on the offspring
    for i in range(1, len(offspring), 2):
        if random.random() < CXPB:
            offspring[i-1], offspring[i] = toolbox.mate(offspring[i-1], offspring[i])
            del offspring[i-1].fitness.values, offspring[i].fitness.values
    
    for i in range(len(offspring)):
        if random.random() < MUTPB:
            offspring[i], = toolbox.mutate(offspring[i])
            del offspring[i].fitness.values

    statistics, port = simulate_population(offspring, port)

    logbook_file.write("Gen : " + str(gen+1) + "\n")
    for key, val in statistics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")

    # Evaluate only invalid population
    index = 0
    fit = 0,

    fitnesses = [0 for _ in range(len(offspring))]

    for index in range(len(offspring)):

        if not offspring[index].fitness.valid :
            fit = toolbox.evaluate(index, offspring, statistics)
            fitnesses[index] = fit
        else :
            fitnesses[index] = offspring[index].fitness.values

    for ind, fit in zip(offspring, fitnesses):
        ind.fitness.values = fit

    pop = offspring[:]

    return pop, port


def main():

    #clone initial port definition
    port = INITIAL_PORT[:]

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    #p_0 and q_0
    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    fitnesses = []

    statistics = {}

    initialize_server(port)

    statistics, port = simulate_population(pop, port)

    ###logbook update ####
    logbook_file.write("Gen : " + str(0) + "\n")
    for key, val in statistics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")
    ######################

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statistics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    record = stats.compile(pop)
    hof.update(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "avg", "std", "min", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN - 1):

        pop, port = eaSimple(pop, g, port, logbook_file)

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = stats.compile(pop)
        hof.update(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "avg", "std", "min", "max"

        print(logbook)
            


    logbook.header = "gen", "avg", "std", "min", "max"
    
    log_string = str(logbook)

    writeWeapon(pop, pop_file)

    logbook_file.write(log_string)

    print("Best individuals:")
    printWeapon(hof)
    pop_file.write("Best individuals:\n")
    writeWeapon(hof, pop_file)

    pop_file.close()
    logbook_file.close()

    #################################################################################

    ############################################
    ###plot min, avg, max of singles objectives#
    ############################################

    plt.figure(1)

    gen = logbook.select("gen")
    fit_avg = logbook.select("avg")
    fit_max = logbook.select("max")
    fit_min = logbook.select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Entropy")

    plt.show()

    '''

    real_pop = []

    for ind in pop:
        temp1 = ind[:10]
        temp2 = ind[10:]
        real_pop += [temp1]
        real_pop += [temp2]

    cluster = ClusterProceduralWeapon(real_pop, pop)
    cluster.cluster()
    '''



main()