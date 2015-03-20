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

NUM_PAR = 20

# size of the population
NUM_POP = 1000

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

creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, 1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN/100, GRAVITY_MAX/100), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]


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
                  toolbox.attr_dmg, toolbox.attr_dmg_rad, toolbox.attr_gravity, toolbox.attr_explosive ), n = 2)

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

def match_suicides(kills, dies):
    return (dies[0] - kills[1]) + (dies[1] - kills[0])

def eval_entropy(kills, dies):

    for i in range(len(kills)):
        kills[i] /= 2
        dies[i] /= 2

    p = 0
    e = 0

    total = sum(kills)

    for d in kills:
        p = d/total if total != 0 else 0
        e += p*log(p, NUM_BOTS) if p != 0 else 0

    return -e + total/(GOAL_SCORE/2) + pow(9/10, match_suicides(kills, dies))

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
                    if (len(temp) == NUM_PAR):
                        for i in range(NUM_PAR):
                            pop[index][i] = temp[i]
                        temp = []

                        index += 1
                        if index == NUM_POP:
                            break

        line_readed += 1


    content = logbook_file.readlines()

    kills = [[] for _ in range(NUM_POP)]
    dies = [[] for _ in range(NUM_POP)]

    dists = [[] for _ in range(NUM_POP)]
    streaks = [[] for _ in range(NUM_POP)]


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
                dies[int(weap_index/2)] += [float(die)]

                dist = split_spaces[4]
                dist = dist.replace("(", "")
                dist = dist.replace(",", "")
                dists[int(weap_index/2)] = float(dist)

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

                streak = split_spaces[5]
                streak = streak.replace("(", "")
                streak = streak.replace(")", "")
                streak = streak.replace("\n", "")
                streak = streak.replace(",", "")
                streaks[int(weap_index/2)] = float(streak)

    for i in range(NUM_POP):

        pop[i].fitness.values = eval_entropy(kills[i], dies[i]), dists[i], streaks[i]

    '''

    entropy = []
    index = []
    dists = []
    streaks = []

    for i in range(NUM_POP):
        index += [i]
        entropy += [pop[i].fitness.values[0]]
        dists += [pop[i].fitness.values[1]]
        streaks += [pop[i].fitness.values[2]]

        for j in range(i + 1, NUM_POP):
            for k in range(NUM_PAR):
                if pop[i][k] != pop[j][k]:
                    break
                entropy += [pop[j].fitness.values[0]]
                dists += [pop[j].fitness.values[1]]
                streaks += [pop[j].fitness.values[2]]
                index += [j]

        if len(entropy) != 1:
            mean_entropy = sum(entropy)/len(entropy)
            mean_dists = sum(dists)/len(dists)
            mean_streaks = sum(streaks)/len(streaks)

            for ind in index:
                pop[ind].fitness.values = mean_entropy, mean_dists, mean_streaks

        entropy = []
        index = []
        dists = []
        streaks = []
    '''

    return pop


def TuningSingleWeapon(iter = 0):

    os.chdir("final_simulation_multi_obj_final")
    os.chdir("only_entropy")

    best_file = open("best.txt", "w")

    pop_file = open("population_new.txt", "w")

    hof = tools.ParetoFront()

    pop = toolbox.population(n = NUM_POP)

    pop = getPopulationData(pop)

    hof.update(pop)

    writeWeapon(pop, pop_file)

    best_file.write("Best individuals:\n")
    writeWeapon(hof, best_file)

    pop_file.close()

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

    plt.xlabel("Distance")
    plt.ylabel("Balance")

    plt.subplot(224)

    plt.scatter([pop[i].fitness.values[2] for i in range(len(pop))], [pop[i].fitness.values[1] for i in range(len(pop))])
    plt.scatter([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))], c=u'r')
    plt.plot([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))])

    plt.xlabel("Distance")
    plt.ylabel("Hit Time")

    plt.savefig("pareto_of_pareto_multi.png", bbox_inches='tight')

    plt.close()
    ##########################################################################


if __name__ == '__main__':
    TuningSingleWeapon()
