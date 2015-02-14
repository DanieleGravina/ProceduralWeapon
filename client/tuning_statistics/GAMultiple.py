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

#####################################################################

#################
#GA PARAMETERS###
#################

DEBUG = False


# size of the population
NUM_POP = 100

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

#crossover (0.6 -1), mutation prob (1/nreal)
#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.6, 0.1, 50 #10 iter 3H

#eta c (5-50), eta_m (5-20)
ETA_C, ETA_M = 20, 50

obj_1 = DISTANCE
obj_2 = KILL_STREAK

weight_obj_1 = MAXIMIZE
weight_obj_2 = MAXIMIZE


N_CYCLES = 2

#####################################################################

creator.create("FitnessMax", base.Fitness, weights = (1.0, weight_obj_1, weight_obj_2))
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

# Custum random parameter generator for special effect 
def custumRandom(min, max):

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

    param = float("{0:.2f}".format(param))
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
    if DEBUG :
        return 

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

    if DEBUG :
        return stats, port

    num_server = len(port)
    
    lock = threading.Lock()

    for i in range(len(population)):

        if not population[i].fitness.valid :
            pop.update( {i*2 : population[i]} )

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

def evaluate_objective(index, statistics, objective_1, objective_2):

    return statistics[index][objective_1], statistics[index + 1][objective_2]

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statistics):

    if DEBUG:
        e = random.randint(0 ,2)
        dist1, dist2 = random.randint(0, 5), random.randint(0, 5)
        return e, dist1, dist2 

    e = entropy(index*2, statistics)

    dist1, dist2 = evaluate_objective(index*2, statistics, obj_1, obj_2)

    print("distance " +  str(dist1) + " " + str(dist2))

    return e, dist1, dist2

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

toolbox.register("select", tools.selNSGA2)

toolbox.decorate("mate", checkBounds(0,1))
toolbox.decorate("mutate", checkBounds(0,1))

toolbox.register("evaluate", evaluate)


stats1 = tools.Statistics(key = lambda ind: ind.fitness.values[0])

stats1.register("avg", numpy.mean)
stats1.register("std", numpy.std)
stats1.register("min", numpy.min)
stats1.register("max", numpy.max)

stats2 = tools.Statistics(key = lambda ind: ind.fitness.values[1])

stats2.register("avg", numpy.mean)
stats2.register("std", numpy.std)
stats2.register("min", numpy.min)
stats2.register("max", numpy.max)

stats3 = tools.Statistics(key = lambda ind: ind.fitness.values[2])

stats3.register("avg", numpy.mean)
stats3.register("std", numpy.std)
stats3.register("min", numpy.min)
stats3.register("max", numpy.max)

mstats = tools.MultiStatistics(entropy = stats1, obj_1 = stats2, obj_2 = stats3)

logbook = tools.Logbook()

hof = tools.ParetoFront()

def binary_tournament(ind1, ind2):
        if ind1.fitness.dominates(ind2.fitness):
            return ind1
        elif ind2.fitness.dominates(ind1.fitness):
            return ind2

        if ind1.fitness.crowding_dist < ind2.fitness.crowding_dist:
            return ind2
        elif ind1.fitness.crowding_dist > ind2.fitness.crowding_dist:
            return ind1

        if random.random() <= 0.5:
            return ind1
        return ind2


def eaMuPlusLambda(pop, gen, port, logbook_file) :
    offspring = []

    while len(offspring) < LAMBDA:
        op_choice = random.random()
        if op_choice < CXPB:            # Apply crossover
            ind1, ind2 = random.sample(pop, 2)
            ind3, ind4 = random.sample(pop, 2)

            child1 = binary_tournament(ind1, ind2)
            child2 = binary_tournament(ind3, ind4)

            ind1, ind2 = map(toolbox.clone, [child1, child2])

            ind1, ind2 = toolbox.mate(ind1, ind2)

            del ind1.fitness.values
            del ind2.fitness.values

            offspring.append(ind1)
            offspring.append(ind2)

        elif op_choice < CXPB + MUTPB:  # Apply mutation
            ind1, ind2 = random.sample(pop, 2)
            child = binary_tournament(ind1, ind2)

            ind = toolbox.clone(child)

            ind, = toolbox.mutate(ind)
            del ind.fitness.values
            offspring.append(ind)

        else:

            ind1, ind2 = random.sample(pop, 2)
            child = binary_tournament(ind1, ind2)     # Apply reproduction

            ind = toolbox.clone(child) 
            offspring.append(ind)

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

    pop[:] = toolbox.select(pop + offspring, MU)

    return pop, port


def main():

    iter = 0

    path = "distance_vs_kill_streak_100_pop_50_iter_simulated_binary_" + str(iter)

    try :
        os.makedirs(path)
        os.chdir(path)
    except :
        pass

    #clone initial port definition
    port = INITIAL_PORT[:]

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

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

    pop[:] = toolbox.select(pop, MU)

    record = mstats.compile(pop)
    hof.update(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "obj_1", "obj_2"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["obj_1"].header = "min", "avg", "max"
    logbook.chapters["obj_2"].header = "min", "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN):

        pop, port = eaMuPlusLambda(pop, g, port, logbook_file) 

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)
        hof.update(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "obj_1", "obj_2"
        logbook.chapters["entropy"].header = "min", "avg", "max"
        logbook.chapters["obj_1"].header = "min", "avg", "max"
        logbook.chapters["obj_2"].header = "min", "avg", "max"

        print(logbook)


    logbook.header = "gen", "entropy", "obj_1", "obj_2"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["obj_1"].header = "min", "avg", "max"
    logbook.chapters["obj_2"].header = "min", "avg", "max"
    
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

    plt.subplot(221)

    gen = logbook.select("gen")
    fit_avg = logbook.chapters["entropy"].select("avg")
    fit_max = logbook.chapters["entropy"].select("max")
    fit_min = logbook.chapters["entropy"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Entropy")

    plt.subplot(222)

    fit_avg = logbook.chapters["obj_1"].select("avg")
    fit_max = logbook.chapters["obj_1"].select("max")
    fit_min = logbook.chapters["obj_1"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Distance1")

    plt.subplot(223)

    fit_avg = logbook.chapters["obj_2"].select("avg")
    fit_max = logbook.chapters["obj_2"].select("max")
    fit_min = logbook.chapters["obj_2"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Distance2")

    plt.savefig("graph.png", bbox_inches='tight')

    ##########################################################################

    ##########################
    ##plot multiobjective ####
    ##########################

    plt.figure(2)

    pop_12 = []
    pop_13 = []
    pop_23 = []



    for i in range(len(hof)) :
        pop_12 += [toolbox.clone(hof[i])]
        del pop_12[i].fitness.values
        pop_12[i].fitness.values = hof[i].fitness.values[0], hof[i].fitness.values[1], 0

    hof_12 = tools.ParetoFront()
    hof_12.update(pop_12)

    for i in range(len(hof)) :
        pop_13 += [toolbox.clone(hof[i])]
        del pop_13[i].fitness.values
        pop_13[i].fitness.values = hof[i].fitness.values[0], 0, hof[i].fitness.values[2]

    hof_13 = tools.ParetoFront()
    hof_13.update(pop_13)

    for i in range(len(hof)) :
        pop_23 += [toolbox.clone(hof[i])]
        del pop_23[i].fitness.values
        pop_23[i].fitness.values = 0, hof[i].fitness.values[1], hof[i].fitness.values[2]

    hof_23 = tools.ParetoFront()
    hof_23.update(pop_23)

    plt.subplot(221)

    plt.scatter([pop_12[i].fitness.values[1] for i in range(len(pop_12))], [pop_12[i].fitness.values[0] for i in range(len(pop_12))])
    plt.scatter([hof_12[i].fitness.values[1] for i in range(len(hof_12))], [hof_12[i].fitness.values[0] for i in range(len(hof_12))], c=u'r')

    plt.xlabel("Objective1")
    plt.ylabel("Entropy")

    plt.subplot(222)

    plt.scatter([pop_13[i].fitness.values[2] for i in range(len(pop_13))], [pop_13[i].fitness.values[0] for i in range(len(pop_13))])
    plt.scatter([hof_13[i].fitness.values[2] for i in range(len(hof_13))], [hof_13[i].fitness.values[0] for i in range(len(hof_13))], c=u'r')

    plt.xlabel("Objective2")
    plt.ylabel("Entropy")

    plt.subplot(224)

    plt.scatter([pop_23[i].fitness.values[2] for i in range(len(pop_23))], [pop_23[i].fitness.values[1] for i in range(len(pop_23))])
    plt.scatter([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))], c=u'r')

    plt.xlabel("Objective2")
    plt.ylabel("Objective1")

    #plt.legend([f1, f2, f3 ], ["entropy - distance 1", "entropy - distance 2", "distance 1 - distance 2"])

    plt.savefig("pareto.png", bbox_inches='tight')
    ##########################################################################


main()