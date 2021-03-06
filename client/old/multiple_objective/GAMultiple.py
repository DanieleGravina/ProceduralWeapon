import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import itertools

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

creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, 1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

WEIGHT = 100

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
SHOT_COST_MIN, SHOT_COST_MAX = 1, 10
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
GRAVITY_MIN, GRAVITY_MAX = -2000, 2000

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN/100, GRAVITY_MAX/100)]

def round_decorator(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            result = func(*args, **kargs)
            result = result/100
            return result
        return wrapper
    return decorator

def SeedIndividual(container):
    result = getTwoSeedWeapons()
    return container(result[i] for i in range(len(result)))


N_CYCLES = 2
# size of the population
NUM_POP_SEED = 0
NUM_POP_RANDOM = 50
NUM_POP = NUM_POP_SEED + NUM_POP_RANDOM

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

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
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity ), n = N_CYCLES)

toolbox.register("individual_guess", SeedIndividual, creator.Individual)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)
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

        print("Weapon "+ " Rof:" + str(ind[9]) + " Spread:" + str(ind[10]) + " MaxAmmo:" + str(ind[11]) 
            + " ShotCost:" + str(ind[12]) + " Range:" + str(ind[13]) )
        print("Projectile "+ " Speed:" + str(ind[14]) + " Damage:" + str(ind[15]) + " DamageRadius:" + str(ind[16])
            + " Gravity:" + str(ind[17]) )

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

        pop_file.write("Weapon "+ " Rof:" + str(ind[9]) + " Spread:" + str(ind[10]) + " MaxAmmo:" + str(ind[11]) 
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

    return param

def check(param, n) :

    return check_param(param, limits[n % 9][0], limits[n % 9][1])

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
        c.SendMaxDuration(MAX_DURATION)
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

            threads.append( myThread(index*2, "Thread-" + str(index), population, PORT[to_simulate]) )
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
                threads.append( myThread(index*2, "Thread-" + str(index), population, PORT[to_simulate]) )
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

def match_kills(index, statics) :

    total_kills = 0

    for key, val in statics.items():
        if key >= index and key <= index + (NUM_BOTS - 1) :
            total_kills += val[0]

    return total_kills

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

    if index + 1 < NUM_POP*NUM_BOTS :

        suicides = (statics[index][1] - statics[index + 1][0]) + (statics[index + 1][1] - statics[index][0])

    else : 
        print("error index + 1 > NUM_POP*NUM_BOTS")
        suicides = 0

    return e


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

def evaluate_difference(index, population):

    diff = 0

    ind = index

    for j in range(9):
        den = limits[j][1] - limits[j][0]
        norm1 = (population[ind][j] - limits[j][0])/den
        norm2 = (population[ind][j + 9] - limits[j][0])/den
        diff += pow(norm1 - norm2, 2)

    result = sqrt(diff)

    return 1

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e = entropy(index*2, statics)
    #e, tot_kills = random.randint(0,2), random.randint(0, 25)
    tot_kills = match_kills(index*2, statics)
    diff = evaluate_difference(index, population)
    
    print('entropy :' + str(index) + " " + str(e))
    print('difference :' + str(index) + " " + str(diff))
    print('tot kills :' + str(index) + " " + str(tot_kills))

    return e, diff, tot_kills


toolbox.register("mate", tools.cxTwoPoint)


toolbox.register("mutate", tools.mutGaussian, mu = [0 for _ in range(18)],
                                              sigma  = [(limits[j][1] - limits[j][0])*0.05 for j in range(9)] + [(limits[j][1] - limits[j][0])*0.05 for j in range(9)] , 
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

mstats = tools.MultiStatistics(entropy = stats1, diff = stats2, kills = stats3)

logbook = tools.Logbook()

hof = tools.ParetoFront()
history = tools.History()

toolbox.decorate("mate", history.decorator)
toolbox.decorate("mutate", history.decorator)

def main():

    PORT = INITIAL_PORT

    numServerCrashed = 0

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP_RANDOM)
    pop += toolbox.population_guess(n = NUM_POP_SEED)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 30 #160 min

    fitnesses = []
    statics = {}

    initialize_server(PORT)

    statics, PORT, numServerCrashed = simulate_population(pop, numServerCrashed, PORT)

    logbook_file.write("Gen : " + str(0) + "\n")
    for key, val in statics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")
    logbook_file.write("*********************************************************\n")

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit


    record = mstats.compile(pop)
    hof.update(pop)
    history.update(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "diff", "kills"
    logbook.chapters["entropy"].header = "avg", "max"
    logbook.chapters["diff"].header = "avg", "max"
    logbook.chapters["kills"].header = "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN - 1):

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

        statics, PORT, numServerCrashed = simulate_population(offspring, numServerCrashed, PORT)

        logbook_file.write("Gen : " + str(g+1) + "\n")
        for key, val in statics.items():
                logbook_file.write(str(key) + " : " + str(val) + "\n")
        logbook_file.write("*********************************************************\n")

        fitnesses = []

        # Evaluate only invalid population
        index = 0
        fit = 0,
        while index < len(pop):

            if not offspring[index].fitness.valid :
                fit = toolbox.evaluate(index, offspring, statics)
                fitnesses += [fit]
                offspring[index].fitness.values = fit

            index += 1

        pop[:] = toolbox.select(pop + offspring, MU)

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)
        hof.update(pop)
        history.update(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "diff", "kills"
        logbook.chapters["entropy"].header = "avg", "max"
        logbook.chapters["diff"].header = "avg", "max"
        logbook.chapters["kills"].header = "avg", "max"

        print(logbook)


    logbook.header = "gen", "entropy", "diff", "kills"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["diff"].header = "min", "avg", "max"
    logbook.chapters["kills"].header = "min", "avg", "max"
    
    log_string = str(logbook)

    writeWeapon(pop, pop_file)

    logbook_file.write(log_string)

    print("Best individuals:")
    printWeapon(hof)
    pop_file.write("Best individuals:\n")
    writeWeapon(hof, pop_file)

    pop_file.close()
    logbook_file.close()

    plt.figure(1)

    gen = logbook.select("gen")
    fit_avg = logbook.chapters["entropy"].select("avg")
    fit_max = logbook.chapters["entropy"].select("max")
    fit_min = logbook.chapters["entropy"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Entropy")

    plt.figure(2)

    fit_avg = logbook.chapters["diff"].select("avg")
    fit_max = logbook.chapters["diff"].select("max")
    fit_min = logbook.chapters["diff"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Difference")

    plt.figure(3)

    fit_avg = logbook.chapters["kills"].select("avg")
    fit_max = logbook.chapters["kills"].select("max")
    fit_min = logbook.chapters["kills"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("kills")

    e = [pop[i].fitness.values[0] for i in range(len(pop))]
    d = [pop[i].fitness.values[1] for i in range(len(pop))]
    k = [pop[i].fitness.values[2] for i in range(len(pop))]

    e_front = [hof[i].fitness.values[0] for i in range(len(hof))]
    d_front = [hof[i].fitness.values[1] for i in range(len(hof))]
    k_front = [hof[i].fitness.values[2] for i in range(len(hof))]

    plt.figure(4)

    plt.xlabel("Entropy")
    plt.ylabel("Difference")

    plt.scatter(e, d)
    plt.scatter(e_front, d_front, c=u'r')
    plt.plot(e_front, d_front)

    plt.figure(5)

    plt.xlabel("Difference")
    plt.ylabel("Number of Kills")

    plt.scatter(d, k)
    plt.scatter(d_front, k_front, c=u'r')
    plt.plot(d_front, k_front)

    plt.figure(6)

    plt.xlabel("Entropy")
    plt.ylabel("Number of kills")

    plt.scatter(e, k)
    plt.scatter(e_front, k_front, c=u'r')
    plt.plot(e_front, k_front)

    cluster_file = open("cluster.txt", "w")

    cluster_file.write("Hall of Fame cluster")

    '''
    real_pop = []

    for ind in hof:
        temp1 = ind[:9]
        temp2 = ind[9:]
        real_pop += [temp1]
        real_pop += [temp2]

    cluster = ClusterProceduralWeapon(real_pop, hof, cluster_file)
    cluster.cluster()

    cluster_file.write("Population cluster")
    '''

    real_pop = []

    for ind in pop:
        temp1 = ind[:9]
        temp2 = ind[9:]
        real_pop += [temp1]
        real_pop += [temp2]

    cluster = ClusterProceduralWeapon(real_pop, pop, cluster_file)
    cluster.cluster()



main()