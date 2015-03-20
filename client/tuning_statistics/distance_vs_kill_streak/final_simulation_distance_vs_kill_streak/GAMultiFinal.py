import os,sys,inspect

entropy_file = open("entropy_log.txt", "w")
os.chdir("..")

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

#####################################################################

#################
#GA PARAMETERS###
#################

NUM_PAR = 20

DEBUG = False

iter = 6

path = "final_simulation_distance_vs_kill_streak"


# size of the population
NUM_POP = 1000

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

#crossover (0.6 -1), mutation prob (1/nreal)
#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.9, 0.1, 50 #10 iter 3H

#eta c (5-50), eta_m (5-20)
ETA_C, ETA_M = 20, 20

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
        e = random.randint(0 , 3)
        dist1, dist2 = random.randint(0, 5), random.randint(0,5)
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
                                                       indpb = 1.0/(NUM_PAR))

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
        temp = toolbox.clone(offspring[i])
        offspring[i], = toolbox.mutate(offspring[i])

        for j in range(NUM_PAR*2):
            if temp[j] != offspring[i][j]:
                del offspring[i].fitness.values
                break

    statistics, port = simulate_population(offspring, port)

    logbook_file.write("Gen : " + str(gen+1) + "\n")
    for key, val in statistics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")

    # Evaluate only invalid population
    index = 0
    fit = 0,
    len_invalid = 0

    fitnesses = [0 for _ in range(len(offspring))]

    for index in range(len(offspring)):

        if not offspring[index].fitness.valid :
            fit = toolbox.evaluate(index, offspring, statistics)
            fitnesses[index] = fit
            len_invalid += 1
        else :
            fitnesses[index] = offspring[index].fitness.values

    for ind, fit in zip(offspring, fitnesses):
        ind.fitness.values = fit

    pop = offspring[:]

    return pop, port, len_invalid

def getPOP(pop, content, bIsFirst):

    line_readed = 0
    index = 0
    temp = []

    for string in content:
        
        if "Weapon" in string or "Projectile" in string:
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if ":" in splitted:
                    split_colon = splitted.split(":")
                    temp += [float(split_colon[1])]
                    if (len(temp) == 20):
                        for i in range(20):
                            pop[index][i] = temp[i]
                        temp = []
                        index += 1

            if index == NUM_POP:
                return pop

        line_readed += 1


def main():

    
    os.chdir(path)

    print(path)

    #clone initial port definition
    port = INITIAL_PORT[:]

    pop_file_to_read = open("population_cluster.txt", "r")
    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    #p_0 and q_0
    pop = toolbox.population(n = NUM_POP)

    content = pop_file_to_read.readlines()

    print(len(content))

    pop = getPOP(pop, content, True)

    printWeapon(pop)

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

    entropy_file.write("Gen : " + str(0) + "\n")

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statistics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    entropy_file.write("**********************************************************\n")

    record = mstats.compile(pop)
    hof.update(pop)

    logbook.record(gen = 0, evals = len(pop), **record)

    logbook.header = "gen", "evals", "entropy", "obj_1", "obj_2"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["obj_1"].header = "min", "avg", "max"
    logbook.chapters["obj_2"].header = "min", "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)
    
    log_string = str(logbook)

    logbook_file.write(log_string)

    best_ind = tools.selBest(pop, 1)[0]

    print("Best individuals:")
    printWeapon([best_ind])
    pop_file.write("Best individuals:\n")
    writeWeapon([best_ind], pop_file)

    pop_file.close()
    logbook_file.close()
    entropy_file.close()

    ##########################################################################

    ##########################
    ##plot multiobjective ####
    ##########################

    plt.figure(figsize=(16, 9))

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

    plt.scatter([pop[i].fitness.values[1] for i in range(len(pop))], [pop[i].fitness.values[0] for i in range(len(pop))])
    plt.scatter([hof_12[i].fitness.values[1] for i in range(len(hof_12))], [hof_12[i].fitness.values[0] for i in range(len(hof_12))], c=u'r')
    plt.plot([hof_12[i].fitness.values[1] for i in range(len(hof_12))], [hof_12[i].fitness.values[0] for i in range(len(hof_12))])

    plt.xlabel("Hit Time")
    plt.ylabel("Balance")

    plt.subplot(222)

    plt.scatter([pop[i].fitness.values[2] for i in range(len(pop))], [pop[i].fitness.values[0] for i in range(len(pop))])
    plt.scatter([hof_13[i].fitness.values[2] for i in range(len(hof_13))], [hof_13[i].fitness.values[0] for i in range(len(hof_13))], c=u'r')
    plt.plot([hof_13[i].fitness.values[2] for i in range(len(hof_13))], [hof_13[i].fitness.values[0] for i in range(len(hof_13))])

    plt.xlabel("Kill Streak")
    plt.ylabel("Balance")

    plt.subplot(224)

    plt.scatter([pop[i].fitness.values[2] for i in range(len(pop))], [pop[i].fitness.values[1] for i in range(len(pop))])
    plt.scatter([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))], c=u'r')
    plt.plot([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))])

    plt.xlabel("Kill Streak")
    plt.ylabel("Hit Time")

    plt.savefig("pareto.png", bbox_inches='tight')

    plt.close()
    ##########################################################################

main()
