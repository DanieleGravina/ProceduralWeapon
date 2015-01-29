import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import itertools
import threading

from Costants import NUM_BOTS
from Costants import NUM_SERVER
from Costants import INITIAL_PORT
from Costants import MAX_DURATION

from InitialPopulationSeed import getTwoSeedWeapons
from BalancedWeaponClient import BalancedWeaponClient
from ClusterProceduralWeapon import ClusterProceduralWeapon
from ClientThread import myThread
from itertools import repeat

from math import log
from math import pow
from math import sqrt
from math import fsum

from deap import base
from deap import creator
from deap import tools

creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, -1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

###############
# Weapon ######
###############

#default Rof = 100
ROF_MIN, ROF_MAX = 10, 1000
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 300
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 999
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 9
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 100, 10000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 1, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 0, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = -100, 100
#Explosion
EXPLOSIVE_MIN, EXPLOSIVE_MAX = 0, 500

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
NUM_POP = 50

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP*2
MU = NUM_POP

#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.5, 0.2, 5 #160 min

#####################################################################

toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", random.randint, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("attr_speed", random.randint, SPEED_MIN, SPEED_MAX)
toolbox.register("attr_dmg", random.randint, DMG_MIN, DMG_MAX)
toolbox.register("attr_dmg_rad", random.randint, DMG_RAD_MIN, DMG_RAD_MAX)
toolbox.register("attr_gravity", random.randint, GRAVITY_MIN, GRAVITY_MAX)
toolbox.register("attr_explosive", random.randint, EXPLOSIVE_MIN, EXPLOSIVE_MAX)

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

        pop_file.write("Weapon "+ " Rof:" + str(ind[9]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
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

        num_server = len(port)

    return stats, port

def match_kills(index, statics) :

    total_kills = 0

    for key, val in statics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]

    return total_kills

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

    return e


def evaluate_entropy(index, statistics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statistics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statistics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

def evaluate_distance(index, statistics):

    return statistics[index][4], statistics[index + 1][5]

def evaluate_delta_time(index, statistics):

    return statistics[index][2], statistics[index + 1][3]

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statistics):
    e = entropy(index*2, statistics)

    dist1, dist2 = evaluate_difference(index*2, statistics)
    
    print('entropy :' + str(index) + " " + str(e))
    print('distance :' + str(index) + " " + str(dist1) + " " + str(dist2))

    return e, dist1, dist2


toolbox.register("mate", tools.cxTwoPoint)


toolbox.register("mutate", tools.mutGaussian, mu = [0 for _ in range(20)],
                                              sigma  = [(limits[j][1] - limits[j][0])*0.1 for j in range(10)] + [(limits[j][1] - limits[j][0])*0.05 for j in range(10)] , 
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

mstats = tools.MultiStatistics(entropy = stats1, dist = stats2)

logbook = tools.Logbook()

hof = tools.ParetoFront()

def eaMuPlusLambda(pop, gen, port, logbook_file) :
    offspring = []

    for _ in range(LAMBDA):
        op_choice = random.random()
        if op_choice < CXPB:            # Apply crossover
            ind1, ind2 = list(map(toolbox.clone, random.sample(pop, 2)))
            ind1, ind2 = toolbox.mate(ind1, ind2)
            del ind1.fitness.values
            offspring.append(ind1)
        elif op_choice < CXPB + MUTPB:  # Apply mutation
            ind = toolbox.clone(random.choice(pop))
            ind, = toolbox.mutate(ind)
            del ind.fitness.values
            offspring.append(ind)
        else:                           # Apply reproduction
            offspring.append(random.choice(pop))

    statistics, port = simulate_population(offspring, port)


    logbook_file.write("Gen : " + str(gen+1) + "\n")
    for key, val in statistics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")

    # Evaluate only invalid population
    index = 0
    fit = 0,

    for index in range(len(offspring))

        if not offspring[index].fitness.valid :
            fit = toolbox.evaluate(index, offspring, statistics)
            fitnesses += [fit]
            offspring[index].fitness.values = fit

    pop[:] = toolbox.select(pop + offspring, MU)

    return pop, port


def main():

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
    for key, val in statics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")
    ######################

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statistics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit


    record = mstats.compile(pop)
    hof.update(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "dist1", "dist2"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["dist1"].header = "min", "avg", "max"
    logbook.chapters["dist2"].header = "min", "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN - 1):

        pop, port = eaMuPlusLambda(pop, g, port, logbook_file) 

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)
        hof.update(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "dist1", "dist2"
        logbook.chapters["entropy"].header = "min", "avg", "max"
        logbook.chapters["dist1"].header = "min", "avg", "max"
        logbook.chapters["dist2"].header = "min", "avg", "max"

        print(logbook)


    logbook.header = "gen", "entropy", "dist1", "dist2"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["dist1"].header = "min", "avg", "max"
    logbook.chapters["dist2"].header = "min", "avg", "max"
    
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

    plt.subplot(131)

    gen = logbook.select("gen")
    fit_avg = logbook.chapters["entropy"].select("avg")
    fit_max = logbook.chapters["entropy"].select("max")
    fit_min = logbook.chapters["entropy"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Entropy")

    plt.subplot(132)

    fit_avg = logbook.chapters["dist1"].select("avg")
    fit_max = logbook.chapters["dist1"].select("max")
    fit_min = logbook.chapters["dist1"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Distance1")

    plt.subplot(133)

    fit_avg = logbook.chapters["dist2"].select("avg")
    fit_max = logbook.chapters["dist2"].select("max")
    fit_min = logbook.chapters["dist2"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Distance2")

    ##########################################################################

    ##########################
    ##plot multiobjective ####
    ##########################

    plt.figure(2)

    e = [pop[i].fitness.values[0] for i in range(len(pop))]
    d1 = [pop[i].fitness.values[1] for i in range(len(pop))]
    d2 = [pop[i].fitness.values[2] for i in range(len(pop))]

    e_front = [hof[i].fitness.values[0] for i in range(len(hof))]
    d1_front = [hof[i].fitness.values[1] for i in range(len(hof))]
    d2_front = [hof[i].fitness.values[2] for i in range(len(hof))]

    patch_1 = mpatches.Patch(marker='^', label='entropy - distance 1')
    patch_2 = mpatches.Patch(marker='o', label='entropy - distance 2')
    patch_3 = mpatches.Patch(marker='V', label='distance 1 - distance 2')

    plt.legend(handles=[patch_1, patch_2, patch_3])

    plt.scatter(e, d1, marker=u'^')
    plt.scatter(e_front, d_front, c=u'r', marker=u'^')

    plt.scatter(e, d2, marker=u'o')
    plt.scatter(e_front, k_front, c=u'r', marker=u'o')

    plt.scatter(d1, d2, marker=u'V')
    plt.scatter(e_front, k_front, c=u'r', marker=u'V')

    ##########################################################################

    '''
    cluster_file = open("cluster.txt", "w")

    cluster_file.write("Hall of Fame cluster")

    real_pop = []

    for ind in pop:
        temp1 = ind[:10]
        temp2 = ind[10:]
        real_pop += [temp1]
        real_pop += [temp2]

    cluster = ClusterProceduralWeapon(real_pop, pop, cluster_file)
    cluster.cluster()
    '''



main()