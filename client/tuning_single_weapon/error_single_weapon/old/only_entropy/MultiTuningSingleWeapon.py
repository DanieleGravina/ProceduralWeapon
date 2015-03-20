import os,sys,inspect
os.chdir("..")
os.chdir("..")
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0,parentdir) 

import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import threading


from decimal import *
from functools import partial
from operator import attrgetter

from Costants import *

from BalancedWeaponClient import BalancedWeaponClient
from SimulationThread import SimulationThread

from math import log
from math import pow
from math import sqrt

from deap import base
from deap import creator
from deap import tools

#####################################################################

#################
#GA PARAMETERS###
#################

DEBUG = False

NUM_PAR = 10

# size of the population
NUM_POP = 500

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

#crossover (0.6 -1), mutation prob (1/nreal)
#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.9, 0.1, 50 #160 min

#eta c (5-50), eta_m (5-20)
ETA_C, ETA_M = 20, 20

weight_obj_1 = MINIMIZE

GOAL_SCORE = 40


N_CYCLES = 2

#####################################################################

creator.create("FitnessMax", base.Fitness, weights = (1.0, weight_obj_1))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN/100, GRAVITY_MAX/100), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

Weapon_Fixed = [1.05,  0.1,     30,      1,     8, 1350, 100,       42,      0, 220]

Weapon_Target = [1.1,   0.1,   30,      9,     2, 3500,  18,       20,      0, 0]


N_CYCLES = 1

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
toolbox.register("attr_explosive", random.randint, EXPLOSIVE_MIN, EXPLOSIVE_MAX)

toolbox.decorate("attr_rof", round_decorator(0,1))
toolbox.decorate("attr_spread", round_decorator(0,1))
toolbox.decorate("attr_range", round_decorator(0,1))
toolbox.decorate("attr_gravity", round_decorator(0,1))

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                  toolbox.attr_shot_cost, toolbox.attr_range, toolbox.attr_speed,
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity, toolbox.attr_explosive ), n = 1)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def printWeapon(pop):
    i = 0
    for ind in pop :
        print("(" + str(i) + ")")
        i += 1
        print("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) )

        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    i = 0
    for ind in pop :
        pop_file.write("(" + str(i) + ")\n")
        i += 1
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) +"\n")

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

def difference(index, pop) :

    total = 0
    diff = 0

    for j in range(10):
        norm1 = (pop[index][j] - limits[j][0])/(limits[j][1] - limits[j][0])
        norm2 = (Weapon_Target[j] - limits[j][0])/(limits[j][1] - limits[j][0])
        total = norm1 - norm2
        diff += pow(norm1 - norm2, 2)

    return sqrt(diff)

def match_suicides(kills, dies):
    return (dies[0] - kills[1])/2

def eval_entropy(kills, dies):

    p = 0
    e = 0

    total = sum(kills)

    for d in kills:
        p = d/total if total != 0 else 0
        e += p*log(p, NUM_BOTS) if p != 0 else 0

    return -e + total/(GOAL_SCORE) + pow(9/10, match_suicides(kills, dies))


toolbox.register("select", tools.selNSGA2)

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

mstats = tools.MultiStatistics(entropy = stats1, diff = stats2)

logbook = tools.Logbook()

hof = tools.ParetoFront()

def getPopulationData(pop):

    line_readed = 0
    index = 0
    temp = []

    population_file = open("population.txt", "r")
    logbook_file = open("logbook.txt", "r")

    content = population_file.readlines()

    for string in content:
        
        if "Weapon" in string or "Projectile" in string:
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if ":" in splitted:
                    split_colon = splitted.split(":")
                    temp += [float(split_colon[1])]
                    if (len(temp) == 10):
                        for i in range(10):
                            pop[index][i] = temp[i]
                        temp = []

                        index += 1
                        if index == NUM_POP:
                            break

        line_readed += 1


    content = logbook_file.readlines()

    kills = [[] for _ in range(NUM_POP)]
    dies = [[] for _ in range(NUM_POP)]

    for string in content:
        
        if "(" in string:
            split_spaces = string.split(" ")

            weap_index = int(split_spaces[0])

            if weap_index % 2 == 0:
                kill = split_spaces[2]
                kill = kill.replace("(", "")
                kill = kill.replace(",", "")
                kills[int(weap_index/2)] += [int(kill)]

                die = split_spaces[3]
                die = die.replace("(", "")
                die = die.replace(",", "")
                dies[int(weap_index/2)] += [int(die)]
            else :
                weap_index -= 1
                kill = split_spaces[2]
                kill = kill.replace("(", "")
                kill = kill.replace(",", "")
                kills[int(weap_index/2)] += [int(kill)]

                die = split_spaces[3]
                die = die.replace("(", "")
                die = die.replace(",", "")
                dies[int(weap_index/2)] += [int(die)]

    for i in range(len(kills)):

        pop[i].fitness.values = eval_entropy(kills[i], dies[i]), difference(i ,pop)

    entropy = []
    index = []

    for i in range(NUM_POP):
        index += [i]
        for j in range(i + 1, NUM_POP):
            equal = True
            for k in range(NUM_PAR):
                if pop[i][k] != pop[j][k]:
                    equal = False
                    break
            if equal:
                entropy += [pop[i].fitness.values[0], pop[j].fitness.values[0]]
                index += [j]

        if len(entropy) != 0:
            mean_entropy = sum(entropy)/len(entropy)
            for ind in index:
                pop[ind].fitness.values = mean_entropy, pop[ind].fitness.values[1]

        entropy = []
        index = []

    return pop






def TuningSingleWeapon(iter = 0):

    os.chdir("final_simulation_final")
    os.chdir("only_entropy")

    #clone initial port definition
    port = INITIAL_PORT[:]

    pop_file = open("population_new.txt", "w")
    logbook_file = open("logbook_new.txt", "w")

    pop = toolbox.population(n = NUM_POP)

    pop = getPopulationData(pop)

    printWeapon(pop)

    fitnesses = []

    #pop[:] = toolbox.select(pop, MU)

    record = mstats.compile(pop)
    hof.update(pop)

    logbook.record(gen = 0, evals = len(pop), **record)

    logbook.header = "gen", "evals", "entropy", "diff"
    logbook.chapters["entropy"].header = "min", "avg", "max"
    logbook.chapters["diff"].header = "min", "avg", "max"

    print(logbook)

    #pop.sort(key=lambda x: x.fitness.values)

    printWeapon(pop)
    writeWeapon(pop, pop_file)
    
    log_string = str(logbook)

    logbook_file.write(log_string)

    print("Best individuals:")
    printWeapon(hof)
    pop_file.write("Best individuals:\n")
    writeWeapon(hof, pop_file)

    pop_file.close()
    logbook_file.close()

    #################################################################################

    ##########################
    ##plot multiobjective ####
    ##########################

    plt.figure(figsize = (16,9))

    e = [pop[i].fitness.values[0] for i in range(len(pop))]
    d = [pop[i].fitness.values[1] for i in range(len(pop))]

    e_front = [hof[i].fitness.values[0] for i in range(len(hof))]
    d_front = [hof[i].fitness.values[1] for i in range(len(hof))]

    plt.xlabel("Entropy")
    plt.ylabel("Difference")

    plt.scatter(e, d)
    plt.scatter(e_front, d_front, c=u'r')
    plt.plot(e_front, d_front)

    plt.savefig("pareto.png", bbox_inches='tight', dpi = 200)
    plt.close()
    ##########################################################################


if __name__ == '__main__':
    TuningSingleWeapon()
