import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from Costants import NUM_BOTS
from Costants import NUM_SERVER
from Costants import PORT
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
SHOT_COST_MIN, SHOT_COST_MAX = 1, 999
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

toolbox.decorate("attr_rof", round_decorator(0,1))
toolbox.decorate("attr_spread", round_decorator(0,1))
toolbox.decorate("attr_range", round_decorator(0,1))
toolbox.decorate("attr_gravity", round_decorator(0,1))

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                  toolbox.attr_shot_cost, toolbox.attr_range, toolbox.attr_speed,
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity ), n = N_CYCLES)

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

    return result

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e = entropy(index*2, statics)
    #e, tot_kills = random.randint(0,2), random.randint(0,25)
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

toolbox.register("select", tools.selTournament, tournsize = 3)

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

def main():

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 20 #160 min

    fitnesses = []
    statics = {}

    initialize_server()

    statics = simulate_population(pop)

    for key, val in statics.items():
        logbook_file.write(str(key) + " : " + str(val) + "\n")

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit


    record = mstats.compile(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "diff", "kills"
    logbook.chapters["entropy"].header = "avg", "max"
    logbook.chapters["diff"].header = "avg", "max"
    logbook.chapters["kills"].header = "avg", "max"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

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

        for key, val in statics.items():
            logbook_file.write(str(key) + " : " + str(val) + "\n")

        fitnesses = []

        # Evaluate only invalid population
        index = 0
        fit = 0,
        while index < len(offspring):

            if not offspring[index].fitness.valid :
                fit = toolbox.evaluate(index, offspring, statics)
                fitnesses += [fit]
                offspring[index].fitness.values = fit

            index += 1
        # The population is entirely replaced by the offspring
        pop[:] = offspring

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)

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

    plt.show()


main()