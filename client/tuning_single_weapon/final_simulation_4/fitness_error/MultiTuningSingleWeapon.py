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
NUM_POP = 50

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


def getPopulationData(pop):

    index = 0
    temp = []

    diff = [0 for _ in range(NUM_POP)]

    population_file = open("population_original.txt", "r")
    population_file_new = open("population_new.txt", "r")

    content = population_file.readlines()
    content_new = population_file_new.readlines()

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

        if "fitness" in string :
            split_spaces = string.split(" ")
            temp_fit = []

            for splitted in split_spaces:
                if "(" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    fit = float(splitted)
                    temp_fit += [fit]
                if ")" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    dist = float(splitted)
                    temp_fit += [dist]

            pop[index].fitness.values = temp_fit[0], temp_fit[1]
            index += 1
            if index == NUM_POP:
                break

    index = 0

    for string in content_new:
        
        if "Weapon" in string or "Projectile" in string:
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if ":" in splitted:
                    split_colon = splitted.split(":")
                    temp += [float(split_colon[1])]
                    if (len(temp) == 10):
                        temp = []

        if "fitness" in string :
            split_spaces = string.split(" ")
            temp_fit = []

            for splitted in split_spaces:
                if "(" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    fit = float(splitted)
                    temp_fit += [fit]
                if ")" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    dist = float(splitted)
                    temp_fit += [dist]

            diff[index] = pop[index].fitness.values[1]
            pop[index].fitness.values = pop[index].fitness.values[0], temp_fit[0]
            index += 1
            if index == NUM_POP:
                break

    pop_sorted = toolbox.clone(pop)
    for index in range(NUM_POP):
        pop_sorted[index].fitness.values = numpy.std([pop[index].fitness.values[1], pop[index].fitness.values[0]]), diff[index]
    pop_sorted.sort(key=lambda x: x.fitness.values[1])

    return pop, pop_sorted



def TuningSingleWeapon(iter = 0):

    os.chdir("final_simulation_4")
    os.chdir("fitness_error")

    pop = toolbox.population(n = NUM_POP)

    pop, pop_sorted = getPopulationData(pop)

    plt.figure(figsize = (16,9))

    plt.xlabel("population")
    plt.ylabel("Difference Entropy")

    plt.plot([i for i in range(NUM_POP)], [pop[i].fitness.values[0] for i in range(NUM_POP)])
    plt.plot([i for i in range(NUM_POP)], [pop[i].fitness.values[1] for i in range(NUM_POP)], "r")
    plt.show()
    #return
    #plt.errorbar([i for i in range(NUM_POP)], [numpy.mean([pop[i].fitness.values[0], 
    #    pop[i].fitness.values[1]]) for i in range(NUM_POP)], yerr = [numpy.std([pop[i].fitness.values[0], 
    #    pop[i].fitness.values[1]]) for i in range(NUM_POP)], fmt='-o')

    #plt.ylim(0, 4)

    #p = 0

    #plt.errorbar([i for i in range(50)], [numpy.mean([pop[i].fitness.values[0], pop[i].fitness.values[1]])  for i in range(p*50, (p+1)*50)], 
    #       yerr = [numpy.std([pop[i].fitness.values[0], pop[i].fitness.values[1]]) for i in range(p*50, (p+1)*50) ])

    for p in range(1) :

        plt.subplot(430 + p)

        plt.ylim(0, 3.5)

    #plt.plot([i for i in range(NUM_POP)], [abs(pop[i].fitness.values[0] - pop[i].fitness.values[1]) for i in range(NUM_POP)])
    #plt.plot([i for i in range(100)], [abs(pop[i].fitness.values[0] - pop[i].fitness.values[1]) for i in range(100)])
    #plt.plot([i for i in range(100)], [abs(abs(pop[i].fitness.values[0] - pop[i].fitness.values[1]) - (3 - pop[i].fitness.values[0])) for i in range(100)], "r")
        plt.errorbar([i for i in range(50)], [pop[i].fitness.values[1]  for i in range(p*50, (p+1)*50)], 
           yerr = [abs(pop[i].fitness.values[1] - pop[i].fitness.values[0]) for i in range(p*50, (p+1)*50) ])

    plt.savefig("diff entropy.png", bbox_inches='tight', dpi = 200)
    plt.close()
    ##########################################################################

    plt.figure(figsize = (16,9))

    plt.xlabel("population")
    plt.ylabel("Difference Entropy")
    plt.subplot(211)
    plt.plot([i for i in range(NUM_POP)], [pop_sorted[i].fitness.values[0] for i in range(NUM_POP)])
    plt.subplot(212)
    plt.plot([i for i in range(NUM_POP)], [pop_sorted[i].fitness.values[1] for i in range(NUM_POP)], "r")
    plt.savefig("diff sorted entropy.png", bbox_inches='tight', dpi = 200)
    plt.close()

    plt.figure(figsize = (16,9))

    plt.xlabel("population")
    plt.ylabel("Difference Entropy")
    plt.subplot(211)
    plt.plot([i for i in range(10)], [pop_sorted[i].fitness.values[0] for i in range(10)])
    plt.subplot(212)
    plt.plot([i for i in range(10)], [pop_sorted[i].fitness.values[1] for i in range(10)], "r")
    plt.savefig("diff sorted entropy zoomed.png", bbox_inches='tight', dpi = 200)
    plt.close()


if __name__ == '__main__':
    TuningSingleWeapon()
