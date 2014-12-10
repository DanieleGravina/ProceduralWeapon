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

creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, -1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

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
RANGE_MIN, RANGE_MAX = 10, 100000

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

limits = [(ROF_MIN, ROF_MAX), (SPREAD_MIN, SPREAD_MAX), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN, RANGE_MAX),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX)]


N_CYCLES = 1
# size of the population
NUM_POP = NUM_BOTS*NUM_SERVER

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
    print("\n")
    for ind in pop :
        print("Weapon "+ " Rof:" + "{0:.2f}".format(ind[0]/100) + " Spread:" + "{0:.2f}".format(ind[1]/10) + " MaxAmmo:" + "{0:.2f}".format(ind[2]) 
            + " ShotCost:" + "{0:.2f}".format(ind[3]) + " Range:" + "{0:.2f}".format(ind[4]) )
        print("Projectile "+ " Speed:" + "{0:.2f}".format(ind[5]) + " Damage:" + "{0:.2f}".format(ind[6]) + " DamageRadius:" + "{0:.2f}".format(ind[7])
            + " Gravity:" + "{0:.2f}".format(ind[8]) )
        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    pop_file.write("\n")
    for ind in pop :
        pop_file.write("Weapon "+ " Rof:" + "{0:.2f}".format(ind[0]/100) + " Spread:" + "{0:.2f}".format(ind[1]/10) + " MaxAmmo:" + "{0:.2f}".format(ind[2]) 
            + " ShotCost:" + "{0:.2f}".format(ind[3]) + " Range:" + "{0:.2f}".format(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + "{0:.2f}".format(ind[5]) + " Damage:" + "{0:.2f}".format(ind[6]) + " DamageRadius:" + "{0:.2f}".format(ind[7])
            + " Gravity:" + "{0:.2f}".format(ind[8]) + "\n")
        pop_file.write("fitness: " + str(ind.fitness.values) + "\n")
        pop_file.write("*********************************************************" + "\n")



def check_param(param, min, max):

    if param < min :
        param = min
    elif param > max :
        param = max

def check(param, n) :

    check_param(param, limits[n][0], limits[n][1])

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

# Run the simulation on the server side (UDK)
def simulate_population(population, statics) :

    stats = {}
    threads = []

    for i in range(NUM_SERVER):
        threads.append( myThread(i*2, "Thread-" + str(i), population, statics, PORT[i]) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def entropy(index, statics) :

    e = 0

    total_kills = 0
    total_dies = 0

    ind = index if index % 2 == 0 else index - 1

    for key, val in statics.items():
        if key >= ind and key < ind + NUM_BOTS :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(ind, ind + NUM_BOTS):
        e += evaluate_entropy(i, statics, total_kills, total_dies, NUM_BOTS)

    if index == ind :

        suicides = statics[index][1] - statics[index + 1][0]

    else :

        suicides = statics[index - 1][1] - statics[index][0]

    return e, suicides


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

def evaluate_difference(index, population):

    ind = index if index % 2 == 0 else index - 1

    diff = 0

    for j in range(9):
        den = limits[j][1] - limits[j][0]
        norm1 = (population[ind][j] - limits[j][0])/den
        norm2 = (population[ind + 1][j] - limits[j][0])/den
        diff += pow(norm1 - norm2, 2)

    result = sqrt(diff)

    return result

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e, suicides = entropy(index, statics)
    #e = random.randint(0,2)
    diff = evaluate_difference(index, population)
    
    print('entropy :' + str(index) + " " + str(e))
    print('difference :' + str(index) + " " + str(diff))
    print('suicides :' + str(index) + " " + str(suicides))

    return e, diff, suicides


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutUniformInt, low = [limits[j][0] for j in range(9)],
                                                up  = [limits[j][1] for j in range(9)], 
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

mstats = tools.MultiStatistics(entropy = stats1, diff = stats2, suicides = stats3)

logbook = tools.Logbook()

def main():

    pop_file = open("population.txt", "w")
    logbook_file = open("logbook.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    CXPB, MUTPB, NGEN = 0.5, 0.2, 40 #20 is 1h

    fitnesses = []
    statics = {}

    initialize_server()

    statics = simulate_population(pop, statics)

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit


    record = mstats.compile(pop)

    logbook.record(gen = 0, **record)

    logbook.header = "gen", "entropy", "diff", "suicides"
    logbook.chapters["entropy"].header = "avg", "max"
    logbook.chapters["diff"].header = "avg", "max"
    logbook.chapters["suicides"].header = "avg", "min"

    print(logbook)

    printWeapon(pop)
    writeWeapon(pop, pop_file)

    for g in range(NGEN - 1):

        # Elitism : 2 individuals
        offspring = toolbox.select(pop, 2)

        # Clone the selected individuals
        offspring = list(map(toolbox.clone, offspring))

        while len(offspring) < len(pop) :

           child1 = toolbox.clone(toolbox.select(pop, 1))
           child2 = toolbox.clone(toolbox.select(pop, 1))

           if random.random() < CXPB:
               toolbox.mate(child1[0], child2[0])
               del child1[0].fitness.values
               del child2[0].fitness.values

           if random.random() < MUTPB:
               toolbox.mutate(child1[0])
               toolbox.mutate(child2[0])

           offspring += child1
           offspring += child2

        statics = simulate_population(offspring, statics)

        fit = 0, 0, 0

        for individual in offspring:
           del individual.fitness.values

        for i in range(len(offspring)) :
           fit = toolbox.evaluate(i, offspring, statics)
           fitnesses += [fit]
           offspring[i].fitness.values = fit

        # The population is entirely replaced by the offspring
        pop[:] = offspring

        printWeapon(pop)
        writeWeapon(pop, pop_file)

        record = mstats.compile(pop)

        logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "diff", "suicides"
        logbook.chapters["entropy"].header = "avg", "max"
        logbook.chapters["diff"].header = "avg", "max"
        logbook.chapters["suicides"].header = "avg", "min"

        print(logbook)


    logbook.header = "gen", "entropy", "diff", "suicides"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["diff"].header = "min", "avg", "max"
    logbook.chapters["suicides"].header = "min", "avg", "max"
    
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

    fit_avg = logbook.chapters["suicides"].select("avg")
    fit_max = logbook.chapters["suicides"].select("max")
    fit_min = logbook.chapters["suicides"].select("min")

    plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

    plt.xlabel("Generation")
    plt.ylabel("Suicides")

    plt.show()


main()