import os,sys,inspect
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


from deap import base
from deap import creator
from deap import tools

#####################################################################

#################
#GA PARAMETERS###
#################


# size of the population
NUM_POP = 50

#:param mu: The number of individuals to select for the next generation.
#:param lambda\_: The number of children to produce at each generation.
LAMBDA = NUM_POP
MU = NUM_POP

#crossover (0.6 -1), mutation prob (1/nreal)
#crossover probability, mutation probability, number of generation
CXPB, MUTPB, NGEN = 0.6, 0.1, 50 #160 min

#eta c (5-50), eta_m (5-20)
ETA_C, ETA_M = 20, 50

weight_obj_1 = -1


N_CYCLES = 2

#####################################################################

creator.create("FitnessMax", base.Fitness, weights = (1.0, weight_obj_1))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

toolbox.register("individual", tools.initCycle, creator.Individual, [lambda : 0 for _ in range(10)], n = 1)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

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


def getPOP(pop, content):

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
                    if (len(temp) == 10):
                        for i in range(10):
                            pop[index][i] = temp[i]
                        temp = []

        if "fitness" in string :
            split_spaces = string.split(" ")

            for splitted in split_spaces:
                if "(" in splitted and not ")" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    fit = float(splitted)
                    temp_fit = fit

                if ")" in splitted and not "(" in splitted:
                    splitted = splitted.replace("(", "")
                    splitted = splitted.replace(")", "")
                    splitted = splitted.replace(",", "")
                    splitted = splitted.replace("\n", "")
                    fit = float(splitted)
                    pop[index].fitness.values = temp_fit, fit

                    index += 1

                    if index == NUM_POP:
                        return pop, content[line_readed + 1:]

        line_readed += 1



def main():
        logbook_file = open("logbook_final.txt", "w")
        pop_file = open("population.txt", "r")
        best_ind = open("best.txt", "w")
        population_cluster = open("population_cluster.txt", "w")

        content = pop_file.readlines()

        pop = toolbox.population(NUM_POP)

        pop, content = getPOP(pop, content)

        pop, content = getPOP(pop, content)

        record = mstats.compile(pop)
        hof.update(pop)

        logbook.record(gen = 0, **record)

        for g in range(NGEN - 1):

            print(len(content))

            pop, content = getPOP(pop, content)

            record = mstats.compile(pop)
            hof.update(pop)

            logbook.record(gen = g + 1, **record)

        logbook.header = "gen", "entropy", "diff"
        logbook.chapters["entropy"].header = "min", "avg", "max"
        logbook.chapters["diff"].header = "min", "avg", "max"

        log_string = str(logbook)

        logbook_file.write(log_string)

        writeWeapon(pop, population_cluster)

        best_ind.write("Best individuals:\n")
        writeWeapon(hof, best_ind)

        best_ind.close()

        pop_file.close()

        #################################################################################

        ############################################
        ###plot min, avg, max of singles objectives#
        ############################################

        plt.figure(1)

        plt.subplot(211)

        gen = logbook.select("gen")
        fit_avg = logbook.chapters["entropy"].select("avg")
        fit_max = logbook.chapters["entropy"].select("max")
        fit_min = logbook.chapters["entropy"].select("min")

        plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

        plt.xlabel("Generation")
        plt.ylabel("Entropy")

        plt.subplot(212)

        fit_avg = logbook.chapters["diff"].select("avg")
        fit_max = logbook.chapters["diff"].select("max")
        fit_min = logbook.chapters["diff"].select("min")

        plt.plot(gen, fit_avg, 'r--', gen, fit_max, 'b-', gen, fit_min, 'g')

        plt.xlabel("Generation")
        plt.ylabel("Difference Target Weapon")

        plt.savefig("graph.png", bbox_inches='tight')

        ##########################################################################

        ##########################
        ##plot multiobjective ####
        ##########################

        plt.figure(2)

        e = [pop[i].fitness.values[0] for i in range(len(pop))]
        d = [pop[i].fitness.values[1] for i in range(len(pop))]

        e_front = [hof[i].fitness.values[0] for i in range(len(hof))]
        d_front = [hof[i].fitness.values[1] for i in range(len(hof))]

        plt.xlabel("Entropy")
        plt.ylabel("Difference")

        plt.scatter(e, d)
        plt.scatter(e_front, d_front, c=u'r')
        plt.plot(e_front, d_front)

        plt.savefig("pareto.png", bbox_inches='tight')
        ##########################################################################

if __name__ == '__main__':
    main()

	





