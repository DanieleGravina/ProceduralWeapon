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


creator.create("FitnessMax", base.Fitness, weights = (1.0, -1.0))
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

	logbooks = []
	best_weapons = []
	pops = []

	os.chdir("..")

	for index in range(NUM_POPs):

		pop = toolbox.population(NUM_POP)

		logbook = tools.Logbook()

		stats = tools.Statistics(key=lambda ind: ind.fitness.values)

		stats.register("avg", numpy.mean)
		stats.register("std", numpy.std)
		stats.register("min", numpy.min)
		stats.register("max", numpy.max)

		os.chdir("single_objective_100_pop_50_iter_simulated_binary_final_" + str(index + 1))

		pop_file = open("population.txt", "r")

		content = pop_file.readlines()

		temp = []

		index_pop = 0
		gen = 0
		bIsFirst = True
		fit = 0

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

				for splitted in split_spaces:
					if "(" in splitted and not bIsFirst:
						splitted = splitted.replace("(", "")
						splitted = splitted.replace(")", "")
						splitted = splitted.replace(",", "")
						splitted = splitted.replace("\n", "")
						fit = float(splitted)

				if not bIsFirst:
					pop[index_pop].fitness.values = fit,

					if pop[index_pop].fitness.values[0] == 3 and gen == 49:
							best_weapons += [ pop[index_pop] ]

				index_pop += 1

				if index_pop == NUM_POP :

					if not bIsFirst :
						record = stats.compile(pop)
						logbook.header = "gen", "avg", "std", "min", "max"
						logbook.record(gen = gen, **record)
						gen += 1
					else :
						bIsFirst = False

					index_pop = 0


		logbook.header = "gen", "avg", "std", "min", "max"

		pops += [pop]

		logbooks += [logbook]

		pop_file.close()

		os.chdir("..")

	return logbooks, best_weapons, pops


def plot_avg(gen, fit_avg, fit_std):

	plt.figure(figsize=(16, 9))

	print(gen)

	print(fit_avg)

	print(fit_std)

	plt.errorbar(gen, fit_avg, yerr = fit_std, fmt='-o')
	plt.ylim(0, 3.5)

	plt.xlabel("Generation")
	plt.ylabel("Entropy")

	plt.savefig("avg_of_avg.png", bbox_inches='tight')

	plt.close()

def plot_max(gen, fit_avg, fit_std):

	plt.figure(figsize=(16, 9))

	plt.errorbar(gen, fit_avg, yerr = fit_std, fmt='-o')
	plt.ylim(0, 3.5)

	plt.xlabel("Generation")
	plt.ylabel("Entropy")

	plt.savefig("avg_of_max.png", bbox_inches='tight')

	plt.close()


def  AverageOfAverage():

	avg_file = open("avg_of_avg.txt", "w")
	best_pop_file = open("population_cluster.txt", "w")
	population_file = open("population.txt", "w")

	fit_avgs = []

	fit_maxs = []

	logbooks = []
	best_weapons = []

	logbooks, best_weapons, pops = getPopulationData()

	final_population = []

	for i in range(len(pops)):
		final_population += pops[i]

	writeWeapon(final_population, population_file)

	population_file.close()

	gen = logbooks[0].select("gen")

	for i in range(NUM_POPs):

		print(logbooks[i])

		fit_avgs += [logbooks[i].select("avg")]

		fit_maxs += [logbooks[i].select("max")]

	writeWeapon(best_weapons, best_pop_file)

	os.chdir("avg_single_objective")

	plot_avg(gen, numpy.mean(fit_avgs, axis = 0), numpy.std(fit_avgs, axis = 0))

	plot_max(gen, numpy.mean(fit_maxs, axis = 0), numpy.std(fit_maxs, axis = 0))

	avg = numpy.mean(fit_avgs, axis = 0)
	std = numpy.std(fit_avgs, axis = 0)

	avg_file.write("Average:" + "\n")

	for i in range(len(avg)) :
		avg_file.write( "gen " + str(i) + " " + str(avg[i]) + "\n" )

	avg_file.write("Standard Deviation:" + "\n")

	for i in range(len(std)) :
		avg_file.write( "gen " + str(i) + " " + str(std[i]) + "\n" )

	avg_file.close()
	best_pop_file.close()



if __name__ == '__main__':
    AverageOfAverage()


