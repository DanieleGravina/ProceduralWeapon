from deap import base
from deap import creator
from deap import tools

import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import threading

import os


creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, 1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

toolbox.register("individual", tools.initCycle, creator.Individual, [lambda : 0 for _ in range(20)], n = 1)

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

#num of final population
NUM_POPs = 10


NUM_POP = 100

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

def getPopulationData() :

	populations = []

	os.chdir("..")

	for index in range(NUM_POPs):

		pop = toolbox.population(NUM_POP)

		os.chdir("distance_vs_kill_streak_100_pop_50_iter_simulated_binary_new_" + str(index + 1))

		pop_file = open("population_cluster.txt", "r")

		content = pop_file.readlines()

		temp = []

		index_pop = 0

		for string in content:
			
			if "Weapon" in string or "Projectile" in string:
				split_spaces = string.split(" ")

				for splitted in split_spaces:
					if ":" in splitted:
						split_colon = splitted.split(":")
						temp += [float(split_colon[1])]
						if (len(temp) == 20):
							for i in range(20):
							    pop[index_pop][i] = temp[i]
							temp = []

			if "fitness" in string :
				split_spaces = string.split(" ")
				temp_fit = []
				index_fit = 0

				for splitted in split_spaces:

					if index_fit > 0 and index_fit < 4:
						splitted = splitted.replace("(", "")
						splitted = splitted.replace(")", "")
						splitted = splitted.replace(",", "")
						splitted = splitted.replace("\n", "")
						try :
							temp_fit += [float(splitted)]
						except :
							print("splitted :"  + str(splitted))

					index_fit += 1

				pop[index_pop].fitness.values = temp_fit[0], temp_fit[1], temp_fit[2]
				index_pop += 1

		populations += [pop]

		pop_file.close()

		os.chdir("..")

	return populations

def getPareto(population):

	hof = tools.ParetoFront()

	hof.update(population)

	return hof

def plot_pareto(hof, pop):

	os.chdir("pareto_of_pareto_multi")

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

	plt.xlabel("Objective1")
	plt.ylabel("Entropy")

	plt.subplot(222)

	plt.scatter([pop[i].fitness.values[2] for i in range(len(pop))], [pop[i].fitness.values[0] for i in range(len(pop))])
	plt.scatter([hof_13[i].fitness.values[2] for i in range(len(hof_13))], [hof_13[i].fitness.values[0] for i in range(len(hof_13))], c=u'r')
	plt.plot([hof_13[i].fitness.values[2] for i in range(len(hof_13))], [hof_13[i].fitness.values[0] for i in range(len(hof_13))])

	plt.xlabel("Objective2")
	plt.ylabel("Entropy")

	plt.subplot(224)

	plt.scatter([pop[i].fitness.values[2] for i in range(len(pop))], [pop[i].fitness.values[1] for i in range(len(pop))])
	plt.scatter([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))], c=u'r')
	plt.plot([hof_23[i].fitness.values[2] for i in range(len(hof_23))], [hof_23[i].fitness.values[1] for i in range(len(hof_23))])

	plt.xlabel("Objective2")
	plt.ylabel("Objective1")

	plt.savefig("pareto_of_pareto_multi.png", bbox_inches='tight')

	plt.close()


def ParetoOfPareto():

	pareto_file = open("pareto_of_pareto_multi.txt", "w")
	population_file = open("population_cluster.txt", "w")

	paretos = []

	pareto_of_pareto = tools.ParetoFront()

	populations = getPopulationData()

	for i in range(NUM_POPs):

		pareto = getPareto(populations[i])

		paretos += pareto

		pareto_of_pareto.update(pareto)

	#print(paretos)

	writeWeapon(paretos, pareto_file)

	pareto_file.write("Pareto of Pareto:" + "\n")

	writeWeapon(pareto_of_pareto, pareto_file)

	pareto_file.close()

	union_population = []

	for i in range(len(populations)) :
		union_population += populations[i]

	plot_pareto(pareto_of_pareto, paretos)

	writeWeapon(union_population, population_file)
	population_file.close()



if __name__ == '__main__':
    ParetoOfPareto()


